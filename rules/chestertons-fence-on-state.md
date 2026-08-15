# Chesterton's fence on state

Never delete a mechanism whose motivation is not visible in the code without
first finding out why it exists: git blame, the MR that introduced it, or
asking the user or the change's author. When all of those come up empty, the
answer is to leave it standing, not to treat the check as passed. A
simplification that removes an undocumented invariant is a
regression wearing a cleanup's diff.

**Why:** state and guards accumulate around bugs the code cannot show; a
guard or piece of state that looks redundant may be the fix for a failure
users reported. The deletion reads as pure win right up until the scenario recurs,
and the complexity it removed was cheaper than the bug it restores.

**How to apply:** when a review finding or refactor proposes deleting state
or a guard, treat the deletion as riskier than the addition was. Establish
what invariant it might protect before removing it, and when a mechanism
guards a non-obvious requirement, leave a constraint comment so the next
reader does not have to excavate it again.
