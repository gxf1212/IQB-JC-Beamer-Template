---
name: iqb-slide-writer
description: Write or modify individual slides using IQB Beamer template's pre-defined layout modules. Applies best practices for frametitles (punchline-driven), figure layouts (vertical vs horizontal), and content density. Use when writing new frames or editing existing slide content in .tex files.
---

# IQB Slide Writer

Expert at writing individual Beamer slides using IQB template's modular layout system with proper content formatting and figure placement.

## Quick Reference Card

**The 3 Golden Rules:**

1. **有图必左右** (Image → Left-Right Layout)
   - ANY slide with image → use `\iqblayouttwo{text}{image}`
   - NO vertical stacking (image on top, text below)

2. **标题用命令** (Titles Use Commands)
   - Use `\iqbsectiontitle{Name}` for in-slide sections
   - NEVER inside `itemize` environment
   - Pattern: `\iqbsectiontitle` → description → `\begin{itemize}`

3. **短图注居中** (Short Captions Center)
   - Long captions (>15 chars): `\iqbfig` → left-aligned
   - Short captions (≤15 chars): `\centering` + `\includegraphics` → centered

---

## Core Principles

### 1. Punchline-Driven Titles (MANDATORY)
Every `\begin{frame}{title}` must convey the slide's conclusion or key insight:

**Bad Examples:**
- "结果：交叉验证" (Results: Cross Validation)
- "方法：Full-Path CV" (Method: Full-Path CV)
- "验证：脂质密度" (Validation: Lipid Density)

**Good Examples:**
- "双重验证：Full-Path与Rapid高度一致，与实验定性吻合"
- "切换函数巧妙结合成核与扩展"
- "脂质尾部密度与孔寿命正相关(R²=0.82)"

### 2. Figure Layout Strategy

**Golden Rule: If there's a figure, use left-right layout (两栏布局)**

Whenever a slide contains an image, the default should be horizontal (left-right) layout, NOT vertical stacking. This applies to ALL images, regardless of orientation.

#### Any Image → Use Two-Column Layout

```latex
% ALWAYS prefer this pattern when there's an image:
\iqblayouttwo{
  % Text content on left
  \iqbsectiontitle{Section Name}
  Description text
  \begin{itemize}
    \item Point 1
    \item Point 2
  \end{itemize}
}{
  % Image on right (or use \iqbfig for auto-numbering)
  \centering
  \includegraphics[height=0.5\textheight,keepaspectratio]{image.png}

  \scriptsize \textbf{图~N:} Caption text
}
```

**Bad example (vertical stacking):**
```latex
% DON'T do this:
\begin{frame}{Title}
  \iqbfig[height=0.4\textheight]{image.png}{Caption}

  Text content below image...
  \begin{itemize}
    \item Point 1
    \item Point 2
  \end{itemize}
\end{frame}
```

**Good example (horizontal layout):**
```latex
% DO this instead:
\begin{frame}{Title}
  \iqblayouttwo{
    Text content and bullet points
  }{
    Image with caption
  }
\end{frame}
```

#### Vertical Images (height > width × 1.2)
**Still use column layout - just adjust proportions:**

```latex
\iqblayouttwo{
  % Text content (0.48\textwidth)
  \iqbsectiontitle{Key Finding}
  Long sentences preferred (3-5 lines, 40+ chars each)
  ...
}{
  \centering
  \includegraphics[height=0.65\textheight,keepaspectratio]{vertical.png}

  \scriptsize \textbf{图~N:} Caption
}
```

**For extremely tall vertical images:**
```latex
% 2:1 layout - 1 part image + 2 parts text
\begin{columns}[T]
  \begin{column}{0.31\textwidth}
    \includegraphics[height=0.65\textheight]{tall.png}
  \end{column}
  \begin{column}{0.64\textwidth}
    Detailed interpretation (can include caption here)
    ...
  \end{column}
\end{columns}
```

#### Horizontal/Wide Images (width ≥ height × 1.5)
```latex
\iqblayouttwo{
  % Text: bullet points or table-formatted caption
  Key observations:
  \iqbitemize{
    \item Point 1
    \item Point 2
  }
}{
  \iqbfig[height=0.5\textheight]{path/to/wide.png}{Multi-line caption}
}
```

#### 2.4 Advanced Layout Optimization

**Problem: Orphan Lines (孤行问题)**

When text wraps to a new line with only 1-2 characters, it wastes vertical space and creates visual imbalance:

```latex
% BAD: Last line has only "用" (1 char), wasting space
\iqblayouttwo{
  \iqbsectiontitle{标题：很长的描述文字需要工业应用}
  \begin{itemize}
    \item 这是一个非常长的句子可能会导致孤行问题的应
    用  % ← 孤行！
  \end{itemize}
}{...}
```

**Solution 1: Adjust Column Proportions**

Instead of default 1:1 (0.48:0.48), use custom ratios like 3:2, 2:3, 0.52:0.44, etc.

```latex
% GOOD: Adjust to 0.52 / 0.44 to fit text better
\begin{columns}[T]
  \begin{column}{0.52\textwidth}  % ← Slightly wider
    \iqbsectiontitle{标题：很长的描述文字需要工业应用}
    \begin{itemize}
      \item 这是一个非常长的句子不会导致孤行
    \end{itemize}
  \end{column}
  \hfill
  \begin{column}{0.44\textwidth}  % ← Slightly narrower (image can be smaller)
    \includegraphics[height=0.5\textheight]{image.png}
  \end{column}
\end{columns}
```

**Solution 2: Utilize Space Below Images**

If image doesn't need full column height, use remaining space for additional independent text (not just caption):

```latex
\iqblayouttwo{
  % Main text content
  \iqbsectiontitle{Key Findings}
  \begin{itemize}
    \item Point 1
    \item Point 2
  \end{itemize}
}{
  % Image
  \centering
  \includegraphics[height=0.45\textheight]{image.png}

  \scriptsize \textbf{图~1:} Caption

  \vspace{0.3cm}

  % Additional independent text below image
  \scriptsize \textbf{注}: This space can contain relatively independent remarks,
  historical notes, or supplementary information that doesn't fit in main column.
}
```

**Optimization Checklist:**

1. After writing content, **check for orphan lines** (1-2 chars on last line)
2. If found, try these in order:
   - Adjust column proportions (0.50→0.52, 0.48→0.46, etc.)
   - Shorten phrasing slightly (remove filler words)
   - Utilize image column's bottom space for extra text
3. Ensure image still fits well in adjusted column
4. Prioritize information density over deleting content

**Common Ratios:**
- Standard: `0.48 / 0.48` (with `\hfill` between)
- Text-heavy: `0.52 / 0.44`, `0.54 / 0.42`
- Image-heavy: `0.44 / 0.52`, `0.42 / 0.54`
- Very tall image: `0.64 / 0.31` (2:1 ratio)

### 3. Available Layout Modules

#### Two-Column Layouts
```latex
% Equal 50-50 split
\iqblayouttwo{left content}{right content}

% 1/3 + 2/3 split
\iqblayoutonethird{narrow left}{wide right}

% Custom columns for special cases
\begin{columns}[T]
  \begin{column}{0.31\textwidth}...\end{column}
  \begin{column}{0.64\textwidth}...\end{column}
\end{columns}
```

#### Figure Modules (Auto-numbered "图N：")
```latex
% Single figure
\iqbfig[height=0.5\textheight]{image.png}{Caption}

% Two figures side-by-side
\iqbtwofig[height=0.45\textheight]{img1.png}{caption1}{img2.png}{caption2}

% Three figures
\iqbthreefig[height=0.35\textheight]{img1}{cap1}{img2}{cap2}{img3}{cap3}

% 2×2 four figures
\iqbfourfig[height=0.3\textheight]{img1}{cap1}{img2}{cap2}{img3}{cap3}{img4}{cap4}
```

#### Text-Image Layouts
```latex
% Text left, image right
\iqbtextimage[0.48]{
  Text content here
}{image.png}
```

#### Special Content Blocks
```latex
% Highlighted key points
\iqbkeypoints{
  \item Critical finding 1
  \item Critical finding 2
}

% Core question emphasis
\iqbquestion{
  如何通过MD模拟准确量化膜孔形成全过程？
}

% Conclusion summary
\iqbconclusion{
  \item Conclusion 1
  \item Conclusion 2
}

% Generic colored block
\iqbblock{Title}{Content}

% Timeline/flowchart
\iqbtimeline{
  \item[Step 1] Description
  \item[Step 2] Description
}
```

#### Lists
```latex
% Itemize (bullets)
\iqbitemize{
  \item Point 1
  \item Point 2
}

% Enumerate (numbers)
\iqbenumerate{
  \item First
  \item Second
}
```

### 4. Content Density Guidelines

**Target:** 10-12 lines per slide at `\scriptsize` font
**Line spacing:** 1.2 (already set by template)

**Font size hierarchy:**
- Normal body text: Use template default (`\scriptsize` in frames)
- **禁止** manually setting `\large`, `\normalsize` in body text
- Temporary bold: `\textbf{}` is OK
- Titles: Use `\iqbsectiontitle{}` or template frametitle

**Spacing:**
```latex
\medskip         % Between paragraphs
\iqbsep          % Standard separator (replaces manual \vspace)
```

**DO NOT use:**
- `\vspace{1cm}` (use semantic separators)
- Manual `\large` for body text
- Shrink option: `[shrink=10]`

### 4.1. Content Richness vs. Layout Balance

**Principle:** High information density is encouraged, but must be paired with proper restructuring.

**Good approach:**
```latex
% Dense but organized with left-right layout
\iqblayouttwo{
  \iqbbluebox{核心贡献}{
    系统性重构炼金术自由能方法的历史发展
    \begin{itemize}
      \item 追溯1850-2020年代完整演进
      \item 揭示1984-85年双轨突破
    \end{itemize}
  }
}{
  \iqborangebox{方法聚焦}{
    热力学积分(TI)和自由能微扰(FEP)的演变
    \begin{itemize}
      \item TI：Kirkwood → 积分 → λ优化
      \item FEP：Zwanzig → Jorgensen → 收敛
    \end{itemize}
  }
}
```

**Bad approach:**
```latex
% Too much content stacked vertically - causes overfull
\iqbbluebox{...}{
  Very long explanation...
  \begin{itemize}
    \item Long bullet 1
    \item Long bullet 2
    \item Long bullet 3
  \end{itemize}
}

\iqbgreenbox{...}{
  Another long explanation...
  (content overflows page)
}
```

**Strategy:**
- Use `\iqblayouttwo` to split dense content across columns
- Abbreviate while retaining key information (e.g., "Boltzmann配分函数、Gibbs系综理论" → "Boltzmann、Gibbs、Zwanzig")
- Add 4th box if needed, using 2×2 layout

### 4.2. Item Label Best Practices

**Rule:** Keep `\item[label]` labels SHORT (≤4 Chinese chars or 12 English chars)

**Good labels:**
```latex
\item[\textbf{挑战}]           % 2 chars - perfect
\item[\textbf{需求}]           % 2 chars - perfect
\item[\textbf{方法创新}]       % 4 chars - acceptable
\item[\textbf{TI公式}]         % 4 chars (including EN) - acceptable
```

**Bad labels:**
```latex
\item[传统局限]                % Not bold - less visual weight
\item[\textbf{Dummy原子难题}]  % 8 chars - too long, pushes text right
\item[\textbf{计算化学的"黄金标准"}]  % 12+ chars - way too long
```

**Fix for long labels:**
- **Option 1:** Shorten label
  ```latex
  % Before:
  \item[\textbf{Dummy原子难题}] 拓扑变化的核心挑战

  % After:
  \item[\textbf{Dummy难题}] 拓扑变化的核心挑战
  ```

- **Option 2:** Move to nested list
  ```latex
  % Before:
  \item[\textbf{验证标准}] 计算结果的可靠性检验

  % After:
  \item[\textbf{验证}]
  \begin{itemize}
    \item 计算结果的可靠性检验
    ...
  \end{itemize}
  ```

- **Option 3:** Use `\iqbitemize` (custom environment with proper indentation)
  ```latex
  \begin{iqbitemize}
    \item[\textbf{方法}]
    \begin{itemize}
      \item Detailed point 1
      \item Detailed point 2
    \end{itemize}
  \end{iqbitemize}
  ```

### 5. Caption Requirements

**Every figure MUST have a caption** in one of these forms:

1. **Detailed figure caption (use `\iqbfig` - left-aligned):**
```latex
\iqbfig[height=0.5\textheight]{image.png}{%
  孔闭合的四个阶段。（A）平衡孔，水线贯穿膜；（B）半径缩小...
}
% Note: \iqbfig automatically adds "图N：" and left-aligns caption
```

2. **Short caption (use direct `\includegraphics` - centered):**
```latex
% For short captions like names, single phrases, use centered layout
\centering
\includegraphics[height=0.5\textheight,keepaspectratio]{image.png}

\scriptsize \textbf{图~6:} Peter A. Kollman和William L. Jorgensen
```

**Rule:**
- **Long captions** (>15 characters): Use `\iqbfig` → left-aligned
- **Short captions** (≤15 characters): Use `\centering` + `\includegraphics` → centered

3. **Caption integrated into text column:**
```latex
\iqblayouttwo{
  \textbf{Figure 3 Interpretation:}

  This shows four stages of pore closure...
  (detailed analysis here serves as caption)
}{
  \includegraphics[height=0.55\textheight]{image.png}
}
```

4. **Table-formatted caption for multi-panel figures:**
```latex
\begin{tabular}{ll}
  \textbf{Panel A:} & Description of A \\
  \textbf{Panel B:} & Description of B \\
\end{tabular}
```

### 6. In-Slide Section Titles (`\iqbsectiontitle`)

**Purpose:** Replace `\item[\textbf{Label}]` with semantic section titles.

**Definition:**
```latex
% From theme/iqb-layouts.sty:
\newcommand{\iqbsectiontitle}[2][iqbblue]{%
  {\normalsize\textcolor{#1}{\textbf{#2}}}\par%
}
```

**Key Rule: NEVER use `\iqbsectiontitle` inside `itemize` environment**

#### Correct Usage (Outside itemize)

```latex
% CORRECT: Use outside itemize
\iqbsectiontitle{核心概念}
自由能的定义
\begin{itemize}
  \item Helmholtz自由能: $F = -k_B T \ln Q$
  \item Gibbs自由能: $G = -k_B T \ln \Delta$
\end{itemize}

\iqbsep

\iqbsectiontitle{计算挑战}
自由能差的直接计算
\begin{itemize}
  \item 构型积分的复杂性
  \item 高维积分的数值困难
\end{itemize}
```

#### Incorrect Usage (Inside itemize) - FORBIDDEN

```latex
% WRONG: Will cause "missing \item" error
\begin{itemize}
  \iqbsectiontitle{核心概念}  % ❌ ERROR!
  \item Point 1
  \item Point 2
\end{itemize}

% WRONG: Even with \item[] wrapper
\begin{itemize}
  \item[\textbf{Label}] Description  % ❌ Mixing labeled and unlabeled items
  \item Regular point                % ❌ Creates inconsistent layout
\end{itemize}
```

#### Pattern: Section Title → Description → List

**Standard pattern:**
```latex
\iqbsectiontitle{Section Name}
Brief description or context sentence
\begin{itemize}
  \item Detailed point 1
  \item Detailed point 2
  \item Detailed point 3
\end{itemize}
```

**With separator:**
```latex
\iqbsectiontitle{First Section}
Description
\begin{itemize}
  \item Point 1
\end{itemize}

\iqbsep

\iqbsectiontitle{Second Section}
Description
\begin{itemize}
  \item Point 1
\end{itemize}
```

#### Optional Color Parameter

```latex
\iqbsectiontitle[iqbgreen]{Success Case}   % Green title
\iqbsectiontitle[iqborange]{Warning}       % Orange title
\iqbsectiontitle[iqbred]{Error Case}       % Red title
\iqbsectiontitle{Default Blue Title}       % Default: iqbblue
```

### 7. Figure Captions Best Practices

**Golden Rule: ALWAYS use template commands for figures**

#### 7.1 Use `\iqbfig` for Single Figures

**NEVER manually write captions like this:**
```latex
% ❌ BAD: Manual caption
\centering
\includegraphics[height=0.5\textheight]{image.png}

\scriptsize \textbf{图~1:} Caption text
```

**ALWAYS use `\iqbfig`:**
```latex
% ✓ GOOD: Template command
\iqbfig[height=0.5\textheight]{image.png}{Caption text}
```

**Benefits:**
- Auto-numbering (图1, 图2, ...)
- Consistent formatting (left-aligned caption by default)
- Proper spacing
- Less code, cleaner structure

#### 7.2 Caption Length Strategy

**Short captions (≤20 chars):** Already centered by default with `\iqbfig`

**Long captions (>20 chars):** Left-aligned (default behavior)

**Example - Person identification:**
```latex
\iqbfig[height=0.6\textheight]{Figures/kirkwood.jpeg}{John Gamble Kirkwood (1907-1959)，理论化学家，统计力学与液体理论专家，提出耦合参数积分方法(Kirkwood TI)，为自由能计算奠定理论基础}
```

**Key info to include for person photos:**
- Full name (English + dates if applicable)
- Title/affiliation (Chinese preferred for clarity)
- Major contribution related to the slide topic
- Context (e.g., "摄于1982年普渡大学实验室")

#### 7.3 Multiple Figures

**Two figures side by side:**
```latex
\iqbtwofig[height=0.3\textheight]{img1.jpeg}{Caption 1 with person name and contribution}{img2.jpeg}{Caption 2 with person name}
```

**Three figures:**
```latex
\iqbthreefig[height=0.35\textheight]{img1}{cap1}{img2}{cap2}{img3}{cap3}
```

**Four figures (2×2 grid):**
```latex
\iqbfourfig[height=0.25\textheight]{img1}{cap1}{img2}{cap2}{img3}{cap3}{img4}{cap4}
```

#### 7.4 Caption Content Guidelines

**For diagrams/schematics:**
- Describe what the diagram shows
- Mention key elements or relationships
- Example: "热力学积分路径：通过耦合参数$\lambda$连续变换系统"

**For historical photos:**
- Person name with dates
- Institution/affiliation at photo time
- Major contribution
- Photo context/year if known

**For data/results:**
- What is being shown
- Key findings or patterns
- Example: "计算两个抑制剂I和I*与同一酶结合的相对自由能的热力学循环"

#### 7.5 Common Mistakes to Avoid

1. ❌ Manual caption numbering (图~1, 图~2) - Use `\iqbfig` auto-numbering
2. ❌ Using `\centering` + `\includegraphics` + manual caption - Use `\iqbfig`
3. ❌ Forgetting person identification in photos - Always add name/contribution
4. ❌ Overly long captions causing overfull - Shorten or split to multiple slides
5. ❌ Missing context for historical photos - Add year/location when available

#### 7.6 Quick Reference

```latex
% Single figure
\iqbfig[height=0.5\textheight]{path/to/image.png}{Caption text}

% Two figures
\iqbtwofig[height=0.3\textheight]{img1}{cap1}{img2}{cap2}

% Figure in column layout
\begin{column}{0.48\textwidth}
  \iqbfig[width=\linewidth,height=0.6\textheight]{image.png}{Caption}
\end{column}
```

### 8. Footer Section Markers

Use `\setsection{Name}` to update footer's center section:
```latex
\setsection{Background}     % Before background slides
\setsection{Methods}        % Before methods slides
\setsection{Results}        % Before results slides
\setsection{Discussion}     % Before discussion slides
```

### 7. Author Information Modules

**With photos (通讯作者 + 一作):**
```latex
\iqbauthorstwophoto{corresponding.png}{Name}{Affiliation}{Links}{Field}{first.png}{Name}{Affiliation}{Links}
```

**Without photos:**
```latex
\iqbauthorstwo{Name1}{Affiliation1}{Links1}{Field1}{Name2}{Affiliation2}{Links2}
```

**Set first author research field:**
```latex
\setauthorfirstfield{计算生物物理、膜动力学、增强采样方法}
```

### 8. Common Slide Templates

#### Cover Slide
```latex
\iqbcoverframe  % One-liner, uses \title, \author, etc.
```

#### Section Divider
```latex
\iqbsectionframe{Section Name}{中文副标题}
```

#### Standard Content Slide
```latex
\begin{frame}{Punchline Title Goes Here}
  \iqblayouttwo{
    \textbf{Context:}
    ...

    \medskip

    \iqbitemize{
      \item Point 1
      \item Point 2
    }
  }{
    \iqbfig[height=0.5\textheight]{image.png}{Caption}
  }
\end{frame}
```

## Workflow

1. **Receive slide specification** from iqb-content-planner or user
2. **Choose appropriate layout module** based on content type and image orientation
3. **Write punchline-driven frametitle**
4. **Structure content** with proper spacing and lists
5. **Place figures** with correct sizing and captions
6. **Verify no manual font size changes** in body text
7. **Add section markers** if transitioning to new section

## Quality Checklist

Before finishing each slide:

### Layout & Structure
- [ ] **If slide has image → use left-right layout (`\iqblayouttwo`)**, not vertical stacking
- [ ] Title contains punchline/conclusion (not descriptive label)
- [ ] Dense content uses left-right layout (not vertical stack)

### Figures & Captions
- [ ] Every figure has caption (detailed or integrated)
  - [ ] Long captions (>15 chars): use `\iqbfig` (left-aligned)
  - [ ] Short captions (≤15 chars): use `\centering` + `\includegraphics` (centered)
- [ ] Appropriate figure height (0.45-0.6\textheight for standard, 0.65 for tall images)

### Section Titles & Labels
- [ ] **Use `\iqbsectiontitle{...}` instead of `\item[\textbf{...}]`**
- [ ] **`\iqbsectiontitle` placed OUTSIDE `itemize` environment** (never inside)
- [ ] Pattern followed: `\iqbsectiontitle{Name}` → description → `\begin{itemize}`
- [ ] No mixing of labeled `\item[Label]` with unlabeled `\item` in same list

### Spacing & Formatting
- [ ] No `\vspace`, use `\medskip` or `\iqbsep`
- [ ] No manual `\large`, `\normalsize` in body text
- [ ] Content density: 10-12 lines max

### Section Management
- [ ] Footer section marker updated if transitioning (`\setsection{Name}`)

## Integration with Other Skills

- **Before writing:** Get outline from iqb-content-planner
- **After writing:** Use iqb-layout-optimizer if overfull warnings
- **Then:** Use iqb-compiler to test compilation
- **Finally:** Use iqb-quality-checker for PDF review

## When NOT to Use This Skill

- Planning overall presentation structure (use iqb-content-planner)
- Fixing overfull/layout issues (use iqb-layout-optimizer)
- Compiling or debugging LaTeX errors (use iqb-compiler)
- Reviewing final PDF layout (use iqb-quality-checker)
