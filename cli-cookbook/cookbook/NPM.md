# npm/Node Cookbook

## Package Management
```bash
# Install all deps
npm install

# Add dependency
npm install <package>

# Add dev dependency
npm install -D <package>

# Global install
npm install -g <package>

# Update all
npm update

# Check outdated
npm outdated

# Audit security
npm audit
npm audit fix
```

## Scripts
```bash
# Run script
npm run <script>

# Common scripts
npm run dev
npm run build
npm run test
npm start
```

## npx (Execute without install)
```bash
# Run package directly
npx <package>

# Auto-install and run
npx -y <package>

# Specific version
npx <package>@latest
```

## Version Management (nvm)
```bash
# Install node version
nvm install 20

# Use specific version
nvm use 20

# Set default
nvm alias default 20

# List installed
nvm ls
```

## Troubleshooting
```bash
# Clear cache
npm cache clean --force

# Delete node_modules and reinstall
rm -rf node_modules package-lock.json && npm install

# Check global packages
npm list -g --depth=0
```

## Package.json Common Scripts
```json
{
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "lint": "eslint .",
    "test": "jest",
    "test:watch": "jest --watch"
  }
}
```
