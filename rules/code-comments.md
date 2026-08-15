# Code comments

A docstring and a comment inside a body answer different questions: a docstring
says what, a body comment says why. Keep the two apart, and write either only
where it earns its place.

**Why:** AI-generated code over-comments in two ways: paragraph-length
commentary where none or one line is enough, and commentary aimed at the
current conversation (justifying a change, citing a discussion or rejected
alternative). A comment must make sense to a future reader who never saw the
conversation. Docstrings are the exception to minimalism: a documented public
surface is what lets a caller stop reading at the signature.

**How to apply:**

Docstrings say what:

- One docstring above every module and every exported symbol. Never stack two.
- Lead with what it is and what it gives back; a reader should be able to say
  what it returns without opening the body. One or two sentences; a second
  paragraph only for a constraint the signature cannot carry.
- Write one even where the name is obvious, and keep it to the plain sentence:
  the failure is padding it out, not stating the plain thing. A docstring that
  paraphrases the implementation line by line is padding.
- A domain fact callers rely on (a reference value, a rate, what a formula
  yields) belongs in the docstring of the thing it describes, not in a comment
  above a test assertion. A behaviour change dates the docstring: check that
  what it claims still holds before finishing the edit.
- Internal, non-exported code gets a docstring only where the signature cannot
  carry what it does.

Comments inside a body say why:

- Default to no comment. Add one only for a hidden constraint, an assumption
  the code relies on and cannot check, or reasoning the code itself cannot
  show. Usually one line, never a paragraph.
- Never reference the conversation, the change being made, history, or
  alternatives that are not in the code. This includes bug-fix "why not X"
  comments: if sibling code makes the same kind of choice without
  justification, the fixed line needs none either; the why belongs in the
  regression test and the commit message.
- A comment defending the chosen approach against an alternative nobody would
  propose is noise, even when that alternative was just discussed.

Both:

- State the constraint, not the anecdote. A wrong comment is worse than none:
  anything checkable (a count, a rate, a filename, a claim about a return
  value) gets checked when nearby code changes, so keep claims current or cut
  them.
- Say it once. A fact stated in two places drifts in one of them; put it where
  its subject lives and link from anywhere else that needs it.
- Style: match the repo-wide convention, not a small local sample of files.
  In languages offering both syntaxes, prefer `//` for inline comments and
  `/** */` only for the docstrings the rules above call for; never introduce
  single-star `/* */` where the convention does not already use it.
