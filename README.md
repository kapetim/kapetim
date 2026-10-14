# Machine account

**Contributor — clone freely, ship pull requests. Never merge.**

This is the **machine account** for [the main account](https://github.com/kapetao): a contributor
that does exactly one job — turn issues into reviewed pull requests.

- **Clone freely** over **SSH** with a full-repo key.
- **One branch per issue**, cut from a clean, up-to-date `main`; push it to the fork and open a PR
  that **closes the linked issue**.
- **Never merge.** [The main account](https://github.com/kapetao) reviews, approves (one review),
  and merges.

## Workflow — the relay

1. **Start clean.** Fetch the latest upstream `main` and branch from it. Never continue a stale branch.
2. **Branch** for one issue (`<repo>:<issue>`).
3. **Implement + push**, open the PR with `Closes #N`.
4. **Delete the branch** once merged; the fork falls back to `main`.
5. **Unsure?** Comment on the issue and stop — resume later from a fresh `main`.

Pick up exactly where the last runner stopped, but never keep running on an outdated baton.

```mermaid
flowchart TB
  issue["📝 issue · upstream#N"]:::canon
  key["🔑 SSH key · full-repo scope"]:::infra
  mach["🤖 machine account"]:::machine
  fork["🍴 fork"]:::fork
  canon["📦 upstream · main"]:::canon
  ui["📱 tablet · GitHub UI"]:::human

  issue --> mach
  key --> mach
  mach -->|commit · push| fork
  fork -->|open PR “closes #N”| canon
  canon -->|review + comment| ui
  ui -->|approve + merge| canon
  canon -.->|auto-closes| issue

  classDef infra fill:#f6f8fa,stroke:#666;
  classDef machine fill:#ddf4ff,stroke:#0969da;
  classDef fork fill:#fff8c5,stroke:#9a6700;
  classDef canon fill:#dafbe1,stroke:#1a7f37;
  classDef human fill:#ffeff7,stroke:#bf3989;
```
