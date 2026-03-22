# ethz-iis-thesis

ETH Zurich IIS thesis / semester project report template for Typst.

Covers Master Thesis, Bachelor Thesis, Semester Project, and Group Project report types
at the [Integrated Systems Laboratory (IIS)](https://iis.ee.ethz.ch).

## Usage

Initialize a new project with:

```sh
typst init @preview/ethz-iis-thesis:0.1.0
```

Or import directly:

```typst
#import "@preview/ethz-iis-thesis:0.1.0": thesis

#show: thesis.with(
  title: "Title of Your Thesis",
  author: "Student Name",
  email: "student@iis.ee.ethz.ch",
  reporttype: "Master Thesis",
  advisors: (
    (name: "First Supervisor", mail: "first.supervisor@iis.ee.ethz.ch"),
  ),
  professors: (
    (name: "Prof. Dr. P. Professor", mail: "professor@iis.ee.ethz.ch"),
  ),
  abstract: [...],
  bibliography: bibliography("references.bib", style: "ieee"),
)
```

## License

Apache-2.0 — Copyright 2026 ETH Zurich and University of Bologna.
