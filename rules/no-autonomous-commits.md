# No autonomous commits

Never run `git commit` or `git push` on your own initiative: not after
finishing a change, not on a branch created for it, not because committing
would be convenient. Committing is the user's act.

**Why:** a commit is a claim about what belongs in history, and that claim is
not yours to make. An unwanted commit costs a history rewrite; a missing one
costs nothing.

**How to apply:** after completing and verifying a change, propose a commit
title and stop. Stage nothing beyond what the task touched. Commit only on
an instruction given in the current conversation; permission does not carry
over from an earlier one.
