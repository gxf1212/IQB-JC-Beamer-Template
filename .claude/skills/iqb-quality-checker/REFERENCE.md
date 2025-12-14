# IQB Quality Checker - Reference Guide

本文件包含详细的检查清单和修复方案，是 SKILL.md 的补充参考。

## 辅助工具

### check_header.py
自动提取 PDF 页面并标记需要检查的 Header 位置。

**用法：**
```bash
python3 .claude/skills/iqb-quality-checker/helpers/check_header.py examples/membrane-pore-jc.pdf 3 5 7
```

**输出：**
- 提取指定页面为 PNG
- 标记首页和末页（不应有 Header）
- 提供检查清单

## 完整检查清单

### Header 检查（每个非 plain 页面）
- [ ] 宽度占满整个 slide（`width=\paperwidth`）
- [ ] 高度保持比例（1999×204px）
- [ ] 位于页面顶部，无遮挡
- [ ] 首页无 Header
- [ ] 末页无 Header

### Footer 检查
- [ ] 三段式结构：Left | Center | Right
- [ ] Left 内容：`\textbf{\iqbinstitute}`（IQB blue）
- [ ] Center 内容：通过 `\setsection{}` 设置
- [ ] Right 内容：`N / Total` 格式
- [ ] 顶部蓝色分割线（1.5pt）
- [ ] 不超出页面底部边界

### Frametitle 检查
- [ ] 位置：左上角，TikZ 绝对定位
- [ ] 背景：完全透明（无 fill color）
- [ ] 颜色：IQB blue (#003366)
- [ ] 内容：包含 punchline（结论/发现），非描述性标签
- [ ] 不占用正文内容空间

### 图片检查
- [ ] 所有图片清晰可读（最小 0.4\textheight）
- [ ] 竖版图使用 column 布局
- [ ] 每个图有 caption（详细或整合到文字）
- [ ] 自动编号（"图1:", "图2:"）
- [ ] 无像素化或失真
- [ ] 宽高比正确

### 布局检查
- [ ] 文字密度：≤ 10-12 行/页
- [ ] 图文比例合理（通常 1:1 或 1:2）
- [ ] 使用留白，不填满每一寸
- [ ] 列对齐正确
- [ ] 无内容超出边界

### 排版检查
- [ ] 正文字号：`\scriptsize`（通过模板设置）
- [ ] 无手动 `\large`, `\normalsize` 在正文
- [ ] 行间距：1.2（150% of point size）
- [ ] 中文正确渲染
- [ ] 无字体替换警告

### 内容检查
- [ ] 所有 frametitle 是 punchline
- [ ] Section markers 适当变化
- [ ] 页面逻辑流畅
- [ ] 无不完整的解释
- [ ] 引用格式正确

## 质量评分标准

### 5 分标准
**Header/Footer 格式（5 分）:**
- 5: 完美符合规范
- 4: 有 1 个小问题（如 section marker 遗漏）
- 3: 有 2-3 个问题
- 2: Header 不全宽或 Footer 超出边界
- 1: Header/Footer 缺失或严重错误

**Frametitle 质量（5 分）:**
- 5: 所有标题都是 punchline
- 4: 1-2 个标题需要改进
- 3: 3-5 个标题是描述性的
- 2: 大多数标题是描述性的
- 1: 标题质量严重不足

**图片质量（5 分）:**
- 5: 所有图片清晰、尺寸合适、有 caption
- 4: 1-2 个图片略小或 caption 简略
- 3: 多个图片偏小或部分无 caption
- 2: 竖版图堆叠（未用 column）
- 1: 图片太小无法辨识

**布局平衡（5 分）:**
- 5: 无 overfull，图文完美平衡
- 4: 有轻微 overfull（< 5pt）
- 3: 有中等 overfull 或 1-2 页过挤
- 2: 多处 overfull 或布局失衡
- 1: 严重溢出或混乱布局

**排版（5 分）:**
- 5: 字号、行距、字体完全正确
- 4: 有 1 处手动字号调整
- 3: 多处手动调整或行距不一致
- 2: 中文渲染问题或字体警告
- 1: 严重排版错误

**内容流畅性（5 分）:**
- 5: 逻辑清晰，叙事完整
- 4: 1-2 处衔接略生硬
- 3: 部分页面内容不连贯
- 2: 多处逻辑跳跃或遗漏
- 1: 内容组织混乱

**总分 ≥25：可发布质量**

## 常见问题快速修复

### 问题 1: Header 不全宽
**检测：** 两侧有空白
**修复：**
```latex
% beamerthemeiqb.sty, headline template
\includegraphics[width=\paperwidth,keepaspectratio]{\iqbheaderimage}
```

### 问题 2: Frametitle 有白色背景
**检测：** 标题后有白色矩形
**修复：**
```latex
% frametitle template 使用 TikZ overlay，无 fill
\node[anchor=north west,inner sep=0pt] at (...) {...}
% 确保无 fill=white 或类似设置
```

### 问题 3: Footer 超出页面
**检测：** 底部文字被截断
**修复：**
- 减少页面内容（使用 layout-optimizer）
- 调整 footer 垂直位置（在 theme 文件）

### 问题 4: 标题不是 punchline
**检测：** 标题如 "结果：XX"
**修复：**
```latex
% 改前
\begin{frame}{结果：交叉验证}

% 改后
\begin{frame}{双重验证：Full-Path与Rapid高度一致}
```

### 问题 5: 竖版图太小
**检测：** 图片高度 < 0.4\textheight
**修复：**
```latex
% 改前（堆叠布局）
\iqbfig[height=0.3\textheight]{tall.png}{Caption}

% 改后（column 布局）
\iqblayouttwo{
  Text content
}{
  \iqbfig[height=0.55\textheight]{tall.png}{Caption}
}
```

## 自动化检查流程

### 使用辅助脚本
```bash
# 1. 检查 Header
python3 .claude/skills/iqb-quality-checker/helpers/check_header.py output.pdf

# 2. 使用 Read tool 检查生成的 PNG
```

### 调用 pdf-layout-reviewer Agent
```
[使用 Task tool]
subagent_type: pdf-layout-reviewer
prompt: "Review pages 3, 5, 7 for IQB template compliance"
```

### 手动抽查关键页
```bash
# 提取关键页
python3 tools/extract_pdf_page.py output.pdf 1   # 封面
python3 tools/extract_pdf_page.py output.pdf 3   # 第一内容页
python3 tools/extract_pdf_page.py output.pdf -1  # 最后一页

# 使用 Read tool 视觉检查
```

## 报告模板

```markdown
## IQB Beamer Quality Report
**File:** examples/presentation.pdf
**Date:** YYYY-MM-DD
**Pages:** NN

### ✅ Passed (Score: X/30)
- Category 1: X/5
- Category 2: X/5
...

### ⚠️ Issues Found
1. **Page N:** Description
2. **Page N:** Description

### 🔧 Recommended Actions
1. Action 1
2. Action 2

### 📊 Quality Assessment
[Overall assessment text]
```
