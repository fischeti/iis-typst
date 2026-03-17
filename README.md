# IIS Typst Templates

Typst templates for student theses and task descriptions at the
[Integrated Systems Laboratory (IIS)](https://iis.ee.ethz.ch), ETH Zurich.

## Templates

| Template | Description | Audience |
|---|---|---|
| `templates/thesis.typ` | Master thesis / semester project report | Students |
| `templates/assignment.typ` | Assignment description handed to students | Advisors |
| `templates/research_plan.typ` | PhD research plan (first-year report) | PhD students |

## Getting Started

### Option 1: Typst Web App (recommended)

1. Go to [typst.app](https://typst.app) and create a project.
2. Upload this repository (or just the `templates/` directory) to the project.
3. Create a new `.typ` file at the project root and import the template:

```typ
#import "templates/thesis.typ": *

#show: thesis.with(
  title: "My Thesis Title",
  author: "Jane Doe",
  email: "jdoe@iis.ee.ethz.ch",
  reporttype: "Master Thesis",
  advisors: (
    (name: "Dr. Alice Smith", mail: "asmith@iis.ee.ethz.ch"),
  ),
  professors: (
    (name: "Prof. Dr. Carol Miller", mail: "cmiller@iis.ee.ethz.ch"),
  ),
  bibliography: bibliography("references.bib", style: "ieee", full: true),
)

= Introduction

Your thesis starts here.
```

The web app compiles and previews the PDF live in the browser — no local
installation needed.

### Option 2: Local Development

Install the Typst compiler ([installation instructions](https://github.com/typst/typst#installation)), then compile from the repository root:

```sh
typst compile your_thesis.typ
```

Missing fields show a highlighted placeholder clue in the compiled PDF rather
than an error, so you can compile at any stage of writing. See
`examples/thesis.typ` for a full working example.

> [!NOTE]
> The `examples/` directory contains working examples that can be compiled
> directly from the repository root:
> ```sh
> typst compile --root . examples/thesis.typ
> ```
> The `--root .` flag is required because the examples import from the parent
> directory.

## Acronyms

Define acronyms in a separate file and pass them to the template:

```typ
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

Use `include-pdf` (re-exported from the template) to embed scanned documents
such as the signed declaration of originality:

```typ
declaration-of-originality: include-pdf("figures/declaration.pdf"),
```

## For Advisors and PhD Students

- **Assignment description** (`templates/assignment.typ`): handed to students at the start of a project. See `examples/assignment.typ` for a working example.
- **Research plan** (`templates/research_plan.typ`): written by PhD candidates at the end of their first year, covering motivation, completed work, project definition, and a tentative timeline. See `examples/research_plan.typ` for a working example.

## License

Apache 2.0 — see [LICENSE](LICENSE).
