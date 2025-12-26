# The Iron Law of Debugging
**NO FIXES WITHOUT ROOT CAUSE INVESTIGATION FIRST.**

## Phase 1: Root Cause Investigation
**Goal:** Prove exactly *why* it is failing.
1.  **Read Error Messages:** Don't skim. Read the stack trace.
2.  **Reproduce:** Can you make it fail on demand? If not, you are guessing.
3.  **Check Recent Changes:** What changed since it worked?
4.  **Trace Data Flow:** Where did the bad value come from?

## Phase 2: Pattern Analysis
**Goal:** Understand how it *should* work.
1.  **Find Working Examples:** Where does this pattern work elsewhere in the codebase?
2.  **Compare:** What is different between the working version and the broken version?
3.  **Read Docs:** Do not guess API usage.

## Phase 3: Hypothesis & Testing
**Goal:** Prove your theory with a minimal test.
1.  **Form Hypothesis:** "I think X is broken because Y."
2.  **Test Minimally:** Change *one* thing to test the hypothesis.
3.  **Verify:** Did the test confirm the hypothesis?

## Phase 4: Implementation
**Goal:** Apply the fix safely.
1.  **Fix:** Apply the proven fix.
2.  **Verify:** Run the repo steps from Phase 1.
3.  **Regression Test:** Ensure nothing else broke.
