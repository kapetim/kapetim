# docker

Optional Dockerfiles for workflows that need a pinned toolchain.

Convention: a workflow `<name>.yml` that requires more than `ubuntu-latest` ships
its image here as `docker/<name>/Dockerfile`, and its composite action builds or
pulls it. Simple workflows use a shell script from [`../scripts`](../scripts)
instead — prefer that unless a toolchain is genuinely needed.
