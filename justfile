# Copyright 2026 ETH Zurich.
# Licensed under the Apache License, Version 2.0, see LICENSE for details.
# SPDX-License-Identifier: Apache-2.0
#
# Author: Tim Fischer <fischeti@iis.ee.ethz.ch>

packages := "dissertation thesis research-plan assignment"

# List available recipes
default:
    @just --list

# Install a single package into the @local Typst namespace
link pkg:
    #!/usr/bin/env sh
    version=$(grep '^version' {{pkg}}/typst.toml | sed 's/version = "\(.*\)"/\1/')
    pkg_root=$(typst info --format json | jq -r '.packages["package-path"]')
    dest="$pkg_root/local/ethz-iis-{{pkg}}/$version"
    mkdir -p "$(dirname "$dest")"
    ln -sfn "$(pwd)/{{pkg}}" "$dest"
    echo "🔗 @local/ethz-iis-{{pkg}}:$version → $(pwd)/{{pkg}}"

# Install all packages into the @local Typst namespace
link-all:
    @for pkg in {{packages}}; do just link $pkg; done

# Compile a single template
compile pkg:
    typst compile {{pkg}}/template/main.typ

# Compile all templates
compile-all:
    @for pkg in {{packages}}; do just compile $pkg; done

# Generate thumbnail for a single template
thumbnail pkg:
    typst compile -f png --pages 1 --ppi 250 \
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
    typst init @preview/ethz-iis-{{pkg}} {{dir}}

# Bump the version of a package (level: patch, minor, or major)
bump pkg level="patch":
    python3 scripts/bump.py {{pkg}} {{level}}

# Copy all packages into a local fork of typst/packages
prepare-all fork:
    @for pkg in {{packages}}; do just prepare $pkg {{fork}}; done

# Copy a package into a local fork of typst/packages, resolving symlinks in the process.
# Usage: just prepare dissertation /path/to/typst-packages
prepare pkg fork:
    #!/usr/bin/env sh
    set -e
    version=$(grep '^version' {{pkg}}/typst.toml | sed 's/version = "\(.*\)"/\1/')
    dest="{{fork}}/packages/preview/ethz-iis-{{pkg}}/$version"
    echo "📦 Copying {{pkg}} v$version to $dest"
    cd "{{fork}}" && git sparse-checkout add "packages/preview/ethz-iis-{{pkg}}" && cd -
    mkdir -p "$dest"
    rsync -rL --exclude='*.pdf' --exclude='CHANGELOG.md' {{pkg}}/ "$dest/"
    cp LICENSES/Apache-2.0.txt "$dest/LICENSE"
    echo "🔍 Running typst-package-check"
    typst-package-check check "$dest"
    echo "🏗️  Initialising template into temp directory"
    tmp=$(mktemp -d)
    typst init --package-path "{{fork}}/packages" "@preview/ethz-iis-{{pkg}}:$version" "$tmp/project"
    echo "⚙️  Compiling"
    typst compile --package-path "{{fork}}/packages" "$tmp/project/main.typ"
    rm -rf "$tmp"
    echo "✅ Done — commit and push in {{fork}}"
