---
name: iqb-quality-checker
description: Review compiled PDF presentations for layout correctness, visual quality, and adherence to IQB template standards. Checks header/footer, frametitles, figure sizing, and overall appearance. Use after successful compilation to ensure professional quality.
---

# IQB Quality Checker

Comprehensive quality assurance for IQB Beamer presentations, combining automated checks with visual inspection.

## Core Responsibilities

1. **Automated Format Verification**
   - Header banner presence and sizing
   - Footer three-part structure
   - Frametitle positioning and transparency
   - Page count consistency

2. **Visual Quality Review**
   - Figure clarity and sizing
   - Text readability
   - Layout balance
   - Professional appearance

3. **Standards Compliance**
   - IQB template requirements
   - Academic presentation best practices
   - Content density guidelines

## Quality Checklist

### 1. Header (页眉横幅) Requirements

**Must verify:**
- [ ] Header image appears on all non-plain frames
- [ ] Header spans full width of slide
- [ ] Aspect ratio preserved (1999×204px → full width)
- [ ] Header NOT on cover page (first slide)
- [ ] Header NOT on thank-you page (last slide)
- [ ] No content overlaps or obscures header

**How to check:**
- Use **pdf-layout-reviewer agent** to examine multiple pages
- Or extract sample pages: `python3 tools/extract_pdf_page.py file.pdf 3`
- Visually verify full-width coverage

### 2. Frametitle (标题) Requirements

**Must verify:**
- [ ] Frametitle positioned in upper-left
- [ ] Overlays on header's blank area (uses TikZ positioning)
- [ ] **Completely transparent background** (no white box)
- [ ] IQB blue color (#003366)
- [ ] Does NOT occupy content space
- [ ] **Contains punchline/conclusion** (not descriptive label)

**How to check:**
- Extract page with complex layout
- Verify no white background behind title
- Read titles - should state findings, not topics

**Title Quality Examples:**
- ❌ BAD: "结果：交叉验证"
- ✅ GOOD: "双重验证：Full-Path与Rapid高度一致"

### 3. Footer (页脚) Requirements

**Must verify:**
- [ ] Footer appears on all content slides
- [ ] Three-part structure: Left | Center | Right
- [ ] Left: "IQB Lab" or custom institute name (bold, IQB blue)
- [ ] Center: Section name (set via `\setsection{}`)
- [ ] Right: Page number format "N / Total"
- [ ] Top blue divider line (1.5pt, IQB blue)
- [ ] Footer does NOT extend beyond page boundary
- [ ] Footer NOT on cover or thank-you pages

**How to check:**
- Check last content page to verify footer within bounds
- Verify section markers change appropriately through presentation

### 4. Figure Quality Requirements

**Must verify:**
- [ ] All figures are readable (not too small)
- [ ] Vertical images use column layout (not stacked)
- [ ] Figure heights appropriate:
  - Single: 0.5-0.6\textheight
  - Double: 0.45-0.55\textheight
  - Triple: 0.35-0.4\textheight
- [ ] Every figure has caption (detailed or text-integrated)
- [ ] Figures auto-numbered ("图1:", "图2:", etc.)
- [ ] No pixelation or poor quality
- [ ] Proper aspect ratios preserved

**How to check:**
- Extract pages with figures
- Verify minimum size met
- Check caption presence and quality

### 5. Layout Balance Requirements

**Must verify:**
- [ ] Text-to-image ratio appropriate (typically 1:2 or 1:1)
- [ ] No overly cramped slides (max 10-12 lines)
- [ ] White space used effectively
- [ ] Column layouts aligned properly
- [ ] No content bleeding off edges

**How to check:**
- Review dense slides (methods, results sections)
- Extract and visually inspect problematic pages

### 6. Typography Requirements

**Must verify:**
- [ ] Body text at `\scriptsize` (standard)
- [ ] No manual `\large`, `\normalsize` in body text
- [ ] Consistent font sizes across slides
- [ ] Line spacing: 1.2 (150% of point size)
- [ ] Chinese characters rendered correctly
- [ ] No font substitution warnings in log

### 7. Content Quality Requirements

**Must verify:**
- [ ] All frametitles contain punchlines (not labels)
- [ ] Section markers used and appropriate
- [ ] Flow between slides logical
- [ ] No orphaned content (incomplete explanations)
- [ ] References formatted correctly

## Review Workflow

### Step 1: Quick Automated Check

```bash
# Get PDF metadata
pdfinfo examples/membrane-pore-jc.pdf

# Check page count
grep -c "\\begin{frame}" examples/membrane-pore-jc.tex
# Compare with PDF page count (should be close)
```

### Step 2: Sample Page Extraction

Extract representative pages for visual inspection:

```bash
# Cover page
python3 tools/extract_pdf_page.py examples/membrane-pore-jc.pdf 1

# First content page (header/footer check)
python3 tools/extract_pdf_page.py examples/membrane-pore-jc.pdf 3

# Methods page (complex layout)
python3 tools/extract_pdf_page.py examples/membrane-pore-jc.pdf 7

# Results page (figures)
python3 tools/extract_pdf_page.py examples/membrane-pore-jc.pdf 10

# Last content page (footer boundary)
python3 tools/extract_pdf_page.py examples/membrane-pore-jc.pdf -2
```

### Step 3: Visual Inspection

Use Read tool to examine extracted PNG images:

```bash
# Inspect each extracted page
# Verify checklist items visually
```

### Step 4: Invoke PDF Layout Reviewer Agent

For comprehensive automated review:

```
Use Task tool with subagent_type=pdf-layout-reviewer
Specify: "Review all pages for IQB template compliance"
```

**Agent checks:**
- Header full-width coverage
- Footer three-part structure
- Frametitle transparency
- Layout overflow issues

### Step 5: Compilation Log Review

Check for ignored warnings:

```bash
# Look for overfull warnings
grep "Overfull" examples/membrane-pore-jc.log

# Check for missing references
grep "Reference.*undefined" examples/membrane-pore-jc.log

# Look for font warnings
grep "Font.*not found" examples/membrane-pore-jc.log
```

## Common Issues and Remediation

### Issue 1: Header Not Full Width

**Symptom:** Header image doesn't span entire slide width

**Fix:**
```latex
% In beamerthemeiqb.sty, headline template should use:
\includegraphics[width=\paperwidth,keepaspectratio]{\iqbheaderimage}
```

**Recompile and verify.**

### Issue 2: Frametitle Has White Background

**Symptom:** White box behind title text

**Fix:**
```latex
% Frametitle should use TikZ overlay with transparent background
% Check beamerthemeiqb.sty frametitle template
\begin{tikzpicture}[remember picture,overlay]
  \node[anchor=north west,inner sep=0pt] at (...) {
    % No fill color specified = transparent
  };
\end{tikzpicture}
```

### Issue 3: Footer Extends Beyond Page

**Symptom:** Footer text cut off at bottom

**Fix:**
- Reduce content on affected slides
- Adjust footer vertical positioning in theme
- Use **iqb-layout-optimizer** to condense content

### Issue 4: Figures Too Small

**Symptom:** Unreadable figures, especially vertical ones

**Fix:**
- Change to column layout for vertical images
- Increase height parameter
- Use **iqb-layout-optimizer** skill

### Issue 5: Inconsistent Section Markers

**Symptom:** Footer center shows wrong section or empty

**Fix:**
```latex
% Add \setsection{} before each major section
\setsection{Background}
\begin{frame}{...}

\setsection{Methods}
\begin{frame}{...}

\setsection{Results}
\begin{frame}{...}
```

### Issue 6: Non-Punchline Titles

**Symptom:** Titles like "Methods", "Results: Figure 3"

**Fix:**
- Rewrite each title to state the finding
- Use **iqb-slide-writer** to revise frametitles
- Maintain technical accuracy while adding insight

## Quality Scoring

Rate presentation on each dimension (1-5 scale):

| Dimension | Score | Notes |
|-----------|-------|-------|
| Header/Footer Format | _/5 | Correct structure and positioning |
| Frametitle Quality | _/5 | Punchlines present, transparent bg |
| Figure Quality | _/5 | Readable size, proper captions |
| Layout Balance | _/5 | Good text-image ratio, no overflow |
| Typography | _/5 | Consistent sizes, proper fonts |
| Content Flow | _/5 | Logical progression, clear narrative |
| **Total** | _/30 | Target: 25+ for publication-ready |

**Scoring guidelines:**
- **5:** Excellent, meets all requirements
- **4:** Good, minor improvements possible
- **3:** Acceptable, some issues present
- **2:** Needs work, multiple problems
- **1:** Poor, major revision required

## Integration with Other Skills

**Typical workflow:**
1. **iqb-content-planner** → Create outline
2. **iqb-slide-writer** → Write frames
3. **iqb-compiler** → Generate PDF
4. **iqb-quality-checker** (this skill) → Review quality
5. If issues found:
   - Layout problems → **iqb-layout-optimizer**
   - Content problems → **iqb-slide-writer**
   - Then back to **iqb-compiler**
6. **iqb-quality-checker** again → Final approval

## When to Use This Skill

- After successful compilation
- Before presenting to user
- When user requests quality review
- As final step before committing changes
- When debugging layout issues (to verify fixes)

## When NOT to Use This Skill

- Before compilation (use iqb-compiler first)
- During LaTeX errors (fix errors first)
- When writing content (that's iqb-slide-writer's job)
- For planning structure (use iqb-content-planner)

## Reporting Format

Provide structured quality report:

```markdown
## IQB Beamer Quality Report
**File:** examples/membrane-pore-jc.pdf
**Date:** 2025-11-27
**Pages:** 14

### ✅ Passed Checks
- Header full-width on all content pages
- Footer three-part structure correct
- All figures have captions
- No compilation errors

### ⚠️ Issues Found
1. **Page 5:** Frametitle should be punchline ("核心创新..." instead of "方法：...")
2. **Page 8:** Vertical figure too small (0.35\textheight), recommend column layout
3. **Page 11:** Missing section marker, footer center empty

### 📊 Quality Score: 24/30
- Header/Footer Format: 5/5
- Frametitle Quality: 3/5 (needs punchlines)
- Figure Quality: 4/5 (one figure too small)
- Layout Balance: 5/5
- Typography: 5/5
- Content Flow: 4/5

### 🔧 Recommended Actions
1. Revise frametitles on pages 5, 7, 9 to include punchlines
2. Fix page 8 layout: use \iqblayouttwo with image in right column
3. Add \setsection{Results} before page 11

### ✨ Overall Assessment
Presentation is **near publication quality** with minor improvements needed.
Primary focus: enhance frametitles with more impactful punchlines.
```

## Advanced Quality Checks

### Visual Consistency Audit
- Consistent color usage (IQB blue for emphasis)
- Uniform spacing between elements
- Aligned bullet points and columns
- Proper use of bold/italic

### Accessibility Review
- Text contrast sufficient (dark text on light background)
- Font sizes readable from distance (target: 6+ meters)
- Color not sole indicator (use shapes/patterns too)

### Content Accuracy Audit
- All citations formatted correctly
- Figure numbers sequential
- No orphaned references
- Equations rendered properly

### Performance Check
- PDF file size reasonable (1-5 MB typical)
- No embedded font issues
- Quick page load times
- Compatible with standard viewers

Remember: Quality checking is the final gatekeeper. A well-designed presentation reflects well on the presenter and the IQB lab.
