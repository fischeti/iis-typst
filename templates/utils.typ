// Copyright 2026 ETH Zurich and University of Bologna.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
//
// Author: Tim Fischer <fischeti@iis.ee.ethz.ch>
//
// Shared utilities for IIS Typst templates

#import "@preview/gentle-clues:1.3.1": task, code

/// Inline placeholder for missing fields — muted italic text e.g. ⟨title⟩
#let fieldpar(content) = text(fill: luma(190), style: "italic", [⟨#content⟩])

/// Helper function to return current Semester
/// e.g. "Spring Semester 26"
#let current-semester() = {
  let current_year = datetime.today().display("[year repr:last_two]")
  let current_season = if datetime.today().month() < 6 { "Spring" } else { "Fall" }
  current_season + " Semester " + current_year
}

/// Include all pages of a PDF file as full-width images.
/// Use an absolute path (e.g. "/examples/task.pdf") so it resolves from the
/// Typst root regardless of which file calls this function.
/// The page count must be specified manually as Typst does not expose PDF metadata.
#let include-pdf(path, pages: 1) = {
  for i in range(1, pages + 1) {
    image(path, width: 100%, page: i)
  }
}

/// Render a task clue with a title, optional description content, and a
/// syntax-highlighted Typst code snippet. Intended for use in the `else` branch
/// of a `if param != none { param } else { placeholder(...) }` pattern.
#let placeholder(title: "", description: none, snippet: "") = {
  task(title: title)[
    #if description != none { description }
    #code[#raw(lang: "typc", block: true, "#show: thesis.with(\n  " + snippet + "\n  // ...\n)")]
  ]
}

/// ETH header with logo on the left and institute name on the right
#let eth-header = grid(
  columns: (auto, 1fr),
  rows: (80pt),
  align: (horizon, horizon + right),
  image("figures/eth_logo_kurz_pos.svg", height: 80%),
  block[
    #set align(left)
    #set text(size: 12pt, weight: "semibold")
    Integrated Systems Laboratory\
    Institut für Integrierte Systeme
  ],
)
