# Contributing

This repo is the **account honeypot**: the default community health files and the shared automations for every repo
in the account.

## Model — one source per repo

The account keeps a **small, fixed set of repos** (`0–9`). Each repo is the **single source** for its domain. If
something doesn't fit, it is **appended to an existing repo**, not given a new one. Adding an 11th repo is a red flag.

## Issues are flat

No epic/feature/task hierarchy and no sub-issues. Open **one issue per thing** and relate them with comments and
links (`see #…`). Keep it simple.

## Labels

Keep labels generic (`bug`, `documentation`, `enhancement`, `question`, …). No hierarchy labels.

## Defaults vs override

GitHub inherits `CONTRIBUTING`, `CODE_OF_CONDUCT`, `SECURITY`, `SUPPORT`, `FUNDING`, and `PULL_REQUEST_TEMPLATE`
from this repo **unless a repo defines its own** copy.

## Pull requests

- Keep them small and linked to an issue (`Closes #…`).
- Fill the [PR template](.github/PULL_REQUEST_TEMPLATE.md); don't introduce secrets or personal data.
- Make sure the repo's checks pass locally before opening.
