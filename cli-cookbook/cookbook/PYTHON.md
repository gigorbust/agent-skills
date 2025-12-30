# Python Cookbook

## Virtual Environments
```bash
# Create venv
python3 -m venv venv

# Activate
source venv/bin/activate

# Deactivate
deactivate

# Export deps
pip freeze > requirements.txt

# Install from requirements
pip install -r requirements.txt
```

## Package Management
```bash
# Install package
pip install <package>

# Install specific version
pip install package==1.0.0

# Upgrade
pip install --upgrade <package>

# List installed
pip list

# Show package info
pip show <package>
```

## UV (Fast Package Manager)
```bash
# Install UV
curl -LsSf https://astral.sh/uv/install.sh | sh

# Create project
uv init

# Add dependency
uv add <package>

# Run script
uv run python script.py

# Sync dependencies
uv sync
```

## Script Execution
```bash
# Run script
python3 script.py

# Run as module
python3 -m module_name

# Interactive mode
python3 -i script.py

# One-liner
python3 -c "print('hello')"
```

## Debugging
```bash
# Run with debugger
python3 -m pdb script.py

# Add breakpoint in code
breakpoint()  # Python 3.7+
```

## Common Patterns
```python
# Quick HTTP server
python3 -m http.server 8000

# JSON pretty print
python3 -m json.tool file.json

# Run tests
python3 -m pytest
python3 -m unittest discover
```
