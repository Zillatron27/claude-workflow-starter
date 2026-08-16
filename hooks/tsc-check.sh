#!/usr/bin/env bash
# PostToolUse hook: reads the tool-call JSON from stdin and runs tsc only if the
# edited file is TypeScript. Claude sees the errors immediately after each edit.
INPUT=$(cat)
FILE=$(echo "$INPUT" | node -p "JSON.parse(require('fs').readFileSync('/dev/stdin','utf8')).tool_input?.file_path || ''" 2>/dev/null)
if [[ "$FILE" == *.ts || "$FILE" == *.tsx ]]; then
  npx tsc --noEmit 2>&1 | head -20
fi
