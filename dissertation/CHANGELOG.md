# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## v1.0.0 — 2026-03-31

Initial release on [Typst Universe](https://typst.app/universe/package/ethz-iis-dissertation).

### Added

- PhD dissertation template following ETH Zurich doctoral regulations.
- Two render modes: `"official"` (examination copy) and `"series"` (Hartung-Gorre
  publication copy with volume, ISBN, and series page).
- Running chapter headers with optional short title via the `chapter` helper.
- Front matter: acknowledgements, English and German abstracts, list of acronyms,
  table of contents, list of figures and tables.
- Back matter: bibliography, appendices, curriculum vitae, and copyright notice.
- Example chip gallery appendix and CV page in the template.
- Shared ETH Zurich + PULP group logo header.
- Acronym management via [`acrostiche`](https://typst.app/universe/package/acrostiche).
- [Typst Quick Guide](../shared/typst-guide.typ) included as an example appendix.
