#!/usr/bin/env bash
# Formats the file Claude just edited through `just fmt-files`; reads the PostToolUse event from stdin.
set -euo pipefail

edited_file=$(jq -r '.tool_input.file_path // empty')
[ -n "$edited_file" ] && [ -f "$edited_file" ] || exit 0

cd "$CLAUDE_PROJECT_DIR"
mise exec -- just fmt-files "$edited_file"
