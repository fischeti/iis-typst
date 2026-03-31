# Releasing

This document describes how to bump a package version and publish it to
[Typst Universe](https://typst.app/universe).

## Prerequisites

- [`just`](https://github.com/casey/just)
- [`typst`](https://typst.app)
- [`typst-package-check`](https://github.com/typst/typst-package-check)
- A sparse checkout of the [typst/packages](https://github.com/typst/packages) fork (see below)

### Setting up the typst/packages fork

Fork [typst/packages](https://github.com/typst/packages) on GitHub, then clone
it with a sparse checkout to avoid downloading the full package history:

```sh
git clone --depth 1 --no-checkout --filter="tree:0" git@github.com:{your-username}/packages
cd packages
git sparse-checkout init
git sparse-checkout set \
  packages/preview/ethz-iis-dissertation \
  packages/preview/ethz-iis-thesis \
  packages/preview/ethz-iis-research-plan \
  packages/preview/ethz-iis-assignment
git remote add upstream git@github.com:typst/packages
git config remote.upstream.partialclonefilter tree:0
git checkout main
```

This only needs to be done once per machine.

> [!TIP]
> Both `just bump` and `just release` support a `--dry-run` flag (short: `-n`)
> that prints every command without making any changes — useful for a sanity check
> before committing.

## Steps

### 1. Make and commit all changes

Ensure the `main` branch is clean and CI passes before starting a release.

### 2. Update the changelog

Add your changes to the `[Unreleased]` section in `<pkg>/CHANGELOG.md`:

```md
## [Unreleased]

### Added
- ...
```

The version number and date are filled in automatically by `just release`.

### 3. Regenerate the thumbnail (optional)

Only needed if the first page of the template has changed visually.

```sh
just thumbnail <pkg>
```

### 4. Bump the version

```sh
just bump <pkg> minor   # or major / patch
```

This computes the new version by incrementing the chosen component, updates
`typst.toml` and all import strings, commits with message `<pkg>: bump to v<version>`,
and pushes to `main`. The CHANGELOG is not touched at this point.

### 5. Prepare and submit to Typst Universe

```sh
just prepare <pkg> /path/to/typst-packages
```

This copies the package into the local fork, resolves all symlinks, runs
`typst-package-check`, and verifies the template compiles. Then open a PR:

```sh
cd /path/to/typst-packages
git checkout -b add/ethz-iis-<pkg>-v1.1.0
git add packages/preview/ethz-iis-<pkg>/1.1.0
git commit -m "ethz-iis-<pkg>:1.1.0"
git push
```

Follow the [Typst Universe submission guidelines](https://github.com/typst/packages/tree/main/docs#package-submission-guidelines)
for the PR description. **Wait for the PR to be accepted before continuing.**

### 6. Tag the release

Once the Typst Universe PR is accepted, stamp the changelog and tag:

```sh
just release <pkg>
```

This replaces `## [Unreleased]` in `<pkg>/CHANGELOG.md` with the current version
and today's date, commits, tags `<pkg>/v<version>` (e.g. `thesis/v1.1.0`), and
pushes the commit and tag together. Per-package tags keep the history clean when
packages are released independently.
