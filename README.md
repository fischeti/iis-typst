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

The easiest way is to open the template on [Typst Universe](https://typst.app/universe)
and click **Start from template** to create a new project in the Typst web app directly.

Alternatively, initialize a local project from the command line with `typst init`:

```sh
typst init @preview/ethz-iis-dissertation    # PhD dissertation
typst init @preview/ethz-iis-thesis          # thesis report
typst init @preview/ethz-iis-research-plan   # research plan
typst init @preview/ethz-iis-assignment      # assignment sheet
```

## Development

Clone the repository and run `just link-all` to install the packages into
Typst's `@local` namespace. Then change `@preview/` to `@local/` in the
template `main.typ` to pick up local changes on every compile.

```sh
git clone https://github.com/pulp-platform/iis-typst
cd iis-typst
just link-all   # installs packages under @local/ethz-iis-*
# in template/main.typ: change @preview/ethz-iis-* to @local/ethz-iis-*
just compile-all
```

A [`justfile`](justfile) provides convenience recipes:

```sh
just link-all                              # install all packages under @local/ethz-iis-*
just compile-all                           # compile all four templates
just fmt                                   # format all .typ files
just bump dissertation                     # bump patch version of a package
just prepare dissertation /path/to/fork   # copy to typst/packages fork for submission
```

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

## Acronyms

Define acronyms in a separate file and pass them to the template:

```typst
#let acronyms = (
  "IC":  ("Integrated Circuit",),
  "SoC": (
    short: "SoC", long: "System-on-Chip",
    short-pl: "SoCs", long-pl: "Systems-on-Chip",
  ),
)
```

Use them in text with `#acr("IC")`, `#acrpl("SoC")`, or `#acrfull("IC")`.

## Including PDFs

Use `include-pdf` (re-exported from each template) to embed scanned documents
such as the signed declaration of originality:

```typst
declaration-of-originality: include-pdf("figures/declaration.pdf"),
```

## Third-Party Assets

The ETH Zürich logo (`shared/figures/eth_logo_kurz_pos.svg`) is a trademark of
ETH Zürich and is **not** covered by the Apache-2.0 license. It is reproduced as
publicly available on [Wikimedia Commons](https://commons.wikimedia.org/wiki/File:ETH_Z%C3%BCrich_Logo_black.svg).
Users must comply with [ETH Zürich's branding guidelines](https://ethz.ch/staffnet/en/service/communication/corporate-design/eth-logo.html).

## License

Apache-2.0 — see [LICENSE](LICENSE).
