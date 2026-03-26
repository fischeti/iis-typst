# ethz-iis-assignment

ETH Zurich IIS thesis assignment sheet template for Typst.

Used for issuing student thesis and project assignments at the
[Integrated Systems Laboratory (IIS)](https://iis.ee.ethz.ch).

## Usage

Initialize a new project with:

```sh
typst init @preview/ethz-iis-assignment:0.1.0
```

Or import directly:

```typst
#import "@preview/ethz-iis-assignment:0.1.0": assignment

#show: assignment.with(
  projecttype: "master",
  student: "Student Name",
  title: "Master Thesis Title",
  advisors: (
    (name: "First Supervisor", office: "OAT UXX", mail: "first.supervisor@iis.ee.ethz.ch"),
  ),
  professors: (
    (name: "Prof. Dr. P. Professor", mail: "professor@iis.ee.ethz.ch"),
  ),
)
```

Supported `projecttype` values: `"master"`, `"bachelor"`, `"semester"`, `"group"`.

## Third-Party Assets

The ETH Zürich logo and IIS header (`shared/figures/`) are trademarks of ETH Zürich
and are **not** covered by the Apache-2.0 license. The logo is reproduced as publicly
available on [Wikimedia Commons](https://commons.wikimedia.org/wiki/File:ETH_Z%C3%BCrich_Logo_black.svg).
Users must comply with [ETH Zürich's branding guidelines](https://ethz.ch/en/the-eth-zurich/communication/corporate-design.html).

## License

Apache-2.0 — Copyright 2026 ETH Zurich and University of Bologna.
