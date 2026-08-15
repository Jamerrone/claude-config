# Tests

Cover the core logic; full coverage is not the goal. Every assertion must be
able to fail.

**Why:** AI-written tests fail silently in characteristic ways: an assertion
that reads a field which does not exist passes over `undefined` forever, an
empty input set makes a loop of assertions vacuously true, and an expected
value computed by the code under test agrees with any implementation, right or
wrong.

**How to apply:**

- Assert against something real. Check sample sizes and non-empty inputs
  wherever a silent empty set would make the assertion vacuous.
- Break the code to prove the guard works: delete the line a test protects,
  run the suite, put it back. A test that stayed green guarded nothing.
  Passing says only that the code and the test agree today, which is also
  true when both are wrong.
- Never ask the code under test what to expect. Restate the expectation, even
  where that duplicates a table or constant. A test that asks a function
  whether its own output is permitted holds however the function is broken,
  and a fixture that derives its expected value from the same source it is
  checking passes on a coincidence.
