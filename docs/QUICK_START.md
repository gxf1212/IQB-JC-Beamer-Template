# IQB Beamer 模板快速开始指南

## 📋 系统要求

### 必需软件

- **TeX 发行版** (选择其一)：
  - **TeX Live 2020+** (推荐 2023+) - Linux/macOS/Windows
  - **MiKTeX** - Windows
- **XeLaTeX** 编译器（支持中文）
- **中文字体**：
  - Windows: 系统自带 SimSun（宋体）
  - Linux: 安装 `fonts-noto-cjk`
  - macOS: 系统自带中文字体

### 可选工具

- **VS Code** + LaTeX Workshop 插件（推荐）
- **Overleaf** 在线编辑（需上传主题文件）
- **TeXstudio** / **TeXmaker** 等 LaTeX 编辑器

---

## 🚀 5 分钟快速上手

### 方法 A：使用空白模板

1. **复制模板**：
   ```bash
   cd your-project-directory
   cp path/to/IQB-JC-Beamer/template/jc-template.tex my-jc.tex
   ```

2. **复制主题文件**：
   ```bash
   cp -r path/to/IQB-JC-Beamer/theme ./
   ```

3. **编辑内容**：
   打开 `my-jc.tex`，搜索 `TODO` 标记，填写你的信息：
   ```latex
   \title{你的文献标题}
   \author{你的名字}
   \date{\today}
   ```

4. **编译**：
   ```bash
   xelatex my-jc.tex  # 中文支持
   # 或
   pdflatex my-jc.tex  # 仅英文
   ```

5. **查看结果**：
   打开生成的 `my-jc.pdf`

### 方法 B：从示例开始

1. **查看完整示例**：
   ```bash
   cd IQB-JC-Beamer/examples
   xelatex membrane-pore-jc.tex
   ```

2. **复制并修改**：
   ```bash
   cp membrane-pore-jc.tex my-jc.tex
   # 编辑 my-jc.tex，替换内容和图片
   ```

---

## 📝 最小工作示例

创建 `minimal.tex`：

```latex
\documentclass[aspectratio=169,11pt]{beamer}

% 加载 IQB 主题
\usepackage{theme/beamerthemeiqb}
\usepackage{theme/iqb-layouts}

\title{测试演示}
\author{张三}
\institute{IQB Lab}
\date{\today}

\begin{document}

% 封面页
\begin{frame}[plain]
  \titlepage
\end{frame}

% 内容页
\setsection{Introduction}
\begin{frame}{第一页}
  \begin{itemize}
    \item Hello, World!
    \item This is IQB Beamer Template
  \end{itemize}
\end{frame}

% 致谢页
\begin{frame}[plain]
  \centering
  {\Huge Thank You!}
\end{frame}

\end{document}
```

编译：
```bash
xelatex minimal.tex
```

---

## 🔧 编译命令详解

### XeLaTeX（推荐，支持中文）

```bash
# 单次编译
xelatex your-file.tex

# 完整编译（包含参考文献）
xelatex your-file.tex
bibtex your-file
xelatex your-file.tex
xelatex your-file.tex
```

### PDFLaTeX（仅英文）

```bash
pdflatex your-file.tex
```

### 使用 latexmk 自动化

```bash
# 自动检测并多次编译
latexmk -xelatex your-file.tex

# 监视模式（文件修改后自动重新编译）
latexmk -xelatex -pvc your-file.tex
```

### VS Code 配置

在 `.vscode/settings.json` 中添加：

```json
{
  "latex-workshop.latex.recipes": [
    {
      "name": "xelatex",
      "tools": ["xelatex"]
    }
  ],
  "latex-workshop.latex.tools": [
    {
      "name": "xelatex",
      "command": "xelatex",
      "args": [
        "-synctex=1",
        "-interaction=nonstopmode",
        "-file-line-error",
        "%DOC%"
      ]
    }
  ]
}
```

---

## 🎨 基础使用

### 1. 设置 Footer Section

每个 section 开始前使用 `\setsection{}`：

```latex
\setsection{Background}  % footer 显示 "Background"
\begin{frame}{背景介绍}
  ...
\end{frame}

\setsection{Methods}  % footer 显示 "Methods"
\begin{frame}{研究方法}
  ...
\end{frame}
```

### 2. 特殊页面（无 header/footer）

封面页和致谢页通常不需要 header 和 footer：

```latex
\begin{frame}[plain,noframenumbering]
  \titlepage
\end{frame}
```

- `plain`: 移除 header 和 footer
- `noframenumbering`: 不计入总页数

### 3. 插入图片

```latex
\begin{frame}{图片示例}
  \centering
  \includegraphics[width=0.8\textwidth]{images/figure1.png}

  \vspace{0.3cm}
  \small
  图 1：说明文字
\end{frame}
```

**控制图片大小**：
- `width=0.8\textwidth` - 宽度为页面宽度的 80%
- `height=0.6\textheight` - 高度为页面高度的 60%
- `scale=0.5` - 缩放到 50%

### 4. 使用 Block 环境

```latex
\begin{block}{标题}
  这里是重点内容
\end{block}
```

---

## 🐛 常见问题与解决

### 问题 1：编译错误 "File `beamerthemeiqb.sty' not found"

**原因**：主题文件路径不正确

**解决**：
- 确保 `theme/` 文件夹在 `.tex` 文件同一目录
- 或修改路径：`\usepackage{../theme/beamerthemeiqb}`（如果在子文件夹）

### 问题 2：中文显示为方块或乱码

**原因**：未使用 XeLaTeX 或缺少中文字体

**解决**：
```latex
\usepackage{xeCJK}
\setCJKmainfont{SimSun}  % Windows
% 或
\setCJKmainfont{Noto Sans CJK SC}  % Linux
```

然后使用 `xelatex` 编译。

### 问题 3：Header 图片不显示

**原因**：`header.png` 路径错误

**解决**：
- 检查 `theme/images/header.png` 是否存在
- 确保编译时使用 `--shell-escape`（某些发行版需要）

### 问题 4：Footer 中 section 不显示

**原因**：忘记调用 `\setsection{}`

**解决**：
```latex
\setsection{Methods}  % 在 frame 之前调用
\begin{frame}{...}
  ...
\end{frame}
```

### 问题 5：页面内容溢出

**原因**：内容过多或图片过大

**解决**：
- 减少文字要点（每页不超过 6-7 个）
- 限制图片高度：`height=0.6\textheight`
- 使用 `\vspace{0.3cm}` 调整间距
- 考虑拆分成两页

---

## 📚 下一步学习

- 查看 **完整示例** `examples/membrane-pore-jc.tex` 学习高级布局
- 阅读 [布局完全指南](LAYOUT_GUIDE.md) 了解所有布局命令
- 参考 **空白模板** `template/jc-template.tex` 中的注释

---

## 💡 小技巧

### 1. 快速预览当前页

在 frame 环境后添加 `\end{document}`，只编译当前页：

```latex
\begin{frame}{调试这一页}
  ...
\end{frame}
\end{document}  % 临时结束，调试完删除
```

### 2. 使用占位图片

LaTeX 内置 `example-image-a/b/c`：

```latex
\includegraphics[width=0.5\textwidth]{example-image-a}
```

### 3. 批量编译示例

```bash
for file in *.tex; do
  xelatex "$file"
done
```

---

## 📞 获取帮助

- **GitHub Issues**: [项目 Issues 页面](https://github.com/your-org/IQB-JC-Beamer/issues)
- **邮件**: contact@iqblab.edu
- **内部讨论**: IQB Lab Slack #latex-help

---

**更新时间**: 2025-10-20
**模板版本**: 1.0
