# IQB Journal Club Touying 模板项目指南

本文档为 Claude Code 提供项目特定的开发指南。

## 项目概述

- **项目类型**: Typst/Touying 学术幻灯片模板
- **技术栈**: Typst 0.13+, Touying 0.6.1
- **编译命令**: `typst compile --root . examples/<file>.typ examples/output/<file>.pdf`

## 核心开发原则

### 布局要求
- 布局要整齐，尽量对齐
- 注意保证每一页的布局，文字图片不要溢出到下一页
- 合理使用 `#v()` 控制垂直间距
- 字体大小：正文11pt，footer 10pt

### Header（页眉横幅）
- **资源文件**: `/assets/images/header.png` (1999×204px)
- **显示要求**:
  - 占满slides的**full width** (13cm)
  - 高度约0.8cm
  - **除了首页（封面）和末页（致谢）外，所有页面都必须显示**
- **使用方法**: 在每个slide开始处调用 `#iqb-header()`

### Footer（页脚）
- **位置**: 固定在页面最底部
- **内容组成**:
  - 左侧: "IQB Lab"
  - 中间: **Section进度标识**（如"Background"、"Methods"、"Results"、"Discussion"）
  - 右侧: 页码/总页数（如"3 / 15"）
- **字体**: 10pt, 深灰色
- **使用方法**: `#iqb-footer(section: [Methods])`

### 参考资料
- E:\GitHub-repo\literature-reading\JC 之下的各个pptx文件
- tex在D:\texlive

## 技术规范

**关键规则**: 始终使用 `--root .` 编译，所有路径从项目根目录开始
**重要**: 函数定义中，命名参数必须在位置参数之前

```typst
// ✅ 正确
#let my-layout(
  section: none,     // 命名参数（带默认值）
  content-left,      // 位置参数（必需）
  content-right,
) = { ... }

// ❌ 错误（编译失败）
#let my-layout(
  content-left,      // 位置参数
  section: none,     // 命名参数在后面 ❌
) = { ... }
```

### 3. 组件化设计

- 所有可复用元素应封装为组件函数
- 组件位于 `src/components/` 目录
- 主模板 `src/main.typ` 导入所有组件
- 尽量让主文档简洁，调用组件

## PDF调试工具

### 工具：`tools/extract_pdf_page.py`

当PDF布局出现问题时，使用此工具提取单页为图片供视觉模型分析。

**基本用法**:
```bash
# 提取第5页到默认位置 /tmp/pdf_page_5.png
python tools/extract_pdf_page.py examples/output/pore-free-energy-jc.pdf 5

# 提取第1页到指定位置
python tools/extract_pdf_page.py examples/output/demo-jc.pdf 1 /tmp/cover.png
```

**依赖安装**:
```bash
pip install pdf2image
# Ubuntu/Debian
sudo apt install poppler-utils
```

### 调试工作流

1. **编译PDF**: `typst compile --root . examples/xxx.typ examples/output/xxx.pdf`
2. **发现问题**: 用户提到"header不显示"、"布局乱了"等
3. **提取页面**: `python tools/extract_pdf_page.py examples/output/xxx.pdf <页码>`
4. **视觉分析**: 用 `Read` 工具查看生成的图片，用视觉模型诊断问题
5. **修复源码**: 根据诊断结果修改 `.typ` 文件
6. **重新编译**: 验证修复效果
7. **清理临时文件**: `rm /tmp/pdf_page_*.png`

## 与 Claude Code 协作提示

**主动行动**:
- "布局乱了" → 提取相关页面，用视觉模型诊断问题
- "header不显示" → 提取第2-3页检查，验证 `#iqb-header()` 调用
- "footer没有section" → 检查 `#iqb-footer(section: [xxx])` 参数
- 修改后，立即重新编译验证
- 发现路径问题，主动检查文件是否存在
- 用户提到PDF问题，主动提议使用extract工具
- 看完以后及时清理临时图片
- 完成修改后，建议用户用watch模式实时预览

## 编译命令速查

```bash
# 单次编译
typst compile --root . examples/pore-free-energy-jc.typ examples/output/pore-free-energy-jc.pdf

# 监视模式（推荐开发时使用）
typst watch --root . examples/pore-free-energy-jc.typ examples/output/pore-free-energy-jc.pdf

# 过滤字体警告
typst compile --root . examples/xxx.typ examples/output/xxx.pdf 2>&1 | grep -v "warning: unknown font"

# 检查输出文件
ls -lh examples/output/*.pdf

# 提取PDF页面调试
python tools/extract_pdf_page.py examples/output/xxx.pdf 5
```
