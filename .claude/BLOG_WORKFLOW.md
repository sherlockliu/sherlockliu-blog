# Blog Writing & Review Workflow

Complete guide to writing and reviewing blog posts using Claude Code skills and agents.

## Overview

This repository has two main components for blog creation:

1. **blog-writer** (Skill) - Auto-generates blog posts from your ideas
2. **blog-reviewer** (Agent) - Reviews posts for quality, SEO, and engagement

## Quick Start

### Write a Blog Post

Simply mention blog writing in a Claude Code session:

```
Write a blog about:
Title: "The Rise of AI-Powered Development Tools"
Key points:
- Historical context of developer tools
- Current state of AI coding assistants
- Future predictions
Evidence: GitHub Copilot has 1M+ users
References: https://github.blog/ai-stats
Categories: Engineering, AI
Tags: AI, Development, Tools, Productivity
```

Or use the slash command:
```
/blog
```

### Review the Blog Post

After generation, review it:

```
/review-blog
```

Or target a specific post:
```
@blog-reviewer review _posts/2026-03-10-my-post.md
```

## Component Details

### 📝 blog-writer Skill

**Location**: `.claude/skills/blog-writer/`

**Auto-invoked when you mention**: blog post, write blog, create blog, new article

**What it does**:
- Generates proper Jekyll frontmatter
- Structures content with sections and flow
- Adds Gemini prompts for images
- Calculates read time
- Saves to `_posts/YYYY-MM-DD-slug.md`

**Files**:
- `SKILL.md` - Skill definition and instructions
- `template.md` - Blog post template
- `README.md` - Usage documentation

### 🔍 blog-reviewer Agent

**Location**: `.claude/agents/blog-reviewer.md`

**Invoked by**: `@blog-reviewer` or `/review-blog` command

**What it reviews**:

1. **Title Analysis** (1-5 stars)
   - Attractiveness and click-worthiness
   - Clarity and specificity
   - Length optimization
   - Use of power words

2. **SEO Optimization** (1-5 stars)
   - Tag quality and relevance
   - Description effectiveness (meta)
   - Category appropriateness
   - Keyword usage

3. **Content Quality** (1-5 stars)
   - Opening hook strength
   - Structure and organization
   - Depth and value
   - Examples and evidence
   - Flow and readability

4. **Technical Aspects** (Pass/Fail)
   - Frontmatter completeness
   - Markdown formatting
   - Link validity
   - Image placeholder quality
   - File naming convention

5. **Audience Engagement** (1-5 stars)
   - Tone appropriateness
   - Actionable value
   - Relatability
   - Shareability

**Output**: Comprehensive review with scores, suggestions, and priority actions

## Complete Workflow Example

```bash
# 1. Start Claude Code
claude

# 2. Write the blog
> Write a blog post about microservices vs monoliths
>
> Title: "Microservices vs Monoliths: Choosing the Right Architecture in 2026"
>
> Key points:
> - When to choose microservices
> - When monoliths are better
> - Migration strategies
> - Real-world case studies
>
> Evidence:
> - Survey shows 60% of companies use microservices
> - But 40% regret the complexity
>
> References:
> - https://example.com/architecture-survey
>
> Categories: Engineering, Architecture
> Tags: Microservices, Architecture, DevOps, System Design

# Blog is generated at _posts/2026-03-10-microservices-vs-monoliths-2026.md

# 3. Review the blog
> /review-blog

# Review report shows:
# - Title: 4/5 (good but could be punchier)
# - SEO: 3/5 (needs more specific tags)
# - Content: 4.5/5 (strong content, minor flow issues)
# - Technical: Pass (all checks passed)
# - Engagement: 4/5 (high value, good tone)

# 4. Apply suggestions
> Can you update the title to one of the suggested alternatives?
> And add the recommended tags?

# 5. Review again (optional)
> /review-blog

# 6. Generate images
# Exit Claude Code and use Gemini to generate images from placeholders
# Replace GEMINI_PROMPT placeholders with actual image paths

# 7. Commit and publish
git add .
git commit -m "Add new blog post: Microservices vs Monoliths"
git push
```

## Slash Commands Reference

| Command | Purpose |
|---------|---------|
| `/blog` | Start blog writing workflow with guided prompts |
| `/review-blog` | Review the most recent blog post |

## Agent Invocation

| Method | Example | Use Case |
|--------|---------|----------|
| @ mention | `@blog-reviewer review _posts/my-post.md` | Review specific post |
| Slash command | `/review-blog` | Review latest post |
| In conversation | "Can you review this blog?" | Natural invocation |

## Image Placeholder Format

Generated blogs use this format for images:

```markdown
![Hero Image](GEMINI_PROMPT: A modern illustration of microservices architecture showing multiple interconnected services with API gateways. Use blue and green color scheme, clean flat design, wide aspect ratio suitable for blog hero image.)
```

### Replacing Placeholders

1. Copy the prompt text after `GEMINI_PROMPT:`
2. Use it in Gemini to generate the image
3. Save image to `/assets/images/posts/YYYY-MM-DD-slug/`
4. Replace the placeholder:
   ```markdown
   ![Hero Image](/assets/images/posts/2026-03-10-my-post/hero.jpeg)
   ```

## File Structure

```
.claude/
├── skills/
│   └── blog-writer/
│       ├── SKILL.md           # Auto-invoked skill
│       ├── template.md        # Blog template
│       └── README.md          # Documentation
├── agents/
│   └── blog-reviewer.md       # Review agent
├── commands/
│   ├── blog.md                # /blog command
│   └── review-blog.md         # /review-blog command
└── BLOG_WORKFLOW.md           # This file

_posts/
└── YYYY-MM-DD-title-slug.md   # Generated blog posts
```

## Customization

### Adjust Blog Style

Edit `.claude/skills/blog-writer/SKILL.md`:
- Change content structure templates
- Modify tone and style guidelines
- Update category/tag conventions
- Adjust image placeholder format

### Adjust Review Criteria

Edit `.claude/agents/blog-reviewer.md`:
- Change scoring weights
- Add/remove review criteria
- Modify output format
- Adjust target audience assumptions

### Add New Commands

Create `.claude/commands/your-command.md`:
```markdown
[Your command instructions here]
```

Then invoke with `/your-command`

## Tips & Best Practices

1. **Be specific with input**: More details = better output
2. **Review every time**: Use the reviewer to maintain quality
3. **Iterate on titles**: Test 2-3 title options before finalizing
4. **Check SEO tags**: Make sure tags are searchable terms people actually use
5. **Detailed image prompts**: Good Gemini prompts = better images
6. **Test read time**: Verify the estimated read time feels accurate
7. **Get human eyes**: Final review by a human before publishing
8. **Track performance**: Note which titles/formats perform best

## Troubleshooting

**Skill not auto-invoking?**
- Make sure you mention keywords: "blog post", "write blog", etc.
- Or explicitly use `/blog` command

**Agent not found?**
- Verify `.claude/agents/blog-reviewer.md` exists
- Try `@blog-reviewer` explicitly

**Review seems generic?**
- Make sure the blog post exists in `_posts/`
- Provide the specific file path if multiple posts exist

**Want to review during writing?**
- You can invoke the reviewer at any time
- It will read the current state of the file

## Need Help?

- Check skill documentation: `.claude/skills/blog-writer/README.md`
- Check agent definition: `.claude/agents/blog-reviewer.md`
- Review existing blog: `_posts/2026-03-07-what-you-need-to-know-about-claude-code-2026.md`
