#!/usr/bin/env bash
# Runs `just lint` before Claude ends its turn and reports failures back to it.
set -uo pipefail

already_retrying=$(jq -r '.stop_hook_active // false') || exit 1
[ "$already_retrying" = "true" ] && exit 0

cd "$CLAUDE_PROJECT_DIR"
mise exec -- just lint >&2 || exit 2
