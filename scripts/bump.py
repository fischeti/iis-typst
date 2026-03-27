#!/usr/bin/env python3
# Copyright 2026 ETH Zurich.
# Licensed under the Apache License, Version 2.0, see LICENSE for details.
# SPDX-License-Identifier: Apache-2.0
#
# Bump the version of a package and update all dependent references.
#
# Usage:
#   python3 scripts/bump.py <package> [patch|minor|major]
#
# Examples:
#   python3 scripts/bump.py dissertation
#   python3 scripts/bump.py thesis minor

import re
import glob
import os
import sys


def bump_version(major, minor, patch, level):
    if level == "major":
        return major + 1, 0, 0
    elif level == "minor":
        return major, minor + 1, 0
    else:
        return major, minor, patch + 1


def main():
    if len(sys.argv) < 2:
        print(f"Usage: {sys.argv[0]} <package> [patch|minor|major]", file=sys.stderr)
        sys.exit(1)

    pkg = sys.argv[1]
    level = sys.argv[2] if len(sys.argv) > 2 else "patch"

    if level not in ("patch", "minor", "major"):
        print(f"error: level must be patch, minor, or major (got '{level}')", file=sys.stderr)
        sys.exit(1)

    toml_path = f"{pkg}/typst.toml"
    if not os.path.exists(toml_path):
        print(f"error: {toml_path} not found", file=sys.stderr)
        sys.exit(1)

    with open(toml_path) as f:
        toml = f.read()

    m = re.search(r'version = "(\d+)\.(\d+)\.(\d+)"', toml)
    if not m:
        print(f"error: could not find version in {toml_path}", file=sys.stderr)
        sys.exit(1)

    old_ver = f"{m.group(1)}.{m.group(2)}.{m.group(3)}"
    new_ver = "{}.{}.{}".format(*bump_version(int(m.group(1)), int(m.group(2)), int(m.group(3)), level))

    # Update typst.toml
    with open(toml_path, "w") as f:
        f.write(toml.replace(f'version = "{old_ver}"', f'version = "{new_ver}"'))
    print(f"  {toml_path}: {old_ver} → {new_ver}")

    # Update @preview imports in all template .typ files
    typ_files = (
        glob.glob(f"{pkg}/template/**/*.typ", recursive=True) +
        glob.glob(f"{pkg}/template/*.typ")
    )
    for path in typ_files:
        with open(path) as f:
            src = f.read()
        new_src = src.replace(f"ethz-iis-{pkg}:{old_ver}", f"ethz-iis-{pkg}:{new_ver}")
        if new_src != src:
            with open(path, "w") as f:
                f.write(new_src)
            print(f"  {path}")

    # Update version references in READMEs
    for readme_path in (f"{pkg}/README.md", "README.md"):
        if os.path.exists(readme_path):
            with open(readme_path) as f:
                src = f.read()
            new_src = src.replace(f"ethz-iis-{pkg}:{old_ver}", f"ethz-iis-{pkg}:{new_ver}")
            if new_src != src:
                with open(readme_path, "w") as f:
                    f.write(new_src)
                print(f"  {readme_path}")

    # Replace old version symlink in packages/preview/ with new one
    pkg_dir = f"packages/preview/ethz-iis-{pkg}"
    old_link = f"{pkg_dir}/{old_ver}"
    new_link = f"{pkg_dir}/{new_ver}"
    os.makedirs(pkg_dir, exist_ok=True)
    if os.path.islink(old_link):
        os.remove(old_link)
        print(f"  removed {old_link}")
    os.symlink(f"../../../{pkg}", new_link)
    print(f"  created {new_link}")

    print(f"\n{pkg}: {old_ver} → {new_ver}")


if __name__ == "__main__":
    main()
