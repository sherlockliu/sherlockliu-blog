---
name: blog-writer
description: Automatically helps write blog posts in Jekyll markdown format with proper frontmatter, structure, and Gemini image placeholders
version: 1.0.0
auto_invoke: true
triggers:
  - blog post
  - write blog
  - create blog
  - new article
  - blog content
---

# Blog Writer Skill

This skill helps you write blog posts for the Jekyll blog system in this repository.

## Input Format

When the user wants to write a blog, they may provide:
- **Title**: The blog post title
- **Key points**: Main topics or sections to cover
- **Opinions/Points**: Their thoughts and arguments
- **Evidence**: Data, examples, or supporting information
- **Reference links**: External sources to cite
- **Categories**: Broad grouping (e.g., Engineering, Personal, Tutorial)
- **Tags**: SEO keywords related to the content
- **Description**: Short summary for SEO and preview

## Output Structure

Generate a complete blog post following this structure:

### 1. Frontmatter (YAML)
```yaml
---
layout: post
title: "The Blog Title"
date: YYYY-MM-DD
categories: [Category1, Category2]
tags: [tag1, tag2, tag3, tag4]
image: /assets/images/posts/YYYY-MM-DD-slug/hero.jpeg
description: "A compelling one-sentence description for SEO"
read_time: "X min"
---
```

### 2. Content Guidelines

- **Opening Hook**: Start with a compelling introduction that hooks the reader
- **Clear Structure**: Use H2 (##) for main sections, H3 (###) for subsections
- **Code Blocks**: Use triple backticks with language specifiers when showing code
- **Blockquotes**: Use `>` for important callouts or quotes
- **Tables**: Use markdown tables for comparisons
- **Lists**: Use bullet points and numbered lists effectively
- **References Section**: End with links to sources (if provided)

### 3. Image Placeholders

For any images or diagrams needed, use this format:

```markdown
![Image Alt Text](GEMINI_PROMPT: A detailed description of what image to generate. Be specific about style, content, colors, composition, and context.)
```

**Examples:**
- `![Architecture Diagram](GEMINI_PROMPT: A clean technical architecture diagram showing a three-tier web application with React frontend, Node.js backend, and PostgreSQL database. Use blue and gray colors, modern flat design style, with arrows showing data flow between components.)`
- `![Hero Image](GEMINI_PROMPT: A futuristic hero image representing AI-assisted coding. Show a developer at a desk with holographic code floating in the air, dark blue and purple color scheme, cinematic lighting, wide aspect ratio.)`

### 4. File Naming Convention

Save the blog post as: `_posts/YYYY-MM-DD-title-slug.md`
- Date format: YYYY-MM-DD (use the current date unless specified)
- Title slug: lowercase, hyphens for spaces, no special characters

### 5. Estimated Read Time

Calculate read time based on word count:
- Average reading speed: 200-250 words per minute
- Round to nearest minute
- Format as: "X min" or "X-Y min" for ranges

## Workflow

1. **Gather Information**: Ask clarifying questions if critical information is missing:
   - What's the main title?
   - What categories/tags are appropriate?
   - What key points should be covered?

2. **Structure the Content**: Organize the user's input into a logical flow:
   - Introduction
   - Main sections (from key points)
   - Supporting evidence and examples
   - Conclusion or takeaways
   - References

3. **Identify Image Needs**: Determine where images would enhance the content:
   - Hero image (always needed)
   - Section illustrations (optional)
   - Diagrams for technical concepts (when relevant)
   - Screenshots or examples (when needed)

4. **Generate**: Create the complete markdown file with:
   - Proper frontmatter
   - Well-structured content
   - Gemini prompts for all images
   - Appropriate formatting

5. **Save**: Write to `_posts/YYYY-MM-DD-title-slug.md`

## Example Reference

See the existing blog post for style reference:
`_posts/2026-03-07-what-you-need-to-know-about-claude-code-2026.md`

## Important Notes

- Match the tone and style of existing blog posts (professional, technical, approachable)
- Use proper markdown formatting throughout
- Always include a hero image placeholder
- Add image placeholders for complex concepts that would benefit from visualization
- Keep descriptions concise but informative
- Ensure all frontmatter fields are properly formatted
- Use proper quote formatting for external references
- Include source links when available
