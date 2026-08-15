# Milestone commit workflow

Multi-step work lands as one commit per milestone, with the diff reviewed
first (/deep-review, or /code-review at high effort). Fixes from a review
belong inside the commit they fix, via fixup commits and
`git rebase --autosquash`, never in a trailing "fix review findings" commit.
Committing itself is governed by the no-autonomous-commits rule.

**Why:** each commit is reviewed on its own in the MR, so each must be
trustworthy on its own. A fix landed beside its mistake preserves the mistake
in history and splits one change across two diffs.

**How to apply:** verify the milestone first (for UI work, as the
real-browser verification rule requires), then propose a commit title
unprompted. A milestone spanning core and feature code
splits into two commits along that line. Keep the stack current with
`git rebase origin/<default-branch> --update-refs`, using the repo's actual
default branch.
