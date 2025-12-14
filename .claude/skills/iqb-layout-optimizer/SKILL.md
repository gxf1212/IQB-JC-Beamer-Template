---
name: iqb-layout-optimizer
description: Fix layout issues like overfull hbox/vbox, content overflow, and poor figure-text balance in IQB Beamer slides. Adjusts figure sizes, rewrites content for density, or splits overloaded slides. Use when compilation shows warnings or slides look cramped.
---

# IQB Layout Optimizer

Diagnose and fix layout problems in IQB Beamer presentations, ensuring professional appearance without manual spacing hacks.

## Core Responsibilities

1. **Detect Layout Problems**
   - Overfull \hbox warnings (text too wide)
   - Overfull \vbox warnings (content too tall)
   - Cramped appearance (too much content)
   - Poor figure-text balance
   - Images too small or too large

2. **Apply Fixes**
   - Adjust figure heights
   - Condense or split content
   - Change layout modules
   - Reformat captions
   - Split into multiple slides

3. **Maintain Quality**
   - Never use `[shrink=N]` option
   - Avoid manual `\vspace` hacks
   - Preserve semantic structure
   - Keep punchline titles

## Common Problems and Solutions

### Problem 1: Overfull \hbox (Text Too Wide)

**Symptoms:**
```
Overfull \hbox (12.34pt too wide) in paragraph at lines 45--46
```

**Solutions:**

1. **Rewrite for brevity:**
```latex
% Before (too long)
\item 传统CV难以同时准确描述成核和扩展这两个物理机制完全不同的过程

% After (concise)
\item 传统CV难以统一描述成核和扩展
```

2. **Manual line break:**
```latex
% Add \\ at natural break point
\item 传统CV难以同时准确描述成核和扩展\\
  这两个物理机制完全不同的过程
```

3. **Use narrower columns:**
```latex
% If using custom columns, reduce width
\begin{column}{0.42\textwidth}  % was 0.48
```

### Problem 2: Overfull \vbox (Content Too Tall)

**Symptoms:**
```
Overfull \vbox (5.67pt too high) detected at line 89
```

**Solutions:**

1. **Reduce figure height:**
```latex
% Before
\iqbfig[height=0.6\textheight]{image.png}{Long caption...}

% After
\iqbfig[height=0.5\textheight]{image.png}{Shorter caption}
```

2. **Condense text:**
```latex
% Remove redundant lines, merge related points
\iqbitemize{
  \item Point 1: brief description  % was 2 lines
  \item Point 2: brief description  % was 2 lines
}
```

3. **Split into two slides:**
```latex
% Slide 1: Methods Part A
\begin{frame}{Core Innovation: Switching Function Design}
  \iqblayouttwo{
    First half of explanation...
  }{
    \iqbfig[height=0.5\textheight]{fig1.png}{Caption 1}
  }
\end{frame}

% Slide 2: Methods Part B
\begin{frame}{Validation: Switching Function Ensures Smooth Transition}
  \iqblayouttwo{
    Second half of explanation...
  }{
    \iqbfig[height=0.5\textheight]{fig2.png}{Caption 2}
  }
\end{frame}
```

### Problem 3: Images Too Small

**Symptoms:**
- Vertical images stacked below text look tiny
- User complains figures are unreadable

**Solutions:**

1. **Switch to column layout:**
```latex
% Before (bad - stacks vertically)
\begin{frame}{Title}
  Text content here...

  \iqbfig[height=0.3\textheight]{tall.png}{Caption}  % Too small!
\end{frame}

% After (good - side-by-side)
\begin{frame}{Title}
  \iqblayouttwo{
    Text content here...
  }{
    \iqbfig[height=0.55\textheight]{tall.png}{Caption}  % Much better!
  }
\end{frame}
```

2. **Use dedicated slide for complex figure:**
```latex
\begin{frame}{Figure Analysis: [Punchline Title]}
  \begin{columns}[T]
    \begin{column}{0.31\textwidth}
      \includegraphics[height=0.7\textheight]{complex_figure.png}
    \end{column}
    \begin{column}{0.64\textwidth}
      \textbf{Detailed Interpretation:}

      Long-form analysis with 3-5 lines per point...
    \end{column}
  \end{columns}
\end{frame}
```

### Problem 4: Too Many Bullet Points

**Symptoms:**
- More than 6-7 bullet points on one slide
- Each point spans multiple lines

**Solutions:**

1. **Condense to key points only:**
```latex
% Before (8 points, verbose)
\iqbitemize{
  \item First very detailed point...
  \item Second verbose explanation...
  ...
}

% After (4-5 points, concise)
\iqbitemize{
  \item Key point 1: brief
  \item Key point 2: brief
  \item Key point 3: brief
}
```

2. **Use hierarchical structure:**
```latex
\iqbitemize{
  \item Major point 1
    \begin{itemize}
      \item Sub-point A
      \item Sub-point B
    \end{itemize}
  \item Major point 2
}
```

3. **Split into two slides:**
```latex
% Slide A: First 3-4 points
% Slide B: Remaining points with different punchline title
```

### Problem 5: Caption Overflow

**Symptoms:**
- Figure caption extends beyond slide boundary
- Caption has 5+ lines

**Solutions:**

1. **Abbreviate caption:**
```latex
% Before
\iqbfig[height=0.5\textheight]{image.png}{%
  图3：孔闭合的完整四个阶段的详细动态过程。（A）初始平衡孔状态...
}

% After
\iqbfig[height=0.5\textheight]{image.png}{%
  图3：孔闭合四阶段（A→B→C→D）
}
```

2. **Move caption to text column:**
```latex
\iqblayouttwo{
  \textbf{图3解读：}

  孔闭合的四个阶段：\\
  \textbf{A.} 平衡孔状态\\
  \textbf{B.} 半径缩小\\
  \textbf{C.} 临界瞬间\\
  \textbf{D.} 完全闭合
}{
  \includegraphics[height=0.55\textheight]{image.png}
}
```

3. **Use table format for multi-panel figures:**
```latex
\begin{tabular}{@{}ll@{}}
  \textbf{A:} & Brief description \\
  \textbf{B:} & Brief description \\
  \textbf{C:} & Brief description \\
\end{tabular}
```

## Layout Module Selection Guide

### When to Use Each Layout

| Content Type | Recommended Module | Example Use |
|--------------|-------------------|-------------|
| Text + vertical image | `\iqblayouttwo` | Methods explanation with tall schematic |
| Text + horizontal image | `\iqblayouttwo` or `\iqbtextimage` | Results with wide plot |
| Two related figures | `\iqbtwofig` | Before/after comparison |
| Three comparisons | `\iqbthreefig` | Parameter sweep results |
| Multiple small figures | `\iqbfourfig` | 2×2 grid of subplots |
| Equal text columns | `\iqbtwocolumn` | Pros vs Cons |
| Emphasized text | `\iqbblock`, `\iqbkeypoints` | Core challenge |
| Timeline/workflow | `\iqbtimeline` | Methods overview |

### When to Switch Layouts

**Switch from stacking to columns if:**
- Vertical image becomes too small (height < 0.4\textheight)
- Need more horizontal space for wide content

**Switch from two-column to single column if:**
- Content doesn't naturally divide
- Need full width for wide table or equation

**Switch from complex to simple if:**
- Getting overfull warnings
- Slide looks cluttered

## Optimization Workflow

1. **Read compilation output** or user description of problem
2. **Identify root cause:**
   - Overfull hbox → Text too wide
   - Overfull vbox → Content too tall
   - User complaint → Subjective layout issue
3. **Choose appropriate fix** from solutions above
4. **Apply fix** while preserving content meaning
5. **Maintain punchline title** (do not change)
6. **Test with iqb-compiler** to verify fix
7. **Iterate if needed**

## Quality Checklist

After optimization:
- [ ] No overfull warnings in compilation output
- [ ] Figures are readable (min height 0.4\textheight for important figures)
- [ ] Text density: 10-12 lines max at `\scriptsize`
- [ ] No `[shrink]` option used
- [ ] No manual `\vspace` hacks
- [ ] Punchline title preserved
- [ ] Content meaning preserved

## Integration with Other Skills

- **After content planning:** Use iqb-slide-writer first
- **When writer creates overflow:** Use this skill to fix
- **After optimization:** Use iqb-compiler to verify
- **Final check:** Use iqb-quality-checker

## When NOT to Use This Skill

- Writing new slides from scratch (use iqb-slide-writer)
- Planning presentation structure (use iqb-content-planner)
- Fixing LaTeX compilation errors (use iqb-compiler)
- Reviewing overall PDF quality (use iqb-quality-checker)
- Content is correct but needs different information (use iqb-slide-writer)

## Advanced Optimization Techniques

### Technique 1: Progressive Figure Sizing
Start with recommended size, reduce incrementally if needed:
```latex
% Try sequence: 0.6 → 0.55 → 0.5 → 0.45\textheight
\iqbfig[height=0.5\textheight]{image.png}{Caption}
```

### Technique 2: Content Hierarchy
Use structure to reduce perceived density:
```latex
% Instead of flat list
\textbf{Category 1:} brief description
\iqbitemize{
  \item Detail A
  \item Detail B
}

\medskip

\textbf{Category 2:} brief description
\iqbitemize{
  \item Detail C
}
```

### Technique 3: Column Width Adjustment
Fine-tune column widths for optimal balance:
```latex
% Standard: 0.48 / 0.48
% More text: 0.55 / 0.42
% More image: 0.38 / 0.58
\begin{columns}[T]
  \begin{column}{0.55\textwidth}
    Longer text content...
  \end{column}
  \begin{column}{0.42\textwidth}
    Smaller figure...
  \end{column}
\end{columns}
```

### Technique 4: Strategic Content Removal
Identify and remove low-value content:
- Redundant examples
- Overly detailed explanations
- Information better suited for appendix
- Decorative text that doesn't advance narrative

Remember: **Less is more** in presentations. Better to split into two clear slides than cram everything into one cluttered slide.
