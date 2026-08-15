# Run the formatter before presenting work

Before presenting or committing a change in a repo that has a formatter, run
the project's own format command on the files you touched. Its check is the
final word on formatting; never overrule it by hand.

**Why:** hand-alignment and taste-based wrapping get reverted by the next
formatter run, and an unformatted change fails the format check in CI or
dirties the diff for whoever runs the formatter next.

**How to apply:**

- Find the project's command (a format script in package.json, a Makefile
  target, or the tool named by a config file such as .prettierrc or
  rustfmt.toml) and run it, scoped to touched files where the tool allows.
- Never hand-align tables or continuation lines, and never add an ignore
  pragma to protect hand-formatting.
- Never reformat lines the change does not otherwise touch; a reformat-only
  hunk is diff noise that buries the real change.
- If the repo has no formatter, match the surrounding code and stop; do not
  introduce one unasked.
