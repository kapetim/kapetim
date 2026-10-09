#!/usr/bin/env bash
# Regenerate the fixed repo-status table in the profile README and open/update a PR.
# Never pushes to the profile's main — the change always lands as a PR.
#
# The order is explicit (scripts/profile/repos.txt), not discovered, so slots stay
# stable and empty slots (0-9) render as `—`. More than 10 repos is an error:
# append to an existing repo instead of adding an 11th.
#
# usage: [STATUS_OWNER=kapetim] [STATUS_TARGET_REPO=kapetim/kapetim] \
#          [STATUS_TOKEN=...] bash scripts/profile/refresh.sh
set -euo pipefail

OWNER="${STATUS_OWNER:-kapetim}"
TARGET_REPO="${STATUS_TARGET_REPO:-${OWNER}/kapetim}"
TOKEN="${STATUS_TOKEN:-${GH_TOKEN:-}}"
PR_BRANCH="${STATUS_PR_BRANCH:-chore/repo-status}"
PR_TITLE="${STATUS_PR_TITLE:-chore: refresh repo status}"
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPOS_FILE="${STATUS_REPOS_FILE:-${HERE}/repos.txt}"

if [[ -n "$TOKEN" ]]; then
  export GH_TOKEN="$TOKEN"
fi

if [[ ! -f "$REPOS_FILE" ]]; then
  echo "order map not found: ${REPOS_FILE}" >&2
  exit 1
fi

declare -A SLOTS=()
count=0
while IFS='|' read -r idx repo label; do
  [[ "$idx" =~ ^[[:space:]]*# ]] && continue
  [[ -z "${idx//[[:space:]]/}" ]] && continue
  repo="${repo//[[:space:]]/}"
  [[ -z "$repo" ]] && continue
  SLOTS["$idx"]="${repo}|${label:-$repo}"
  count=$((count + 1))
done <"$REPOS_FILE"

if (( count > 11 )); then
  echo "::error::repo cap exceeded: ${count} repos (max 11 — the -1 vault plus slots 0-9). Append to an existing repo instead of adding a new one." >&2
  exit 1
fi

# repo_date <repo> — YYYY-MM-DD of the last commit, or — when unavailable
repo_date() {
  local out=""
  out="$(gh api "repos/${OWNER}/$1/commits" --jq '.[0].commit.committer.date[0:10]' 2>/dev/null)" || true
  if [[ "$out" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
    echo "$out"
  else
    echo "—"
  fi
}

# repo_ci <repo> — 🟢 when HEAD has a success and no failure, else —
repo_ci() {
  local repo="$1" sha conclusions successes bad
  sha="$(gh api "repos/${OWNER}/${repo}/commits" --jq '.[0].sha' 2>/dev/null || true)"
  if [[ -z "$sha" ]]; then
    echo "—"
    return
  fi
  conclusions="$(gh api "repos/${OWNER}/${repo}/commits/${sha}/check-runs" --jq '[.check_runs[].conclusion]' 2>/dev/null || echo '[]')"
  successes="$(printf '%s' "$conclusions" | jq '[.[] | select(. == "success")] | length')"
  bad="$(printf '%s' "$conclusions" | jq '[.[] | select(. == "failure" or . == "cancelled" or . == "timed_out" or . == "action_required")] | length')"
  if (( successes > 0 )) && (( bad == 0 )); then
    echo "🟢"
  else
    echo "—"
  fi
}

# repo_tag <repo> — latest published tag, or — when none
repo_tag() {
  local out=""
  out="$(gh api "repos/${OWNER}/$1/tags" --jq '.[0].name' 2>/dev/null)" || true
  echo "${out:-—}"
}

# repo_size <repo> — decimal size from the repo's KB size, or — when unavailable
repo_size() {
  local kb
  kb="$(gh api "repos/${OWNER}/$1" --jq '.size' 2>/dev/null)" || true
  if [[ "$kb" =~ ^[0-9]+$ ]] && (( kb > 0 )); then
    awk -v kb="$kb" 'BEGIN {
      b = kb * 1024;
      if (b >= 1000000000) printf "%.1f GB", b / 1000000000;
      else if (b >= 1000000) printf "%.1f MB", b / 1000000;
      else printf "%d KB", b / 1000;
    }'
  else
    echo "—"
  fi
}

build_table() {
  echo "| # | Repo | Last commit | Tag | Size | CI |"
  echo "|---|---|---|---|---|---|"
  local i repo label date ci tag size
  for i in -1 0 1 2 3 4 5 6 7 8 9; do
    if [[ -z "${SLOTS[$i]:-}" ]]; then
      echo "| ${i} | — | — | — | — | — |"
      continue
    fi
    IFS='|' read -r repo label <<<"${SLOTS[$i]}"
    date="$(repo_date "$repo")"
    tag="$(repo_tag "$repo")"
    size="$(repo_size "$repo")"
    ci="$(repo_ci "$repo")"
    echo "| ${i} | [${label}](https://github.com/${OWNER}/${repo}) | ${date} | ${tag} | ${size} | ${ci} |"
  done
}

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

remote="https://github.com/${TARGET_REPO}.git"
if [[ -n "$TOKEN" ]]; then
  remote="https://x-access-token:${TOKEN}@github.com/${TARGET_REPO}.git"
fi

echo "cloning ${TARGET_REPO}..."
git clone --quiet --depth 1 "$remote" "${tmp}/repo"
cd "${tmp}/repo"
git config user.name "github-actions[bot]"
git config user.email "41898282+github-actions[bot]@users.noreply.github.com"
git checkout --quiet -B "$PR_BRANCH" origin/main

begin_line="$(grep -n 'BEGIN status-table' README.md | head -n1 | cut -d: -f1)"
end_line="$(grep -n 'END status-table' README.md | head -n1 | cut -d: -f1)"
if [[ -z "$begin_line" || -z "$end_line" || "$begin_line" -ge "$end_line" ]]; then
  echo "status-table markers not found in README.md (expected BEGIN/END status-table)" >&2
  exit 1
fi

{
  sed -n "1,${begin_line}p" README.md
  build_table
  sed -n "${end_line},\$p" README.md
} > README.md.new
mv README.md.new README.md

if git diff --quiet -- README.md; then
  echo "repo status unchanged — no PR"
  exit 0
fi

git add README.md
git commit --quiet -m "$PR_TITLE"
git push --force --quiet origin "$PR_BRANCH"

pr_number="$(gh pr list -R "$TARGET_REPO" --base main --head "$PR_BRANCH" --json number --jq '.[0].number // ""')"
if [[ -n "$pr_number" ]]; then
  echo "updated PR ${TARGET_REPO}#${pr_number}"
else
  gh pr create -R "$TARGET_REPO" --base main --head "$PR_BRANCH" \
    --title "$PR_TITLE" --body "Automated refresh of the repo-status table." >/dev/null
  echo "created PR in ${TARGET_REPO} (${PR_BRANCH})"
fi
