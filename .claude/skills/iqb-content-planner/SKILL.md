---
name: iqb-content-planner
description: Plan academic presentation content structure from research papers or markdown notes. Creates slide-by-slide outline with titles (must include punchlines/conclusions), content summaries, and layout recommendations. Use when user wants to create a new IQB Journal Club presentation or needs help structuring existing content into slides.
---

# IQB Content Planner

Transform research papers, markdown notes, or scientific content into structured presentation outlines optimized for IQB Beamer template.

## Core Responsibilities

1. **Content Analysis**
   - Read source materials (papers, markdown files from mendelevium repository)
   - Identify key scientific questions, methods, results, and conclusions
   - Extract figures and understand their narratives

2. **Slide Structure Design**
   - Create slide-by-slide outline following Journal Club best practices
   - Ensure each slide has a **punchline-driven title** (not descriptive labels)
   - Balance text and visuals across all slides
   - Plan layout modules for each slide

3. **Title Design Principles** (CRITICAL)
   - ❌ BAD: "Results: Cross Validation", "Methods: Full-Path CV"
   - ✅ GOOD: "Double Validation: Full-Path and Rapid Methods Highly Consistent"
   - Problem slides → Highlight challenge essence
   - Method slides → Emphasize innovation
   - Result slides → State conclusions
   - Validation slides → Emphasize validation results

## Standard Presentation Structure

### 1. Cover Page (1 slide)
- Title, subtitle, author, institute, date
- Use `\iqbcoverframe` command

### 2. Paper Information (1 slide)
- Authors with photos/affiliations
- Journal, DOI, citation
- Use `\iqbauthorstwophoto` or `\iqbauthorstwo`

### 3. Background (1-2 slides)
- Biological/scientific significance
- Experimental limitations
- Why simulation/computation is needed

### 4. Key Questions (1 slide)
- Core challenge with punchline title
- Use `\iqbblock{核心挑战}` for emphasis
- Visual representation of the problem

### 5. Methods Overview (1 slide)
- Research flow diagram
- Key innovations highlighted
- Use `\iqbtimeline` or `\iqbmethodsflow`

### 6. Detailed Methods (2-4 slides)
- One concept per slide
- Each slide must have punchline title describing the innovation
- Use appropriate layout modules (`\iqblayouttwo`, `\iqbtextimage`)

### 7. Results (3-5 slides)
- Title must state the conclusion/finding
- Every slide needs figures
- Use `\iqbfig`, `\iqbtwofig`, etc. with auto-numbered captions

### 8. Validation/Discussion (1-2 slides)
- Compare with experiments
- Limitations and future directions

### 9. Conclusions (1 slide)
- Use `\iqbconclusion` or bullet points
- Key takeaways (3-5 points)

### 10. Thank You (1 slide)
- Contact information
- Acknowledgments

## Layout Recommendations

### For Vertical Images (height > width × 1.2)
```
Default: 1/3 text + 2/3 image
Special tall: 2:1 layout (1 part image + 2 parts text with detailed caption)
```

### For Horizontal Images (width ≥ height × 1.5)
```
Default: 1/3 text + 2/3 image
Wide images: 2:1 variant (image occupies 2, text 1)
```

### Figure Sizing Guidelines
- Single figure: `height=0.5-0.6\textheight`
- Two side-by-side: `height=0.45-0.55\textheight`
- Three figures: `height=0.35-0.4\textheight`
- Vertical in column: `height=0.5-0.65\textheight`

## Content Density Rules

- Target: 10-12 lines per slide at `\scriptsize`
- Line spacing: 150% of point size
- **NEVER use shrink option**
- Prefer manual line breaks with `\\` over automatic wrapping
- Every figure MUST have a caption (detailed or integrated into text)

## Output Format

Provide a structured markdown outline:

```markdown
## Slide N: [Punchline Title Here]

**Content Summary:**
- Key point 1
- Key point 2
- Key point 3

**Visuals:**
- Figure X: description (image_path.png)
- Layout: [e.g., \iqblayouttwo, \iqbtextimage, etc.]

**Image Properties:**
- Type: [vertical/horizontal/wide]
- Recommended size: height=0.5\textheight
- Layout suggestion: [specific column layout if vertical]

**Notes:**
- Special formatting needs
- Section marker (use \setsection{Methods})
```

## Integration with Other Skills

After planning:
1. Use **iqb-slide-writer** to write individual slides
2. Use **iqb-layout-optimizer** if content doesn't fit
3. Use **iqb-compiler** to test compilation
4. Use **iqb-quality-checker** for final review

## Reference Materials

- PPTX samples: `E:\GitHub-repo\literature-reading\JC`
- Content source: `E:\GitHub-repo\mendelevium\_pages\Specific Sytems\Membrane`
- Existing examples: `/examples/membrane-pore-jc.tex`

## When NOT to Use This Skill

- User is only modifying existing slides (use iqb-slide-writer)
- User needs layout fixes only (use iqb-layout-optimizer)
- User wants to compile/check PDF (use iqb-compiler or iqb-quality-checker)
