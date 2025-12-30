# macOS Cookbook

## Process Management
```bash
# Kill by port
lsof -ti:3000 | xargs kill -9

# Find process by name
ps aux | grep <name>

# Kill by name
pkill -f <process-name>

# Top processes
top -o cpu
```

## File Operations
```bash
# Find files
find . -name "*.js" -type f

# Find large files
find . -type f -size +100M

# Disk usage
du -sh *

# Recursive file count
find . -type f | wc -l
```

## Terminal Spawning (osascript)
```bash
# New terminal window
osascript -e 'tell application "Terminal" to do script "command"'

# New tab
osascript -e 'tell application "Terminal" to do script "command" in front window'
```

## Clipboard
```bash
# Copy to clipboard
echo "text" | pbcopy

# Paste from clipboard
pbpaste

# Copy file contents
cat file.txt | pbcopy
```

## Network
```bash
# Check port
lsof -i :3000

# Local IP
ipconfig getifaddr en0

# Public IP
curl -s ifconfig.me

# DNS flush
sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder
```

## Homebrew
```bash
# Install package
brew install <package>

# Update all
brew update && brew upgrade

# List installed
brew list

# Search
brew search <name>

# Cleanup
brew cleanup
```
