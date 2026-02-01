# PDF Figure Extractor

自动从PDF教材中提取FIGURE图片的完整工作流程。

## 功能说明

这个skill可以：
1. **搜索FIGURE位置**：在PDF中搜索"FIGURE X.Y"文字，定位每个图片的页码
2. **提取页面图片**：只提取包含FIGURE的页面（不是全部页面）
3. **智能裁剪**：自动裁剪掉页面边缘，只保留图片内容
4. **分析布局**：分析图片尺寸和宽高比，推荐Beamer布局方案

## 使用场景

- 为IQB Journal Club制作slides时，需要从PDF教材提取图片
- 需要保留原图的Figure编号和标题
- 希望自动识别图片在PDF中的位置

## 使用方法

### 基本用法

```
用户：从chapter3.pdf提取所有FIGURE 3.x的图片到Figures目录
```

### 高级用法

```
用户：从chapter3.pdf提取FIGURE 3.1和FIGURE 3.2，并分析它们的布局
```

```
用户：提取chem.pdf中所有包含"Figure 4."的图片
```

## 工作流程

1. **搜索阶段**：使用`tools/search_pdf_text.py`搜索PDF中的"FIGURE X.Y"文字
   - 返回：每个FIGURE所在的页码和标题文字

2. **提取阶段**：使用`tools/extract_pdf_page.py`只提取包含FIGURE的页面
   - 只提取需要的页面，不是全部26页
   - 保存为临时PNG文件

3. **裁剪阶段**：使用`tools/crop_figure_from_page.py`智能裁剪
   - 自动检测图片内容区域
   - 去除白色边距和页面边缘
   - 可选手动调整裁剪区域

4. **分析阶段**：使用`tools/analyze_image_layout.py`分析图片
   - 计算宽高比
   - 分类图片方向（竖版/横版/方形）
   - 推荐Beamer布局命令

5. **整理阶段**：
   - 重命名为figX_Y.png格式（对应PDF中的Figure编号）
   - 生成图片列表和使用建议

## 输出结果

### 文件输出

```
Figures/
├── fig3_1.png          # Figure 3.1 (裁剪后)
├── fig3_2.png          # Figure 3.2 (裁剪后)
├── fig3_3.png          # Figure 3.3 (裁剪后)
└── fig3_4.png          # Figure 3.4 (裁剪后)
```

### 控制台输出

```
✅ 搜索结果：
   Figure 3.1: 第13页 - "An infinitesimal box-shaped region"
   Figure 3.2: 第14页 - "Inside the"
   Figure 3.3: 第17页 - "Energies of"
   Figure 3.4: 第22页 - "Function (a)"

✅ 提取完成：4个图片已裁剪并保存

📊 布局分析：
   fig3_1.png (1700×2200, ratio=0.77) → 竖向图
      推荐: \iqblayouttwothirds (2/3文字 + 1/3图)

   fig3_2.png (1800×1200, ratio=1.50) → 横向图
      推荐: \iqblayoutonethird (1/3文字 + 2/3图)
```

## 技术细节

### 工具依赖

- `pymupdf` (fitz): PDF文本提取
- `pdf2image`: PDF页面转图片
- `Pillow` (PIL): 图片裁剪和分析
- `poppler`: PDF渲染

### 关键参数

- **margin**: 裁剪边缘留白（默认50像素）
- **threshold**: 白色背景阈值（默认250）
- **context_lines**: 搜索上下文行数（默认3行）

### 搜索策略

```python
# 搜索模式
pattern = r"FIGURE\s+\d+\.\d+"

# 例子：
# "FIGURE 3.1 An infinitesimal box"
# "Figure 3.2 Inside the"
```

## 注意事项

1. **命名规范**：输出文件名统一为`figX_Y.png`格式（小写，下划线）
2. **只提取需要的页面**：不会提取全部26页，只提取包含FIGURE的页面
3. **自动裁剪**：首次裁剪可能不完美，可以手动调整
4. **PDF差异**：不同PDF的FIGURE格式可能不同（FIGURE/Figure/figure）

## 示例对话

**用户**: 从chapter3.pdf提取所有FIGURE图片

**Assistant**: 我来帮你提取chapter3.pdf中的所有FIGURE图片。

[执行搜索、提取、裁剪流程]

✅ 完成！我找到了4个FIGURE：
- Figure 3.1 (第13页): An infinitesimal box-shaped region
- Figure 3.2 (第14页): Inside the
- Figure 3.3 (第17页): Energies of
- Figure 3.4 (第22页): Function (a)

所有图片已裁剪并保存到Figures/目录。

**用户**: 这些图片在slides中怎么用？

**Assistant**: 根据图片布局分析：
- fig3_1是竖版图，建议用`\iqblayouttwothirds`布局
- fig3_2是横版图，建议用`\iqblayoutonethird`布局
- ...
