# Verify UI in a real browser

Verify a UI change against the locally running app with browser tools before
proposing a commit. Tests are necessary, not sufficient.

**Why:** alignment, stacking, z-order and sticky behavior fail in ways no
unit test or code read exposes; only a rendered page shows them.

**How to apply:**

- Verify with Claude in Chrome, not the chrome-devtools MCP, unless told
  otherwise: it drives the real page the way a user does.
- Measure with in-page JS (getBoundingClientRect, getComputedStyle), never by
  eyeballing screenshots: a screenshot is scaled relative to CSS pixels, and
  glyph ink sits lower than its span box.
- Repo mechanics (URLs, fixture refresh, dev-server quirks) belong in the
  project's auto-memory, not here.
