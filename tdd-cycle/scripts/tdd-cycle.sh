#!/bin/bash
# tdd-cycle - Bite-sized TDD enforcer
# Based on obra/superpowers: writing-plans

echo "🔄 TDD Cycle Started"
echo "Goal: One atomic commit."

echo "1. Describe the test case (What should fail?):"
read -r TEST_CASE
echo "   -> Go write the test for: $TEST_CASE"
read -p "Press [Enter] once failure is confirmed..."

echo "2. Describe the minimal fix:"
read -r FIX_DESC
echo "   -> Go write the code."
read -p "Press [Enter] once test passes..."

echo "3. Describe any refactoring needed (or 'none'):"
read -r REFACTOR
if [ "$REFACTOR" != "none" ]; then
    echo "   -> Go refactor."
    read -p "Press [Enter] once tests pass again..."
fi

echo "4. Commit Message:"
read -r COMMIT_MSG
git commit -m "feat: $COMMIT_MSG (TDD: $TEST_CASE)"
echo "✅ Cycle Complete."
