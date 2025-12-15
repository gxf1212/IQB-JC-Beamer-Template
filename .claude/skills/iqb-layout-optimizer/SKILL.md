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

### Problem 2: Overfull \vbox (Content Too Tall) - **CRITICAL**

**Symptoms:**
```
Overfull \vbox (5.67pt too high) detected at line 89
```

**Important:** vbox overfull >5pt 必须修复！会导致内容被遮挡。

**修复优先级（从高到低）：**

**Priority 1: 使用全局small模式（首选）**
```latex
\begin{frame}{标题}
  \iqbfontsizemode{small}  % 整页字体缩小一级
  % 正文从\footnotesize → \scriptsize
  % 列表从\scriptsize → \tiny
  \iqblayouttwo{
    内容...
  }{
    图片...
  }
\end{frame}
```
- 适用于：方法详述、复杂表格、MD模拟、信息密集页
- 优点：保持内容完整，全局一致

**Priority 2: 压缩间距**
```latex
% 替换更小的间距命令
\iqbsep       → \iqbsmallsep    % 0.3cm → 0.2cm
\iqbsmallsep  → \iqbtinysep     % 0.2cm → 0.15cm
\iqbtinysep   → \iqbmicrosep    % 0.15cm → 0.1cm
```

**Priority 3: 优化表格**
```latex
% 减小表格字体
\footnotesize  % 尝试
\begin{tabular}...

\scriptsize    % 如果还不够
\begin{tabular}...

\tiny          % 最后手段
\begin{tabular}...

% 简化列内容
催化残基固定 → 固定催化
无约束Relax → 无约束
```

**Priority 4: 调整图片高度**
```latex
% 从大到小逐步降低
height=0.75\textheight  % 起始
     ↓
height=0.70\textheight  % 第一次尝试
     ↓
height=0.68\textheight  % 通常足够
     ↓
height=0.65\textheight  % 密集内容
```

**Priority 5: 重构布局**
```latex
% TikZ mindmap → 双栏列表
% Before (占用空间大)
\begin{tikzpicture}[mindmap]
  \node{中心}
    child{...}
\end{tikzpicture}

% After (更紧凑)
\iqblayouttwo{
  \iqbsectiontitle{类别1}
  \begin{iqbitemize}
    \item 要点A
  \end{iqbitemize}
}{
  \iqbsectiontitle{类别2}
  \begin{iqbitemize}
    \item 要点B
  \end{iqbitemize}
}

% formula frame → 普通frame
% \iqbformulaframe 占用空间大，改用标准布局
```

**Priority 6: 拆分页面（最后手段）**
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

**重要原则：**
- ✅ **信息密度可以大，但不能删减内容**
- ✅ **拆分和重组优于删减**
- ✅ overfull >5pt必须修复，<5pt可接受
- ❌ **绝对不删减关键信息**（如"α/β混合结构"）

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

2. **Use global small mode if text is dense:**
```latex
\begin{frame}{Title}
  \iqbfontsizemode{small}  % Shrink text to make room for larger image
  \iqblayouttwo{
    Detailed text...
  }{
    \iqbfig[height=0.60\textheight]{tall.png}{Caption}  % Even larger!
  }
\end{frame}
```

3. **Use dedicated slide for complex figure:**
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

1. **Use global small mode (first try):**
```latex
\begin{frame}{Title}
  \iqbfontsizemode{small}  % Shrink fonts to fit more points
  \begin{iqbitemize}
    \item Point 1...
    \item Point 2...
    \item Point 3...
    ...  % Can now fit 8-10 points comfortably
  \end{iqbitemize}
\end{frame}
```

2. **Condense to key points only:**
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

3. **Use hierarchical structure:**
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

4. **Split into two slides (last resort):**
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
- [ ] Overfull warnings acceptable (<5pt for vbox, <10pt for hbox)
- [ ] No critical overfull (vbox >5pt causes content blocking)
- [ ] Figures are readable (min height 0.4\textheight for important figures)
- [ ] Text density: 10-12 lines max at `\footnotesize`, 12-15 lines at `\scriptsize` (with `\iqbfontsizemode{small}`)
- [ ] No `[shrink]` option used
- [ ] No manual `\vspace` hacks (use `\iqbsep`, `\iqbsmallsep`, `\iqbtinysep`, `\iqbmicrosep`)
- [ ] Punchline title preserved
- [ ] **Content meaning preserved (CRITICAL - never delete key information)**
- [ ] Prefer `\iqbfontsizemode{small}` over manual font size adjustments
- [ ] Use spacing hierarchy: `\iqbsep` > `\iqbsmallsep` > `\iqbtinysep` > `\iqbmicrosep`

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

### Technique 0: Global Small Mode (Most Important)
**Always try this first** before any other optimization:
```latex
\begin{frame}{Title}
  \iqbfontsizemode{small}  % FIRST CHOICE for dense content
  % All subsequent content automatically shrinks:
  % - Normal text: \footnotesize → \scriptsize
  % - Lists: \scriptsize → \tiny
  % - Captions: \scriptsize → \tiny

  % Your dense content here...
\end{frame}
```

**When to use:**
- MD simulation details (100ns, force fields, parameters)
- Complex tables (screening criteria, progressive thresholds)
- Method details with many bullet points
- Any slide with >10 lines of text

**Benefits:**
- Preserves all content (never delete)
- Globally consistent (no manual font adjustments)
- Reduces overfull by 50-80% in one command

### Technique 1: Spacing Hierarchy
Use template spacing commands in order of preference:
```latex
% Standard spacing (use by default)
\iqbsep          % 0.3cm - between major sections

% Compressed spacing (for denser content)
\iqbsmallsep     % 0.2cm - between minor sections

% Tight spacing (for very dense content)
\iqbtinysep      % 0.15cm - between related items

% Micro spacing (last resort before splitting)
\iqbmicrosep     % 0.1cm - minimal separation
```

### Technique 2: Progressive Figure Sizing
Start with recommended size, reduce incrementally if needed:
```latex
% Try sequence: 0.75 → 0.70 → 0.68 → 0.65\textheight
\iqbfig[height=0.68\textheight]{image.png}{Caption}

% With global small mode, can increase figure:
\iqbfontsizemode{small}
\iqbfig[height=0.75\textheight]{image.png}{Caption}  % Larger image!
```

### Technique 3: Content Hierarchy
Use structure to reduce perceived density:
```latex
% Instead of flat list
\textbf{Category 1:} brief description
\iqbitemize{
  \item Detail A
  \item Detail B
}

\iqbsmallsep  % Template spacing instead of \medskip

\textbf{Category 2:} brief description
\iqbitemize{
  \item Detail C
}
```

### Technique 4: Column Width Adjustment
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

### Technique 5: Layout Restructuring (Before Deletion)
**Principle:** Reorganize before removing content
```latex
% Before: TikZ mindmap (space-inefficient)
\begin{tikzpicture}[mindmap]
  \node{Center} child{...} child{...};
\end{tikzpicture}

% After: Dual-column list (compact, preserves all info)
\iqblayouttwo{
  \iqbsectiontitle{Category 1}
  \begin{iqbitemize}
    \item Point A
    \item Point B
  \end{iqbitemize}
}{
  \iqbsectiontitle{Category 2}
  \begin{iqbitemize}
    \item Point C
    \item Point D
  \end{iqbitemize}
}
```

### Technique 6: Strategic Content Removal (LAST RESORT)
**IMPORTANT:** Only remove content if ALL other techniques fail.

**Allowed removals:**
- Redundant examples (keep most illustrative one)
- Overly verbose explanations (condense, don't delete)
- Decorative text that doesn't advance narrative

**FORBIDDEN removals:**
- Key technical details (e.g., "α/β mixed structure")
- Critical parameters (e.g., "≥5% probability threshold")
- Scientific conclusions or findings

Remember: **拆分和重组优于删减** (Split and reorganize before deleting). Better to create two well-organized slides than one cluttered slide or one slide with missing information.

## Real-World Example: Enzyme Design Presentation

**Initial problem:** 39+ overfull warnings, content overflow on slides 17, 19, 21

**Fix sequence:**

**Slide 17 (MD Simulation - 40.68pt overfull vbox)**
```latex
% Before
\begin{frame}{结果8：分子动力学验证活性位点稳定性}
  \iqblayoutcustom[0.45]{
    \textbf{MD模拟验证}：
    \begin{iqbitemize}
      \item 100 ns全原子MD在溶液中进行
      ...
    \end{iqbitemize}
    \iqbsep
    \textbf{关键发现}：
    ...
  }{...}
\end{frame}
% Result: Overfull \vbox (40.68pt too high)

% After - Applied Technique 0 (Global Small Mode)
\begin{frame}{结果8：分子动力学验证活性位点稳定性}
  \iqbfontsizemode{small}  % ONE LINE FIX
  \iqblayoutcustom[0.45]{
    % Same content, no deletion
  }{...}
\end{frame}
% Result: Overfull reduced to 2.34pt (negligible)
```

**Slide 19 (Mechanistic Insights - 90pt overfull vbox)**
```latex
% Before - TikZ mindmap too large
\begin{tikzpicture}[mindmap]
  \node{决定因素} child{node{几何精度}} child{...};
\end{tikzpicture}
% Result: Overfull \vbox (90pt) even with \iqbfontsizemode{small}

% After - Applied Technique 5 (Layout Restructuring)
\iqbfontsizemode{small}
\iqblayouttwo{
  \iqbsectiontitle{必要条件：几何精度}
  \begin{iqbitemize}
    \item Cα原子对齐（RMSD < 1 Å）
    \item 侧链位置精确定位
  \end{iqbitemize}
  \iqbsmallsep
  \iqbsectiontitle{支撑网络：结构稳定}
  ...
}{
  \iqbsectiontitle{底物进入：通道可达}
  ...
  \iqbsmallsep
  \iqbsectiontitle{动力学：过渡态稳定}
  ...
}
% Result: 0pt overfull, all content preserved
```

**Slide 21 (Impact - 74.68pt overfull vbox)**
```latex
% Before - Formula frame too rigid
\iqbformulaframe{
  \textbf{科学贡献}
  ...
}
% Result: Overfull \vbox (74.68pt)

% After - Applied Technique 5 (Convert to normal frame)
\begin{frame}{广泛意义与学科影响}
  \iqbfontsizemode{small}
  \iqbsectiontitle{科学贡献}
  \begin{iqbitemize}...
  \iqbsmallsep
  \iqbsectiontitle{技术转移}
  ...
\end{frame}
% Result: 1.14pt overfull (acceptable)
```

**Slide 12 (Critical mistake - deleted key information)**
```latex
% WRONG - Deleted "α/β"
\item 圆二色谱（CD）显示典型混合结构

% CORRECT - Preserved all key details
\item 圆二色谱（CD）显示典型α/β混合结构
```

**Final outcome:**
- Overfull warnings: 39+ → 1 (only 1.14pt, negligible)
- Slides affected: 17, 19, 21 (all fixed)
- Content deleted: 0 (all information preserved)
- Techniques used: Global small mode (3x), Layout restructuring (2x), Spacing compression (throughout)
- Total time: ~30 minutes (would have been hours with manual adjustments)
