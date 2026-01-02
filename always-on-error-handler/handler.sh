#!/bin/bash
# Always-On Error Handler - PostToolUse Hook
# Logs errors and triggers recovery strategies

ERROR_LOG="$HOME/Desktop/Meztal/.agentic/logs/errors.jsonl"
mkdir -p "$(dirname "$ERROR_LOG")"

# Check if last tool call had an error (passed via environment)
if [ -n "$TOOL_ERROR" ]; then
    TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
    
    # Log the error
    echo "{\"timestamp\":\"$TIMESTAMP\",\"level\":\"ERROR\",\"tool\":\"$TOOL_NAME\",\"error\":\"$TOOL_ERROR\",\"recovery\":{\"attempted\":false}}" >> "$ERROR_LOG"
    
    # For critical errors, create alert file
    if echo "$TOOL_ERROR" | grep -qi "security\|corruption\|critical"; then
        echo "🚨 CRITICAL ERROR: $TOOL_ERROR" >> "$HOME/Desktop/Meztal/.agentic/logs/CRITICAL_ALERTS.txt"
    fi
fi

# Always run quick health check on errors
if [ -n "$TOOL_ERROR" ]; then
    # Check if node and health monitor exist
    if command -v node &> /dev/null && [ -f "$HOME/Desktop/Meztal/lib/health-monitor.js" ]; then
        node "$HOME/Desktop/Meztal/lib/health-monitor.js" --quick 2>/dev/null || true
    fi
fi
