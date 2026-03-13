# SherlockLiu Blog

Personal blog built with Jekyll, hosted at [sherlockliu.co.uk](https://sherlockliu.co.uk).

## Quick Start

### 1. Install Dependencies

```bash
bundle install
```

### 2. Configure Environment

```bash
# Copy environment template
cp .env.example .env

# Edit .env with your credentials
nano .env
```

### 3. Run Locally

```bash
# Development server with live reload
make serve

# Or manually
bundle exec jekyll serve --livereload
```

Visit http://localhost:4000

## Deployment

### Prerequisites

1. **Environment Setup**: Configure `.env` file (see `.env.example`)
2. **SSH Access**: Configure SSH alias in `~/.ssh/config`

### Deploy to Production

```bash
# Verify build first
make verify

# Deploy to Hostinger
make deploy
```

See [scripts/README.md](scripts/README.md) for detailed deployment documentation.

## Available Commands

```bash
make help              # Show all available commands
make install           # Install dependencies
make build             # Build the site
make serve             # Serve locally with live reload
make clean             # Clean build artifacts
make build-prod        # Production build
make verify            # Verify build integrity
make deploy            # Deploy to production
make optimize-images   # Optimize PNG images
```

## Project Structure

```
.
├── _config.yml         # Jekyll configuration
├── _includes/          # Reusable components
├── _layouts/           # Page templates
├── _posts/             # Blog posts
├── assets/             # Images, CSS, JS
├── scripts/            # Deployment scripts
├── Makefile            # Build commands
├── .env                # Environment variables (not in git)
└── .env.example        # Environment template
```

## Writing Blog Posts

Posts are in `_posts/` directory with format: `YYYY-MM-DD-title.md`

### Frontmatter Template

```yaml
---
layout: post
title: "Your Post Title"
date: YYYY-MM-DD
categories: [Category1, Category2]
tags: [tag1, tag2, tag3]
image: /assets/images/posts/YYYY-MM-DD-slug/hero.jpeg
description: "SEO description"
read_time: "X min"
toc: true  # Enable table of contents
---
```

### Series Posts

Add series metadata:

```yaml
series:
  name: "Series Name"
  description: "Series description"
  part: 1
  total: 6
  next_url: "/path/to/next-post.html"
  next_title: "Next Post Title"
```

## Features

- ✅ Series navigation for multi-part posts
- ✅ Table of contents with active section highlighting
- ✅ Giscus comments (GitHub Discussions)
- ✅ SEO optimization
- ✅ RSS feed
- ✅ Dark mode support
- ✅ Image optimization tools

## Security

- **Never commit `.env`** - Contains credentials, excluded in `.gitignore`
- Keep SSH keys secure
- Use environment variables for all sensitive data

## Tech Stack

- **Static Site Generator**: Jekyll 4.x
- **Hosting**: Hostinger
- **Comments**: Giscus (GitHub Discussions)
- **Deployment**: rsync over SSH
- **Analytics**: Google Analytics

## License

Personal blog - All rights reserved.

## Author

**SherlockLiu**
- Website: [sherlockliu.co.uk](https://sherlockliu.co.uk)
- LinkedIn: [linkedin.com/in/sherlockliu](https://linkedin.com/in/sherlockliu)
