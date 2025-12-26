#!/bin/bash
# systematic-debugging - The Iron Law Enforcer
# Based on obra/superpowers: systematic-debugging

DEBUG_LOG="docs/debugging/$(date +%Y-%m-%d)-incident.md"
mkdir -p docs/debugging

echo "🛑 STOP. SYSTEMATIC DEBUGGING ENFORCED."
echo "The Iron Law: NO FIXES WITHOUT ROOT CAUSE INVESTIGATION FIRST."
echo "Documenting session to: $DEBUG_LOG"

echo "# Debugging Session: $(date)" > "$DEBUG_LOG"

# Phase 1
echo ""
echo "## Phase 1: Root Cause Investigation"
echo "1. Error Messages (Paste full stack trace):"
read -r ERRORS
echo "2. Reproduction Steps (Exact steps to trigger):"
read -r REPRO

echo "## Phase 1: Root Cause Investigation" >> "$DEBUG_LOG"
echo "**Errors:** $ERRORS" >> "$DEBUG_LOG"
echo "**Reproduction:** $REPRO" >> "$DEBUG_LOG"

# Phase 2
echo ""
echo "## Phase 2: Pattern Analysis"
echo "What works that is similar? (Reference file/line):"
read -r WORKING_REF
echo "**Working Reference:** $WORKING_REF" >> "$DEBUG_LOG"

# Phase 3
echo ""
echo "## Phase 3: Hypothesis"
echo "I think X is the root cause because Y:"
read -r HYPOTHESIS
echo "**Hypothesis:** $HYPOTHESIS" >> "$DEBUG_LOG"

echo ""
echo "✅ Investigation documented. You may now proceed to Phase 4 (Implementation)."
echo "Run 'code $DEBUG_LOG' to keep this open."
