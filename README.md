# IIS Typst Templates

Typst templates for documents at the
[Integrated Systems Laboratory (IIS)](https://iis.ee.ethz.ch), ETH Zurich.

## Templates

| Package | Description | Audience |
|---|---|---|
| [`ethz-iis-dissertation`](https://typst.app/universe/package/ethz-iis-dissertation) | PhD dissertation | PhD students |
| [`ethz-iis-thesis`](https://typst.app/universe/package/ethz-iis-thesis) | Master / Bachelor / Semester thesis report | Students |
| [`ethz-iis-research-plan`](https://typst.app/universe/package/ethz-iis-research-plan) | PhD research plan (first-year report) | PhD students |
| [`ethz-iis-assignment`](https://typst.app/universe/package/ethz-iis-assignment) | Thesis assignment sheet | Advisors |

## Getting Started

> [!TIP]
> The easiest way is to click one of the links above or search for `ethz-iis` on
> [Typst Universe](https://typst.app/universe) and click **Start from template** to
> create a new project in the Typst web app directly.

Alternatively, initialize a local project from the command line with `typst init`:

```sh
typst init @preview/ethz-iis-dissertation    # PhD dissertation
typst init @preview/ethz-iis-thesis          # thesis report
typst init @preview/ethz-iis-research-plan   # research plan
typst init @preview/ethz-iis-assignment      # assignment sheet
```

## Development

Clone the repository. A [`justfile`](justfile) provides all common recipes:

```sh
just link <pkg>                     # install a package under @local/ethz-iis-*
just compile <pkg>                  # compile a template
just fmt                            # format all .typ files
just bump <pkg>                     # bump patch version of a package
just prepare <pkg> /path/to/fork    # copy to typst/packages fork for submission
```

> [!NOTE]
> Most recipes have a `-all` variant (e.g. `just compile-all`). Run `just` to list all available recipes.

Run `just link <pkg>` once after cloning to install packages into Typst's `@local`
namespace. Then change `@preview/` to `@local/` in a template's `main.typ` to
pick up local changes on every compile:

```sh
git clone https://github.com/pulp-platform/iis-typst
cd iis-typst
just link <pkg>
# in template/main.typ: change @preview/ethz-iis-* to @local/ethz-iis-*
just compile <pkg>
```

See [RELEASING.md](RELEASING.md) for the full release and publishing workflow.

Each template lives in its own subdirectory and is an independent Typst package:

```
<package>/
├── typst.toml            # package manifest
├── lib.typ               # template implementation
├── shared/               # symlink → ../shared/ (utils + ETH figures)
└── template/             # example project copied on `typst init`
    └── main.typ
```

Shared utilities (`utils.typ`) and ETH brand assets (`figures/`) live in
`shared/` and are symlinked into each package. The `just prepare` recipe
dereferences symlinks and rewrites `@local/` → `@preview/` imports when
copying to the Typst Universe fork.

## License

Apache-2.0 — see [LICENSE](LICENSE).

> [!WARNING]
> The ETH Zürich logo (`shared/figures/eth_logo_kurz_pos.svg`) is a trademark of
> ETH Zürich and is **not** covered by the Apache-2.0 license. It is reproduced as
> publicly available on [Wikimedia Commons](https://commons.wikimedia.org/wiki/File:ETH_Z%C3%BCrich_Logo_black.svg).
> Users must comply with [ETH Zürich's branding guidelines](https://ethz.ch/staffnet/en/service/communication/corporate-design/eth-logo.html).
