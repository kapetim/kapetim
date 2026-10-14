# kapetim

**What this account is:** a **PR / management account**. It exists to fork and open pull requests
against the [`kapetao`](https://github.com/kapetao) account's **public** repositories — nothing else.

## Role

- **Fork** each public `kapetao` repo → `kapetim/<repo>` (one fork per repo).
- **Author pull requests** from those forks into `kapetao/<repo>:main`.
- **Never merge.** `kapetao` owns the canonicals and holds the approvals — every `kapetao` repo
  requires a PR with **1 approving review**, with admins enforced (no direct pushes).

## Flow

```
kapetim/<repo>  --PR-->  kapetao/<repo>:main        (approved by kapetao)
```

Local clones pin `origin = kapetim/<repo>` (the fork) and `upstream = kapetao/<repo>` (the original).

## Not here

Private repositories are **not** part of this PR flow — they stay separate and self-contained.

> This is a working/management account, distinct from **kapetao** (the canonical public org).
