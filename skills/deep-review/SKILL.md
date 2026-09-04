---
name: deep-review
description: Workflow-backed code review with independent verification and a report cap of 32. Use wherever /code-review would be used.
---

Run the workflow-backed code review instead of reviewing inline.

Invoke: Workflow({ scriptPath: "<skill base directory>/review-workflow.js", args: "<level> <target>" })

Level is `high` by default; pass `xhigh` or `max` only when the user asks for
a deeper pass (both add correctness angles and the Sweep phase). Every angle
of a level always runs; the diff size only decides how many finders carry
them. Pass the level token exactly; an unrecognized first word is treated as
part of the target, not a level.

Everything after the level in the args string is passed to the workflow as the review target / instructions. If the user gave additional instructions for this review elsewhere in the conversation (a scope restriction, files to focus on, things to skip), append them to the args string so the workflow honors them.

The workflow runs its finders and verify pass in the background; the verified findings arrive as a task notification. When they arrive, call ReportFindings once with {level, findings} from the result payload (most-severe first; empty array if nothing survived). Give each finding a `short_summary`: the claim compressed to ≤60 characters, no rationale or consequence clause. Do not also print the findings as text.

## Reporting the run

If the payload is an error object with no findings (the scope step failed),
do not call ReportFindings: report the error to the user and offer to re-run.

Otherwise, report the stats the payload actually carries alongside the
findings (a full run reports diffLines, finders, candidates, verified, refuted, and reported;
early exits omit fields they never computed; report only what is present,
never invent a value). The counts are not nested subsets: refuted is the
slice of verified that failed re-checking, and reported is the synthesis
step's root-cause merge of the survivors, so one defect can absorb many
verified rows. Never subtract one count from another and present the
difference as work remaining.

If `reported` equals the cap (32), the report may be truncated (the payload
cannot distinguish exactly-32 defects from a capped tail). 32 is also the
most findings a single ReportFindings call accepts, so a recovered tail can
never join the rendered report; say the report is at the ceiling and offer
to recover the tail for triage. To do that, copy review-workflow.js to a
temporary location and raise `maxFindings` in the copy (never edit this
skill's own review-workflow.js, which would change every future run), then
re-invoke `Workflow({scriptPath: <the copy>, resumeFromRunId, args})` with
the args string byte-identical; finders and verifiers replay from cache and
only the synthesis re-runs. Report the top 32 through ReportFindings and
present the tail separately in prose, saying that is what it is.

The payload itself carries no trace of failed agents; that signal arrives in
the completion notification's diagnostics (its failures block and error
count). If those report failed agents, or the payload's summary says the
synthesis step was skipped and findings were returned unmerged, resume the
same way before analysing anything: completed agents replay from cache and
only the failed ones re-run. Never hand-merge a partial payload: a candidate
that never reached a verifier is absent rather than marked, so a hand-merge
drops it silently. While a known tail exists, prefer resuming to a fresh run;
a fresh run re-rolls the finders and can silently drop findings they already
had.

## If findings are fixed later

Whenever reported findings get fixed later in this session - the user asks you
to fix them, or later work fixes them incidentally - you MUST call ReportFindings again with the same findings, each
carrying an `outcome`: `fixed`, `no_change_needed` (the finding was wrong or
already handled), or `skipped` (real but not applied). Do not repeat the
findings as text.
Make that call immediately after the fixes land, before any prose summary; the
host UI's per-finding status updates only from it, and without it the findings
stay marked unresolved.
