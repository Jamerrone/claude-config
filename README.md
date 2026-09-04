# Claude Code user config

Synced user-level Claude Code configuration: `rules/`, `skills/`, and a
settings fragment. Deploy on every machine so the core workflow is identical
everywhere.

## Deploy

Either clone this repo as `~/.claude` itself (the `.gitignore` allowlist
keeps credentials, session state and machine-local settings untracked), or
clone it elsewhere and symlink `rules/`, `skills/`, and `statusline.sh` into
`~/.claude/`.

`settings.sync.json` is a fragment, not a live settings file: the harness
writes machine state into `~/.claude/settings.json` (theme, accepted
dialogs), so that file stays untracked. Merge the fragment into it once per
machine, and again whenever the fragment changes:

    jq -s '.[0] * .[1]' ~/.claude/settings.json settings.sync.json > /tmp/s.json \
      && mv /tmp/s.json ~/.claude/settings.json

The fragment carries the plugin set (with their marketplaces; Claude Code
installs them on next start), the hooks, and the additional directories.
The skills directories are listed there because the Workflow tool only
runs scripts from the project, an added directory, or a path it returned
itself; without them, skills that ship a workflow script (deep-review)
cannot launch. Permission checks resolve symlinks and require both the link
and its target to match, so the fragment lists `~/.claude/skills` and the
repo's own `skills/` at its assumed clone path, `~/Projects/claude-config`. The Claude in Chrome extension is
not a Claude Code plugin and cannot be synced here; Chrome's own profile sync
distributes it.

## Hooks

One PreToolUse hook on `git` commands blocks any `git commit` whose message
carries an AI attribution trailer, enforcing rules/no-coauthored-by-trailer.md
mechanically. It fails open on unparseable input and skips non-git commands
entirely via its `if` filter.
