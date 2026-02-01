# PDF Figure Extractor - 使用指南

## 功能概述

自动从PDF教材中提取FIGURE图片的完整工具链，专为IQB Journal Club slides制作优化。

## 工作流程

### 1. 搜索FIGURE位置
```bash
python3 tools/search_pdf_text.py chapter3.pdf "FIGURE 3."
```
**输出示例**：
```
Found 4 matches for 'FIGURE 3.' in chapter3.pdf
--- Match 1 (Page 13, line 904) ---
FIGURE 3.1 An infinitesimal box-shaped region
```

### 2. 提取页面图片
**只提取包含FIGURE的页面，不是全部页面！**

```bash
# 提取单个页面
python3 tools/extract_pdf_page.py chapter3.pdf 13 Figures/fig3_1_raw.png

# 批量提取多个页面
python3 tools/extract_pdf_page.py chapter3.pdf 13 Figures/fig3_1_raw.png && \
python3 tools/extract_pdf_page.py chapter3.pdf 14 Figures/fig3_2_raw.png && \
python3 tools/extract_pdf_page.py chapter3.pdf 17 Figures/fig3_3_raw.png && \
python3 tools/extract_pdf_page.py chapter3.pdf 22 Figures/fig3_4_raw.png
```

### 3. 智能裁剪图片
自动去除页面白边，只保留图片内容：

```bash
python3 tools/crop_figure_from_page.py Figures/fig3_1_raw.png Figures/fig3_1.png
```

**输出示例**：
```
✅ 裁剪完成: Figures/fig3_1_raw.png
   原始尺寸: 2481×3509
   裁剪尺寸: 2244×3011
   保存至: Figures/fig3_1.png
```

### 4. 分析图片布局
```bash
python3 tools/analyze_image_layout.py Figures/
```

**输出示例**：
```
fig3_1.png (2244×3011, ratio=0.75) → 方形图
   推荐: \iqblayoutonethird (1/3文字 + 2/3图) 或 \iqbfig

fig3_2.png (2243×3017, ratio=0.74) → 方形图
   推荐: \iqblayoutonethird (1/3文字 + 2/3图) 或 \iqbfig
```

## 完整示例：Chapter 3

```bash
# Step 1: 搜索FIGURE
python3 tools/search_pdf_text.py chapter3.pdf "FIGURE 3."

# Step 2: 提取4个页面
for page in 13 14 17 22; do
  num=$(echo "$page 13 14 17 22" | tr ' ' '\n' | grep -n "$page" | cut -d: -f1)
  python3 tools/extract_pdf_page.py chapter3.pdf $page Figures/fig3_${num}_raw.png
done

# Step 3: 裁剪所有图片
for i in 1 2 3 4; do
  python3 tools/crop_figure_from_page.py Figures/fig3_${i}_raw.png Figures/fig3_${i}.png
done

# Step 4: 清理临时文件
rm -f Figures/fig3_*_raw.png
```

## 在LaTeX slides中使用

### 方形图（ratio 0.7-1.0）- 最常见
```latex
\begin{frame}{标题}
  \iqblayoutonethird{
    文字内容（1/3宽度）
  }{
    \iqbfig[height=0.6\textheight]{Figures/fig3_1.png}{图注文字}
  }
\end{frame}
```

### 竖向高图（ratio < 0.7）
```latex
\begin{frame}{标题}
  \iqblayouttwothirds{
    文字内容（2/3宽度，长行）
  }{
    \iqbfig[height=0.7\textheight]{Figures/figX_Y.png}{图注}
  }
\end{frame}
```

### 超宽横向图（ratio > 1.5）
```latex
\begin{frame}{标题}
  \iqbfig[height=0.5\textheight]{Figures/figX_Y.png}{详细图注}
\end{frame}
```

## 技巧与注意事项

### 1. 命名规范
- 输出文件名：`fig3_1.png`（小写，下划线）
- 对应PDF中的：FIGURE 3.1
- 方便在LaTeX中引用

### 2. 只提取需要的页面
✅ **正确**：只提取4个包含FIGURE的页面
❌ **错误**：提取全部26页

```bash
# ❌ 错误：提取全部页面（耗时、占用空间）
for i in {1..26}; do extract_page $i; done

# ✅ 正确：只提取需要的页面
extract_page 13  # Figure 3.1
extract_page 14  # Figure 3.2
```

### 3. 裁剪质量检查
如果自动裁剪不理想，可以手动调整：

```bash
# 查看当前图片尺寸
identify Figures/fig3_1.png

# 手动指定裁剪区域 (left,top,right,bottom)
python3 tools/crop_figure_from_page.py \
  Figures/fig3_1_raw.png \
  Figures/fig3_1.png \
  --manual 100,200,2300,3000
```

### 4. 批量处理技巧
```bash
# 使用函数批量处理
extract_figures() {
  local pdf=$1
  local output_dir=$2
  shift 2

  for page_num in "$@"; do
    local fig_num=$((page_num - 12))  # 假设从第13页开始
    echo "Extracting page $page_num as Figure 3.$fig_num..."
    python3 tools/extract_pdf_page.py "$pdf" "$page_num" \
      "${output_dir}/fig3_${fig_num}_raw.png"
    python3 tools/crop_figure_from_page.py \
      "${output_dir}/fig3_${fig_num}_raw.png" \
      "${output_dir}/fig3_${fig_num}.png"
    rm -f "${output_dir}/fig3_${fig_num}_raw.png"
  done
}

# 使用
extract_figures chapter3.pdf Figures/ 13 14 17 22
```

## 常见问题

### Q1: 搜索不到FIGURE？
**A**: PDF中可能是"Figure"而不是"FIGURE"，尝试：
```bash
python3 tools/search_pdf_text.py chapter3.pdf "Figure 3."
# 或
python3 tools/search_pdf_text.py chapter3.pdf "figure 3."
```

### Q2: 裁剪后图片太大/太小？
**A**: 使用`--manual`选项手动调整：
```bash
# 先查看原图尺寸
identify Figures/fig3_1_raw.png

# 手动裁剪（保留更多/更少边距）
python3 tools/crop_figure_from_page.py \
  Figures/fig3_1_raw.png \
  Figures/fig3_1.png \
  --manual 50,50,2400,3300  # left,top,right,bottom
```

### Q3: 如何知道图片在哪一页？
**A**: 使用search_pdf_text.py搜索：
```bash
python3 tools/search_pdf_text.py chapter3.pdf "FIGURE 3.1"
```
会显示页码和上下文。

## 实际案例

### Chapter 3 (Operators)
```bash
# 1. 搜索
python3 tools/search_pdf_text.py chapter3.pdf "FIGURE 3."
# 找到4个FIGURE，分别在13, 14, 17, 22页

# 2. 提取
python3 tools/extract_pdf_page.py chapter3.pdf 13 Figures/fig3_1_raw.png
python3 tools/extract_pdf_page.py chapter3.pdf 14 Figures/fig3_2_raw.png
python3 tools/extract_pdf_page.py chapter3.pdf 17 Figures/fig3_3_raw.png
python3 tools/extract_pdf_page.py chapter3.pdf 22 Figures/fig3_4_raw.png

# 3. 裁剪
for i in 1 2 3 4; do
  python3 tools/crop_figure_from_page.py \
    Figures/fig3_${i}_raw.png \
    Figures/fig3_${i}.png
done

# 4. 清理
rm -f Figures/fig3_*_raw.png

# 5. 分析
python3 tools/analyze_image_layout.py Figures/

# 结果：4个方形图，都推荐用\iqblayoutonethird布局
```

## 工具位置

```
IQB-JC-master/
├── tools/
│   ├── search_pdf_text.py         # 搜索PDF文字
│   ├── extract_pdf_page.py        # 提取PDF页面为PNG
│   ├── crop_figure_from_page.py   # 裁剪图片
│   └── analyze_image_layout.py    # 分析图片布局
└── .claude/
    └── skills/
        └── pdf-figure-extractor/
            ├── skill.md           # Skill描述
            └── README.md          # 本文档
```

## 更新日志

- **2025-01-21**: 创建skill，实现自动提取workflow
- **2025-01-21**: 成功提取Chapter 3的4个FIGURE
- **2025-01-21**: 添加批量处理技巧和FAQ
