# Draft Posts

This folder contains blog posts that are still **work-in-progress** and not ready for publication.

## How It Works

### Two Ways to Hide Posts

#### 1. Use `_drafts/` folder (for work-in-progress)
- Place new posts here while you're writing them
- Drafts won't appear in production builds
- Filenames don't need dates: `my-draft-post.md` (not `2026-03-14-my-draft-post.md`)
- Preview drafts locally with: `bundle exec jekyll serve --drafts`

#### 2. Use `published: false` flag (for hiding published posts)
- Add `published: false` to the frontmatter of any post in `_posts/`
- The post stays in `_posts/` but won't show on the site
- Useful for temporarily hiding posts without moving files

## Workflow

### Starting a New Post
```bash
# Create draft (no date in filename)
touch _drafts/my-new-post.md
```

**Frontmatter for draft:**
```yaml
---
layout: post
title: "My New Post Title"
categories: [Engineering]
tags: [AI, Design]
image: /assets/images/posts/my-new-post/hero.jpeg
description: "Draft description"
read_time: "10 min"
---
```

### Publishing a Draft
```bash
# When ready to publish, move to _posts/ with date
mv _drafts/my-new-post.md _posts/2026-03-14-my-new-post.md
```

### Hiding a Published Post
Add to frontmatter:
```yaml
published: false  # ← Add this line
```

No need to move the file - it stays in `_posts/` but won't display.

## Preview Locally

**Production mode (drafts hidden):**
```bash
bundle exec jekyll serve
```

**Development mode (show drafts):**
```bash
bundle exec jekyll serve --drafts
```

## Best Practices

- Keep work-in-progress posts in `_drafts/`
- Use `published: false` only for temporarily hiding published content
- Commit drafts to version control if you want team visibility
- Add `_drafts/` to `.gitignore` if you want to keep drafts private
