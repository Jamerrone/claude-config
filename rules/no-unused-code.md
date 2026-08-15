# No unused code

Delete unused code rather than keeping it, and never add a mechanism, option
or parameter before something uses it. The same constraint pointing backward
and forward: code nothing uses does not belong in the tree.

**Why:** the bar is unused, not untested; code kept in case it is wanted
later is code nobody revisits and everybody reads past, and speculative
generality is the same dead weight added in advance.

**How to apply:** when removing, the question is only whether anything uses
it now (code that is used but unexplained falls under the Chesterton's-fence
rule instead). When adding, ship the concrete case and generalize on the
second caller, not before.
