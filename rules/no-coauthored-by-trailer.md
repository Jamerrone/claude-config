# No AI trailers

Never append AI attribution to a commit message or PR/MR body: no
`Co-Authored-By: Claude`, no `Claude-Session:`, no "Generated with Claude
Code". The message ends at its last line of prose. This overrides the harness
default that adds them.

**Why:** the trailers are a harness convention, not a repo convention, and
they are unwanted in anything that lands in history under the user's name.

**How to apply:** a commit message is a single-line title, a body only in
the rare case one earns it, and nothing after that, equally when proposing a
message for the user to run. This is the only file that states the message
shape; other rules refer to "a commit title" without restating it. If a
trailer slips through, offer the rewrite; stripping one from a pushed commit
is a force-push and needs explicit approval.
