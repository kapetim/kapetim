# kapetim hub

The **profile repo** (`kapetim/kapetim`) is also the account's automation hub — the
single source of the shared workflows — and the home of the profile status table
(rendered from the root [`README.md`](../README.md)).

## Layout

```text
.github/
├── workflows/          all workflows (manual / reusable)
├── actions/profile/    composite action for the profile refresh
└── scripts/profile/    shell logic for the profile refresh
scripts/                uniform per-concern scripts (ci, release, pages, data-ingestor, data-processor)
docker/                 uniform per-concern Dockerfiles
docs/                   this documentation
```

## Community health

The profile repo carries only
[`CODE_OF_CONDUCT.md`](../.github/CODE_OF_CONDUCT.md),
[`CONTRIBUTING.md`](../.github/CONTRIBUTING.md) and
[`SECURITY.md`](../.github/SECURITY.md).

> GitHub only inherits default community health files account-wide from a
> repository literally named `kapetim/.github`. Because these live in the profile
> repo, they currently apply to this repo only.

## Concerns

Every repository carries the same five concerns — a `scripts/<name>.sh` run
inside a `docker/<name>.Dockerfile`:

| Concern | Script | Dockerfile | Hub workflow |
| --- | --- | --- | --- |
| CI | `scripts/ci.sh` | `docker/ci.Dockerfile` | `ci.yml` |
| Release | `scripts/release.sh` | `docker/release.Dockerfile` | `release.yml` |
| Pages | `scripts/pages.sh` | `docker/pages.Dockerfile` | `pages.yml` |
| Data ingest | `scripts/data-ingestor.sh` | `docker/data-ingestor.Dockerfile` | `data-ingestor.yml` |
| Data process | `scripts/data-processor.sh` | `docker/data-processor.Dockerfile` | `data-processor.yml` |

## Workflows

All workflows live here and are manual (`workflow_dispatch`) or reusable
(`workflow_call`) — nothing auto-runs. The `ci`/`release`/`pages`/`data-*`
workflows take a target `repo` input and run that repo's script image.

| Workflow | Kind | Purpose |
| --- | --- | --- |
| `ci.yml` | manual | run `scripts/ci.sh` in a target repo |
| `release.yml` | manual | run `scripts/release.sh` in a target repo |
| `pages.yml` | manual | build and publish `_site/` to a target repo's `gh-pages` |
| `data-ingestor.yml` | manual | run `scripts/data-ingestor.sh` in a target repo |
| `data-processor.yml` | manual | run `scripts/data-processor.sh` in a target repo |
| `profile-refresh.yml` | manual | refresh the profile repo-status table |
| `pr-{create,fix,review,janitor}.yml` | reusable + manual | PR lifecycle stages |

## Repo numbering

The account keeps **one source per domain**: slots `0–9` plus the `-1` vault. The
order lives in [`repos.txt`](../.github/scripts/profile/repos.txt).

- `-1` private (vault)
- `0` profile (this repo)
- `1` cli · `2` interviewing · `3` browser-extensions · `4` ai-training
- `5` browser-games · `6` wiki · `7` data-science · `8` ui-assets · `9` *(reserved)*
