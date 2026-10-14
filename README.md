# kapetim

**Machine account for [`kapetao`](https://github.com/kapetao).**

This is the **machine account** set up by the human operator of `kapetao` to do one job:
open **pull requests** against `kapetao`'s public repositories, from forks.

A GitHub *machine account* is an account set up by a person who accepts the Terms of Service on
its behalf, used **exclusively for automated tasks**, and limited to **one** such account
alongside that person's own account. This repo exists to be explicit about that arrangement:
`kapetao` is the human/canonical account, and `kapetim` is its single machine account — the
automation never touches `kapetao` directly.

## Role

- **Fork** each public `kapetao` repo → `kapetim/<repo>` (one fork per repo).
- **Author pull requests** from those forks into `kapetao/<repo>:main`.
- **Never merge.** `kapetao` owns the canonicals and holds the approvals — every `kapetao` repo
  requires a PR with **1 approving review**, with admins enforced (no direct pushes).

```text
kapetim/<repo>  --PR-->  kapetao/<repo>:main        (reviewed & merged by kapetao)
```

Local clones pin `origin = kapetim/<repo>` (the fork) and `upstream = kapetao/<repo>` (the original).

## Not here

Private repositories are outside this flow — they stay separate and self-contained.
