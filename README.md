# IIS Typst Templates

Typst templates for documents at the
[Integrated Systems Laboratory (IIS)](https://iis.ee.ethz.ch), ETH Zurich.

## Templates

| Package | Description | Audience |
|---|---|---|
| [`@preview/ethz-iis-dissertation`](dissertation/) | PhD dissertation | PhD students |
| [`@preview/ethz-iis-thesis`](thesis/) | Master / Bachelor / Semester thesis report | Students |
| [`@preview/ethz-iis-research-plan`](research-plan/) | PhD research plan (first-year report) | PhD students |
| [`@preview/ethz-iis-assignment`](assignment/) | Thesis assignment sheet | Advisors |

> [!NOTE]
> These packages are pending publication on [Typst Universe](https://typst.app/universe).
> Until then, use the local development workflow described below.

## Getting Started

### From Typst Universe

Once published, initialize any template with `typst init`:

```sh
typst init @preview/ethz-iis-dissertation:0.1.0    # PhD dissertation
typst init @preview/ethz-iis-thesis:0.1.0          # thesis report
typst init @preview/ethz-iis-research-plan:0.1.0   # research plan
typst init @preview/ethz-iis-assignment:0.1.0      # assignment sheet
```

This copies a ready-to-compile example project into a new directory.
Alternatively, search for **ethz-iis** in the [Typst Universe](https://typst.app/universe)
and start the template from there.

### Local Development (from this repo)

Clone the repository, then pass `--package-path /path/to/iis-typst/packages`
from anywhere so that Typst resolves `@preview/ethz-iis-*` against the local
package directories:

```sh
git clone https://github.com/pulp-platform/iis-typst

# Initialize a project anywhere
typst init --package-path /path/to/iis-typst/packages \
    @preview/ethz-iis-dissertation:0.1.0 my-dissertation

# Compile
cd my-dissertation
typst compile --package-path /path/to/iis-typst/packages main.typ
```

The `packages/preview/` directory contains symlinks that point to the package
subdirectories in this repo, so any local change to a template is reflected
immediately on the next compile.

## Contributing / Modifying Templates

Each template lives in its own subdirectory (`dissertation/`, `thesis/`, etc.)
and is an independent Typst package:

```
<package>/
├── typst.toml            # package manifest
├── lib.typ               # template implementation
├── shared/               # symlink → ../shared/ (utils + ETH figures)
└── template/             # example project copied on `typst init`
    └── main.typ
```

Shared utilities (`utils.typ`) and ETH brand assets (`figures/`) live in
`shared/` and are symlinked into each package. Before submitting a package
to Typst Universe, replace the symlink with a real copy:

```sh
cd dissertation
rm shared && cp -r ../shared .
```

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

## License

Apache-2.0 — see [LICENSE](LICENSE).
