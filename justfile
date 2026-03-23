# Copyright 2026 ETH Zurich and University of Bologna.
# Licensed under the Apache License, Version 2.0, see LICENSE for details.
# SPDX-License-Identifier: Apache-2.0
#
# Author: Tim Fischer <fischeti@iis.ee.ethz.ch>

packages := "dissertation thesis research-plan assignment"

# List available recipes
default:
    @just --list

# Compile a single template
compile pkg:
    typst compile --package-path packages {{pkg}}/template/main.typ

# Compile all templates
compile-all:
    @for pkg in {{packages}}; do just compile $pkg; done

# Generate thumbnail for a single template
thumbnail pkg:
    typst compile -f png --pages 1 --ppi 250 \
        --package-path packages \
        {{pkg}}/template/main.typ \
        {{pkg}}/thumbnail.png

# Generate thumbnails for all templates
thumbnail-all:
    @for pkg in {{packages}}; do just thumbnail $pkg; done

# Run typst-package-check on a single package
check pkg:
    typst-package-check check {{pkg}}

# Run typst-package-check on all packages
check-all:
    @for pkg in {{packages}}; do just check $pkg; done

# Check formatting (no modifications)
fmt-check:
    typstyle --check **/*.typ

# Format all .typ files in-place
fmt:
    typstyle -i **/*.typ

# Initialize a template locally (typst init equivalent)
init pkg dir="pkg":
    typst init --package-path packages @preview/ethz-iis-{{pkg}}:0.1.0 {{dir}}

# Bump the version of a package (level: patch, minor, or major)
bump pkg level="patch":
    python3 scripts/bump.py {{pkg}} {{level}}

# Prepare a package for submission to Typst Universe (replaces shared/ symlink with real copy, adds LICENSE)
prepare pkg:
    rm {{pkg}}/shared
    cp -r shared {{pkg}}/shared
    cp LICENSES/Apache-2.0.txt {{pkg}}/LICENSE
    @echo "{{pkg}}/ is ready — submit as packages/preview/ethz-iis-{{pkg}}/0.1.0/"
