---
name: prose-audit
description: Audits the prose a change added to files it will commit, against the user's rules for em dashes and for comments and docstrings. Use as the last step before proposing a commit, after applying any /deep-review fixes, or whenever a change added or edited comments, docstrings, a README or a design doc.
---

# Prose audit

## 1. Read the rules

    cat ~/.claude/rules/no-em-dashes.md ~/.claude/rules/code-comments.md

Add the project's own comment and writing rules, from CLAUDE.md or its docs.

## 2. Take the lines this change added

    git diff HEAD | grep -E "^\+" | grep -v "^+++"

For each hit, first decide whether this change authored the text or only edited
a line that already carried it. Only authored text is in scope.

## 3. Find the em dashes you added

    git diff HEAD | grep -E "^\+" | grep -v "^+++" | grep "—"

For a generated file, check its generator instead.

## 4. Read every comment and docstring you added

Against `code-comments.md` in full, then the project's own rules.

## 5. Find prose the change broke without rewriting it

Editing around text can mangle or falsify it while leaving it untyped, so these
are missed by steps 3 and 4. Four ways it happens:

- **A wrapped comment left ragged.** Shortening a sentence inside one strands a
  line holding a word or two, because no formatter rewraps comments.
- **A docstring pointing at the wrong symbol.** Inserting a declaration between
  a docstring and what it documented reassigns it silently.
- **A claim falsified from a distance.** A rename or a regrouping makes
  sentences wrong in files the change never opened. Grep the whole tree for the
  old term, not just the files in the diff.
- **A fact now in two places.** Something the change wrote down that already
  lived somewhere else.

## 6. Report, then repeat

Say what you changed, then run steps 2 to 5 again over the new diff.
