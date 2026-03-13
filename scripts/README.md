# Deployment Scripts

Scripts for building and deploying sherlockliu.co.uk blog.

## Available Scripts

### `deploy-hostinger.sh`
**Main deployment script** - Builds site in production mode and deploys to Hostinger.
- Builds with `JEKYLL_ENV=production`
- Syncs `_site/` to `domains/sherlockliu.co.uk/public_html/`
- Shows dry-run preview before actual deployment
- Requires confirmation before deploying

**Usage:**
```bash
./scripts/deploy-hostinger.sh
# or
make deploy
```

### `build-production.sh`
Builds the site in production mode with optimizations.
- Cleans previous build
- Builds with `JEKYLL_ENV=production`
- Removes development files (source maps, config files, etc.)
- Shows build size

**Usage:**
```bash
./scripts/build-production.sh
# or
make build-prod
```

### `verify-build.sh`
Verifies the Jekyll build is valid and complete.
- Runs production build
- Checks for critical files (index.html, feed.xml, /blog/)
- Counts blog posts
- Shows build size

**Usage:**
```bash
./scripts/verify-build.sh
# or
make verify
```

### `pre-deploy-check.sh`
Pre-deployment checks before deploying.
- Checks git status for uncommitted changes
- Builds production site
- Checks for large files (>1MB)

**Usage:**
```bash
./scripts/pre-deploy-check.sh
```

### `deploy.sh`
Git-based deployment (deploys to `deploy` branch).
**Note:** Currently not used for Hostinger deployment.

## Configuration

### Environment Variables

Copy `.env.example` to `.env` and configure your deployment credentials:

```bash
cp .env.example .env
# Edit .env with your actual credentials
```

Required variables in `.env`:
- `HOSTINGER_SSH_ALIAS` - SSH alias from ~/.ssh/config
- `HOSTINGER_SSH_USER` - Your SSH username
- `HOSTINGER_SSH_HOST` - Server IP address
- `HOSTINGER_SSH_PORT` - SSH port (usually 22 or 65002)
- `HOSTINGER_PATH` - Remote deployment path
- `SITE_URL` - Your site URL

## Deployment Workflow

```bash
# 1. Verify your build
make verify

# 2. (Optional) Run pre-deployment checks
./scripts/pre-deploy-check.sh

# 3. Deploy to production
make deploy
```

## Requirements

- `.env` file configured (copy from `.env.example`)
- SSH access configured in `~/.ssh/config`:
  ```
  Host your-ssh-alias
    HostName your-server-ip
    User your-username
    Port your-ssh-port
    IdentityFile ~/.ssh/your-key
  ```
- `rsync` installed (default on macOS)
- Jekyll and dependencies installed (`bundle install`)

## Security

- **Never commit `.env`** - It contains credentials and is excluded in `.gitignore`
- Use `.env.example` as a template for documentation
- Keep SSH keys secure and use passphrases
