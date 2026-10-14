# kapetim

**Machine account for [`kapetao`](https://github.com/kapetao).**

This is the **machine account** set up by the human operator of `kapetao` to do one job:
open **pull requests** against `kapetao`'s public repositories, from forks.

A GitHub *machine account* is an account set up by a person who accepts the Terms of Service on
its behalf, used **exclusively for automated tasks**, and limited to **one** such account
alongside that person's own account. `kapetao` is the human/canonical account; `kapetim` is its
single machine account — the automation never touches `kapetao` directly.

This account handles **public repositories only**; the canonicals live in `kapetao`.

## Role

- **Fork** each public `kapetao` repo → `kapetim/<repo>` (one fork per repo).
- **Author pull requests** from those forks into `kapetao/<repo>:main`.
- **Never merge.** `kapetao` owns the canonicals and holds the approvals — every `kapetao` repo
  requires a PR with **1 approving review**, with admins enforced (no direct pushes).

```text
kapetim/<repo>  --PR-->  kapetao/<repo>:main        (reviewed & merged by kapetao)
```

## Repositories

<!-- BEGIN status-table -->
| # | Repo | Tag | Size | CI |
|---|---|---|---|---|
| 9 | [ui-assets](https://github.com/kapetim/ui-assets) | — | — | — |
| 8 | [pkg-manager](https://github.com/kapetim/pkg-manager) | — | — | — |
| 7 | [radar](https://github.com/kapetim/radar) | — | — | — |
| 6 | [journal](https://github.com/kapetim/journal) | — | — | — |
| 5 | [browser-games](https://github.com/kapetim/browser-games) | — | — | — |
| 4 | [ai-training](https://github.com/kapetim/ai-training) | — | — | — |
| 3 | [browser-extensions](https://github.com/kapetim/browser-extensions) | — | — | — |
| 2 | [interviewing](https://github.com/kapetim/interviewing) | — | — | — |
| 1 | [cli](https://github.com/kapetim/cli) | — | — | — |
| 0 | [kapetao](https://github.com/kapetim/kapetao) | — | — | — |
<!-- END status-table -->
