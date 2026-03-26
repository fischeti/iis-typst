# ethz-iis-research-plan

ETH Zurich IIS PhD research plan template for Typst.

Used for the initial research plan that PhD candidates at the
[Integrated Systems Laboratory (IIS)](https://iis.ee.ethz.ch) submit during their first year.

## Usage

Initialize a new project with:

```sh
typst init @preview/ethz-iis-research-plan:0.1.0
```

Or import directly:

```typst
#import "@preview/ethz-iis-research-plan:0.1.0": research-plan

#show: research-plan.with(
  title: "Title of Your Research Plan",
  author: "Jane Doe",
  email: "jdoe@iis.ee.ethz.ch",
  chair:        (name: "Prof. Dr. Chair",      mail: "chair@iis.ee.ethz.ch"),
  supervisor:   (name: "Prof. Dr. Supervisor", mail: "supervisor@iis.ee.ethz.ch"),
  cosupervisor: (name: "Dr. Co-Supervisor",    mail: "cosupervisor@iis.ee.ethz.ch"),
  bibliography: bibliography("references.bib", style: "ieee"),
)
```

## Third-Party Assets

The ETH Zürich logo and IIS header (`shared/figures/`) are trademarks of ETH Zürich
and are **not** covered by the Apache-2.0 license. The logo is reproduced as publicly
available on [Wikimedia Commons](https://commons.wikimedia.org/wiki/File:ETH_Z%C3%BCrich_Logo_black.svg).
Users must comply with [ETH Zürich's branding guidelines](https://ethz.ch/en/the-eth-zurich/communication/corporate-design.html).

## License

Apache-2.0 — Copyright 2026 ETH Zurich and University of Bologna.
