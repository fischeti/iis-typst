// Copyright 2026 ETH Zurich and University of Bologna.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
//
// Author: Tim Fischer <fischeti@iis.ee.ethz.ch>
//
// Public API for the iis-typst package.
// Import templates and utilities from here:
//   #import "@local/iis-typst:0.1.0": dissertation, pulp-colors

#import "templates/utils.typ": fieldpar, pulp-colors, include-pdf, placeholder, current-semester
#import "@preview/acrostiche:0.7.0": acr, acrpl, acrfull, init-acronyms, print-index, reset-acronym, reset-all-acronyms
#import "templates/dissertation.typ": dissertation, chapter-short
#import "templates/thesis.typ": thesis
#import "templates/assignment.typ": assignment
#import "templates/research_plan.typ": research-plan
