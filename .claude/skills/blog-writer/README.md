# Blog Writer Skill

A Claude Code skill for writing blog posts in Jekyll markdown format with Gemini image placeholders.

## Usage

This skill is auto-invoked when you mention blog writing. Simply provide your content ideas:

### Example Prompt

```
I want to write a blog post about:

Title: "Why TypeScript Makes You a Better JavaScript Developer"

Key points:
- Type safety catches bugs early
- Better IDE autocomplete and refactoring
- Forces you to think about data structures
- Gradual adoption is possible

Evidence:
- Studies show 15% fewer bugs in TypeScript codebases
- Developer surveys show increased productivity

References:
- https://example.com/typescript-study
- https://example.com/developer-survey

Categories: Engineering, Web Development
Tags: TypeScript, JavaScript, Programming, Best Practices
```

### What You'll Get

The skill will generate a complete blog post with:
- Proper Jekyll frontmatter
- Well-structured content based on your points
- Gemini prompts for hero image and diagrams
- Appropriate formatting and style
- Saved to `_posts/` with correct filename

### Gemini Image Placeholders

Images will use this format:
```markdown
![Alt Text](GEMINI_PROMPT: Detailed description for image generation)
```

After the blog is generated, use your Gemini instance to generate images, then replace the placeholders with actual image paths.

## File Structure

- `SKILL.md` - Main skill definition (auto-loaded by Claude Code)
- `template.md` - Blog post template reference
- `README.md` - This file

## Blog Review Workflow

After generating a blog post, you can use the **blog-reviewer agent** to get professional feedback:

### Option 1: Slash Command
```
/review-blog
```
This automatically reviews the most recent blog post in `_posts/`.

### Option 2: Direct Agent Invocation
```
@blog-reviewer please review _posts/2026-03-10-my-post.md
```

### What You'll Get

The reviewer analyzes:
- **Title**: Attractiveness, clarity, length, power words
- **SEO**: Tags quality, description effectiveness, categories
- **Content**: Structure, quality, examples, flow
- **Technical**: Frontmatter, markdown, links, image placeholders
- **Engagement**: Tone, value, shareability

You'll receive a detailed report with:
- Ratings for each category (1-5 stars)
- Specific strengths and weaknesses
- Alternative title suggestions
- Tag and description recommendations
- Priority action items
- Overall score and feedback

### Complete Workflow

1. **Write**: Provide content ideas → blog-writer skill generates the post
2. **Review**: Run `/review-blog` → blog-reviewer agent analyzes it
3. **Improve**: Apply suggested changes based on feedback
4. **Polish**: Generate images with Gemini using the placeholders
5. **Publish**: Commit and deploy

## Customization

Edit `SKILL.md` to adjust:
- Content structure preferences
- Image placeholder format
- Default categories/tags
- Writing style guidelines

Edit `.claude/agents/blog-reviewer.md` to adjust:
- Review criteria and weights
- Scoring methodology
- Output format
- Target audience assumptions
