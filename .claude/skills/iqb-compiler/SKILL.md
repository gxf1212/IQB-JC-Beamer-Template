---
name: iqb-compiler
description: Compile IQB Beamer presentations using XeLaTeX, diagnose LaTeX errors, fix common issues, and iterate until successful compilation. Use when user wants to build PDF or when encountering compilation errors.
---

# IQB Compiler

Specialized in compiling IQB Beamer presentations using Windows TeXLive via WSL, with intelligent error diagnosis and fixing.

## Core Responsibilities

1. **Compile LaTeX to PDF**
   - Use correct XeLaTeX path in WSL environment
   - Handle CJK and complex layouts
   - Generate clean output

2. **Diagnose Errors**
   - Parse LaTeX error messages
   - Identify root causes
   - Suggest fixes

3. **Iterative Fixing**
   - Apply fixes automatically when possible
   - Test compilation after each fix
   - Repeat until clean build

## Compilation Command

**Standard compilation:**
```bash
cd examples  # or appropriate directory
/mnt/d/texlive/2022/bin/win32/xelatex.exe -interaction=nonstopmode filename.tex
```

**Key parameters:**
- `-interaction=nonstopmode`: Don't pause on errors
- Must run from directory containing .tex file
- Output PDF appears in same directory

## Common Errors and Fixes

### Error 1: Undefined Control Sequence

**Error message:**
```
! Undefined control sequence.
l.123 \iqbfigure
```

**Cause:** Typo in command name or missing package

**Fix:**
```latex
% Check spelling
\iqbfigure → \iqbfig

% Ensure package loaded
\usepackage{../theme/iqb-layouts}
```

### Error 2: Missing Image

**Error message:**
```
! LaTeX Error: File 'image.png' not found.
```

**Fix:**
1. Check file exists: `ls images/membrane-pore-jc/image.png`
2. Verify path is relative to .tex file
3. Fix path:
```latex
% If .tex is in examples/
images/membrane-pore-jc/fig1.png  % Correct
../images/fig1.png                 % Wrong directory level
```

### Error 3: Overfull Boxes

**Warning message:**
```
Overfull \hbox (12.34pt too wide) in paragraph at lines 45--46
Overfull \vbox (5.67pt too high) detected at line 89
```

**Not a fatal error**, but should be fixed:
- Use **iqb-layout-optimizer** skill to fix these
- Do NOT ignore - they indicate layout problems

### Error 4: Missing \begin{document}

**Error message:**
```
! LaTeX Error: Missing \begin{document}.
```

**Cause:** Content before `\begin{document}` or encoding issue

**Fix:**
1. Ensure no text before `\begin{document}`
2. Check for stray characters in preamble
3. Verify UTF-8 encoding

### Error 5: Extra \endframe

**Error message:**
```
! LaTeX Error: \begin{frame} on line 45 ended by \end{document}.
```

**Cause:** Missing `\end{frame}` somewhere

**Fix:**
1. Search backwards from error line for unclosed frames
2. Add missing `\end{frame}`
3. Use editor's bracket matching to verify pairs

### Error 6: Package Conflict

**Error message:**
```
! Package xcolor Error: Undefined color `iqbblue'.
```

**Cause:** Theme not loaded or loaded in wrong order

**Fix:**
```latex
% Correct order in preamble
\documentclass[aspectratio=169,11pt]{beamer}

\usepackage{../theme/beamerthemeiqb}  % Load theme FIRST
\usepackage{../theme/iqb-layouts}     % Then layouts

% Do NOT load these manually (theme loads them):
% \usepackage{xcolor}
% \usepackage{tikz}
```

### Error 7: CJK Font Issues

**Error message:**
```
! Package fontspec Error: The font "SimSun" cannot be found.
```

**Fix:**
- In WSL, CJK fonts from Windows should work
- Verify TeXLive path is Windows version: `/mnt/d/texlive/...`
- Alternative: Use Linux fonts in `beamerthemeiqb.sty`:
```latex
\setCJKmainfont{Noto Serif CJK SC}  % If SimSun not available
```

## Compilation Workflow

1. **Initial Compilation**
```bash
cd /mnt/e/GitHub-repo/IQB-JC-master/examples
/mnt/d/texlive/2022/bin/win32/xelatex.exe -interaction=nonstopmode membrane-pore-jc.tex
```

2. **Check Output**
- If successful: PDF created, check for warnings
- If failed: Parse error messages

3. **Error Analysis**
- Extract line number: `l.123`
- Identify error type
- Locate problematic code

4. **Apply Fix**
- Edit .tex file with correct syntax
- **DO NOT** edit theme files unless absolutely necessary

5. **Recompile**
- Run XeLaTeX again
- Verify fix worked

6. **Repeat Until Clean**
- May need 2-3 compilation passes for references
- Goal: No errors, minimal warnings

## Handling Overfull Warnings

**Philosophy:** Overfull boxes should be fixed, not ignored

**Workflow:**
1. Note all overfull warnings from compilation log
2. After successful compilation, invoke **iqb-layout-optimizer**
3. Let optimizer fix layout issues
4. Recompile to verify fixes

**DO NOT:**
- Use `[shrink=10]` to hide overfull
- Add random `\vspace{-1cm}` hacks
- Ignore warnings because "PDF looks OK"

## Output Verification

After successful compilation:

1. **Check PDF exists:**
```bash
ls -lh examples/membrane-pore-jc.pdf
```

2. **Check page count:**
```bash
pdfinfo examples/membrane-pore-jc.pdf | grep Pages
```

3. **Verify file size reasonable** (typically 1-5 MB for JC presentation)

4. **Open PDF** (if user requests):
```bash
# In WSL, open with Windows default viewer
explorer.exe examples/membrane-pore-jc.pdf
```

## Special Compilation Scenarios

### Scenario 1: First Compilation of New File

**May need 2 passes** for correct references:
```bash
/mnt/d/texlive/2022/bin/win32/xelatex.exe -interaction=nonstopmode file.tex
/mnt/d/texlive/2022/bin/win32/xelatex.exe -interaction=nonstopmode file.tex
```

### Scenario 2: Bibliography (if used)

**Requires Biber + 3 passes:**
```bash
/mnt/d/texlive/2022/bin/win32/xelatex.exe file.tex
/mnt/d/texlive/2022/bin/win32/biber.exe file
/mnt/d/texlive/2022/bin/win32/xelatex.exe file.tex
/mnt/d/texlive/2022/bin/win32/xelatex.exe file.tex
```

### Scenario 3: Clean Build

**Remove auxiliary files first:**
```bash
rm file.aux file.log file.nav file.out file.snm file.toc file.vrb
/mnt/d/texlive/2022/bin/win32/xelatex.exe -interaction=nonstopmode file.tex
```

## Debugging Tips

### Tip 1: Isolate Problem

If errors are overwhelming:
1. Comment out frames one-by-one
2. Find which frame causes error
3. Fix that specific frame

### Tip 2: Check Logs Carefully

Important log sections:
```
! LaTeX Error: ...       ← Error type
l.123 \iqbfig{...}       ← Exact line
```

### Tip 3: Verify Theme Loading

Add diagnostic message:
```latex
\usepackage{../theme/beamerthemeiqb}
\typeout{IQB theme loaded successfully}  % Should appear in log
```

### Tip 4: Test Minimal Example

Create minimal test file:
```latex
\documentclass[aspectratio=169,11pt]{beamer}
\usepackage{../theme/beamerthemeiqb}

\begin{document}
\begin{frame}{Test}
  Hello World
\end{frame}
\end{document}
```

If this fails, problem is in theme. If succeeds, problem is in main file.

## Integration with Other Skills

**Before compiling:**
- Use **iqb-content-planner** to design structure
- Use **iqb-slide-writer** to write frames

**During compilation:**
- Fix LaTeX errors (this skill)
- If overfull warnings → use **iqb-layout-optimizer**

**After successful compilation:**
- Use **iqb-quality-checker** to review PDF layout

**Iterative loop:**
```
iqb-slide-writer → iqb-compiler → [fix errors] → iqb-compiler →
[fix overfull] → iqb-layout-optimizer → iqb-compiler → iqb-quality-checker
```

## When NOT to Use This Skill

- Planning presentation structure (use iqb-content-planner)
- Writing slide content (use iqb-slide-writer)
- Fixing layout/overfull issues (use iqb-layout-optimizer after compilation)
- Reviewing PDF visual quality (use iqb-quality-checker)

## Quality Checklist

Before marking compilation as complete:
- [ ] PDF file generated successfully
- [ ] No LaTeX errors
- [ ] Overfull warnings addressed (or noted for optimizer)
- [ ] Page count matches expected
- [ ] File size reasonable (not 0 bytes or 50+ MB)
- [ ] All frames compiled (check page count vs frame count)

## Advanced: Performance Optimization

For large presentations (50+ slides):

**Use draft mode for quick iterations:**
```bash
# Add [draft] option to skip images
\documentclass[aspectratio=169,11pt,draft]{beamer}
```

**Final compilation without draft:**
```bash
# Remove [draft] for final PDF
\documentclass[aspectratio=169,11pt]{beamer}
```

Remember: Compilation is a means to an end. The goal is a **clean, professional PDF** with no errors and minimal warnings.
