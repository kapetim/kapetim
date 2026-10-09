# .github

Default community health files for the **kapetim** account — the honeypot every repo inherits from.

## Inherited by every repo

| File | Effect |
| --- | --- |
| [`CONTRIBUTING.md`](CONTRIBUTING.md) | shown when opening an issue or pull request |
| [`CODE_OF_CONDUCT.md`](CODE_OF_CONDUCT.md) | community standards |
| [`SECURITY.md`](SECURITY.md) | private vulnerability reporting |
| [`SUPPORT.md`](SUPPORT.md) | where to get help |
| [`.github/FUNDING.yml`](.github/FUNDING.yml) | sponsor button |
| [`.github/PULL_REQUEST_TEMPLATE.md`](.github/PULL_REQUEST_TEMPLATE.md) | default PR body |

A repo **overrides** a default by providing its own copy.

Not inherited: `LICENSE`, `CITATION.cff`, `CODEOWNERS`, `dependabot.yml`, `GOVERNANCE.md`, and workflow files.

## Issues — flat

Issues are **flat**: one issue per thing, related with comments and links. There is **no epic/feature/task
hierarchy** and no parent/child tooling.

## Layout

```text
.github/actions/          composite actions used by the workflows
.github/workflows/        reusable stages + manual jobs (see below)
scripts/                  shell logic (one script per concern)
docker/                   Dockerfiles for workflows that need a toolchain
```

## Workflows

All manual (`workflow_dispatch`) or reusable (`workflow_call`) — nothing auto-runs. Every write lands as a **PR,
issue, or comment**; no workflow pushes to `main`.

| Workflow | Kind | Purpose |
| --- | --- | --- |
| `profile-refresh.yml` | manual | refresh the profile repo-status table — opens a PR in `kapetim/kapetim` |
| `pr-*.yml` | reusable + manual | PR lifecycle stages (create, fix, review, janitor) |
| `release.yml` | manual | bump `VERSION` on a release branch and open a PR |
| `release-tag.yml` | manual | tag merged `main` and publish a release — no `main` commit |
| `test.yml` | manual | this repo's own markdownlint |

## Repo numbering

The account keeps **one source per domain** and a hard cap of **10 repos** (`0–9`). The order lives in
[`scripts/profile/repos.txt`](scripts/profile/repos.txt); exceeding 10 fails the profile-refresh workflow. If
something doesn't fit, append it to an existing repo instead of adding an 11th.
