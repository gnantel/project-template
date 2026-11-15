#!/bin/sh
# Fails when a source file matching one of the given name patterns has more than 300 lines; neither ruff nor clippy has such a lint.
set -eu
set -f

max_lines=300

name_tests=""
for name_pattern in "$@"; do
  name_tests="${name_tests:+$name_tests -o }-name $name_pattern"
done

# shellcheck disable=SC2086
too_long=$(find . \( -path ./.git -o -path ./.venv -o -path ./target -o -path ./build -o -path ./dist \) -prune -o \
  -type f \( $name_tests \) -exec awk -v max="$max_lines" \
  'END { if (NR > max) print FILENAME ": " NR " lines (max " max ")" }' {} \;)

if [ -n "$too_long" ]; then
  echo "$too_long" >&2
  exit 1
fi
