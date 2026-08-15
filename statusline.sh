#!/bin/bash

# Claude Code status line: repo | branch | S/U/A | tokens %

input=$(cat)

# Extract values from the input JSON (no jq dependency)
extract() { sed -n "s/.*\"$1\":\"\([^\"]*\)\".*/\1/p" <<< "$input"; }
num() { sed -n "s/.*\"$1\":\([0-9]*\).*/\1/p" <<< "$input"; }
cwd=$(extract current_dir)

# Colors
REPO=$'\033[1;36m'    # bold cyan
BRANCH=$'\033[1;32m'  # bold green
LABEL=$'\033[37m'     # normal white
COUNT=$'\033[33m'     # yellow
TOKENS=$'\033[1;33m'  # bold yellow
PCT=$'\033[1;37m'     # bold white
DIM=$'\033[2m'        # dim
R=$'\033[0m'          # reset
SEP="${DIM} | ${R}"

# Git segment
if git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
  g() { git -C "$cwd" --no-optional-locks "$@" 2>/dev/null; }
  repo=$(basename "$(g rev-parse --show-toplevel)")
  branch=$(g rev-parse --abbrev-ref HEAD)
  staged=$(g diff --cached --name-only | awk 'END {print NR}')
  unstaged=$(g diff --name-only | awk 'END {print NR}')
  untracked=$(g ls-files --others --exclude-standard | awk 'END {print NR}')

  out="${REPO}${repo}${R}${SEP}${BRANCH}${branch}${R}"
  out+="${SEP}${LABEL}S:${R} ${COUNT}${staged}${R}"
  out+="${SEP}${LABEL}U:${R} ${COUNT}${unstaged}${R}"
  out+="${SEP}${LABEL}A:${R} ${COUNT}${untracked}${R}"
else
  out="${REPO}$(basename "$cwd")${R}"
fi

# Context tokens + percentage, from the harness-provided context_window
# fields (context_window_size is per-model, so no hardcoded limits)
total=$(num total_input_tokens)
size=$(num context_window_size)
if [ -n "$total" ] && [ "$total" -gt 0 ] && [ -n "$size" ] && [ "$size" -gt 0 ]; then
  pct=$(( total * 100 / size ))
  tokens=$(awk -v t=$total 'BEGIN { printf "%.1fk", t/1000 }')
  out+="${SEP}${TOKENS}${tokens}${R} ${PCT}${pct}%${R}"
fi

printf '%s' "$out"
