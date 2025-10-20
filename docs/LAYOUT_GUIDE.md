# IQB Beamer 模板布局完全指南

本文档详细介绍 IQB Beamer 模板提供的所有布局命令和使用技巧。

---

## 📐 布局命令总览

| 命令 | 用途 | 使用场景 |
|------|------|---------|
| `\iqblayouttwo` | 双列布局（50-50） | 对比两个概念/方法 |
| `\iqblayoutonethird` | 双列（1/3-2/3） | 左侧要点+右侧大图 |
| `\iqblayouttwothirds` | 双列（2/3-1/3） | 左侧大图+右侧要点 |
| `\iqblayoutthree` | 三列布局（均分） | 三种方法对比 |
| `\iqbgridtwobytwo` | 2×2 网格 | 四张子图展示 |
| `\iqbgridthreebytwo` | 3×2 网格 | 六张子图展示 |
| `\iqbimagetext` | 图片+文字（图在左） | 左图右文 |
| `\iqbtextimage` | 文字+图片（图在右） | 左文右图 |
| `\iqbfigure` | 单图+标题 | 独立图片展示 |
| `\iqbtwofigures` | 双图+各自标题 | 并列对比图片 |

---

## 🔧 详细使用说明

### 1. 双列布局系列

#### 1.1 标准双列（50-50）

**命令**：`\iqblayouttwo{左列内容}{右列内容}`

**示例**：
```latex
\begin{frame}{双列对比}
  \iqblayouttwo{
    % 左列
    \textbf{传统方法}：
    \begin{itemize}
      \item Rosetta
      \item FoldX
      \item 能量最小化
    \end{itemize}

    \includegraphics[width=\textwidth]{images/traditional.png}
  }{
    % 右列
    \textbf{机器学习方法}：
    \begin{itemize}
      \item ProteinMPNN
      \item AlphaFold
      \item 深度学习
    \end{itemize}

    \includegraphics[width=\textwidth]{images/ml-method.png}
  }
\end{frame}
```

**适用场景**：
- 方法对比
- 结果对比
- 图文并列

#### 1.2 非对称双列（1/3 - 2/3）

**命令**：`\iqblayoutonethird{左列（窄）}{右列（宽）}`

**示例**：
```latex
\begin{frame}{方法原理}
  \iqblayounonethird{
    % 左列（31% 宽度）
    \textbf{核心思想}：
    \begin{itemize}
      \item 步骤 1
      \item 步骤 2
      \item 步骤 3
    \end{itemize}
  }{
    % 右列（65% 宽度）
    \centering
    \includegraphics[width=0.9\textwidth]{images/method-diagram.png}

    \small
    图：方法流程示意图
  }
\end{frame}
```

**适用场景**：
- 左侧简要要点 + 右侧详细图示
- 公式说明 + 示意图

#### 1.3 非对称双列（2/3 - 1/3）

**命令**：`\iqblayouttwothirds{左列（宽）}{右列（窄）}`

**适用场景**：与 `\iqblayoutonethird` 相反

---

### 2. 三列布局

**命令**：`\iqblayoutthree{列1}{列2}{列3}`

**示例**：
```latex
\begin{frame}{三种方法比较}
  \iqblayoutthree{
    % 列 1
    \centering
    \textbf{Method A}

    \includegraphics[width=\textwidth]{images/method-a.png}

    \small
    准确率: 78\%
  }{
    % 列 2
    \centering
    \textbf{Method B}

    \includegraphics[width=\textwidth]{images/method-b.png}

    \small
    准确率: 85\%
  }{
    % 列 3
    \centering
    \textbf{Ours}

    \includegraphics[width=\textwidth]{images/ours.png}

    \small
    准确率: 92\%
  }
\end{frame}
```

**适用场景**：
- 多方法对比
- 三个并列概念
- 时间线展示（过去-现在-未来）

---

### 3. 网格布局

#### 3.1 2×2 网格

**命令**：`\iqbgridtwobytwo{图1}{图2}{图3}{图4}`

**示例**：
```latex
\begin{frame}{关键结果}
  \iqbgridtwobytwo{
    \centering
    \includegraphics[width=\textwidth]{images/fig-a.png}
    \small (A) 结构预测
  }{
    \centering
    \includegraphics[width=\textwidth]{images/fig-b.png}
    \small (B) 序列恢复
  }{
    \centering
    \includegraphics[width=\textwidth]{images/fig-c.png}
    \small (C) 结合亲和力
  }{
    \centering
    \includegraphics[width=\textwidth]{images/fig-d.png}
    \small (D) 稳定性评分
  }
\end{frame}
```

**技巧**：
- 使用 `\small` 或 `\footnotesize` 控制标题字号
- 图片大小自动适配，通常 `width=\textwidth` 即可

#### 3.2 3×2 网格

**命令**：`\iqbgridthreebytwo{图1}{图2}{图3}{图4}{图5}{图6}`

**适用场景**：
- 六个子图展示
- 时间序列（如 t=0, 10, 20, 30, 40, 50 ns）

---

### 4. 图文混排

#### 4.1 图片在左，文字在右

**命令**：`\iqbimagetext[图片选项]{图片路径}{文字内容}`

**示例**：
```latex
\begin{frame}{详细分析}
  \iqbimagetext[width=0.45\textwidth]{images/analysis.png}{
    \textbf{关键发现}：
    \begin{enumerate}
      \item 序列恢复率达 92\%
      \item RMSD < 2.0 Å（95\% 设计）
      \item 结合亲和力提高 3 倍
      \item 保持热稳定性
    \end{enumerate}

    \vspace{0.5cm}

    \textbf{意义}：\\
    这代表了对先前方法的重大改进。
  }
\end{frame}
```

#### 4.2 文字在左，图片在右

**命令**：`\iqbtextimage[图片选项]{文字内容}{图片路径}`

**使用与上述相反，文字在前，图片在后**

---

### 5. 图片命令

#### 5.1 单图 + 标题

**命令**：`\iqbfigure[图片选项]{图片路径}{标题}`

**示例**：
```latex
\begin{frame}{主要结果}
  \iqbfigure[width=0.8\textwidth]{images/main-result.png}{图 1：主要结果展示}
\end{frame}
```

#### 5.2 双图并列 + 各自标题

**命令**：`\iqbtwofigures[图片选项]{图1路径}{标题1}{图2路径}{标题2}`

**示例**：
```latex
\begin{frame}{对比分析}
  \iqbtwofigures[width=0.4\textwidth]{
    images/before.png
  }{
    (A) 处理前
  }{
    images/after.png
  }{
    (B) 处理后
  }
\end{frame}
```

---

## 🎨 Footer 设置

### 命令：`\setsection{Section名称}`

**作用**：更新 footer 中间显示的 section 名称

**示例**：
```latex
% Background 部分
\setsection{Background}
\begin{frame}{研究背景}
  ...
\end{frame}

% Methods 部分
\setsection{Methods}
\begin{frame}{研究方法}
  ...
\end{frame}

% Results 部分
\setsection{Results}
\begin{frame}{实验结果}
  ...
\end{frame}
```

**Footer 显示效果**：
```
IQB Lab          |    Background    |    3 / 15
```

**常用 section 名称**：
- `Overview` - 概述
- `Background` - 背景
- `Methods` - 方法
- `Results` - 结果
- `Discussion` - 讨论
- `Conclusion` - 结论

---

## 📏 间距控制

### 垂直间距

```latex
\vspace{0.3cm}  % 增加 0.3cm 垂直空白
\vspace{0.5cm}  % 增加 0.5cm 垂直空白
\vspace{-0.2cm} % 减少 0.2cm 垂直空白（负值）
```

### 水平间距

```latex
\hspace{1em}    % 增加 1em 水平空白
\hfill          % 填充剩余水平空间
```

---

## 🖼️ 图片处理技巧

### 1. 控制图片大小

```latex
% 宽度控制
\includegraphics[width=0.8\textwidth]{image.png}  % 页面宽度的 80%
\includegraphics[width=5cm]{image.png}             % 固定 5cm 宽

% 高度控制
\includegraphics[height=0.6\textheight]{image.png} % 页面高度的 60%
\includegraphics[height=4cm]{image.png}             % 固定 4cm 高

% 同时限制宽高（保持比例）
\includegraphics[width=0.8\textwidth,height=0.6\textheight,keepaspectratio]{image.png}

% 缩放
\includegraphics[scale=0.5]{image.png}  % 缩放到 50%
```

### 2. 确保图片不溢出

**推荐设置**：
```latex
\includegraphics[height=0.6\textheight,keepaspectratio]{image.png}
```

这样图片高度不会超过页面高度的 60%，避免溢出。

### 3. 图片路径

**相对路径**（推荐）：
```latex
\includegraphics{images/figure1.png}       % 相对于 .tex 文件
\includegraphics{../images/figure1.png}    % 上级目录的 images
```

**绝对路径**（不推荐）：
```latex
\includegraphics{/path/to/images/figure1.png}
```

### 4. 图片格式

**支持的格式**：
- PNG（推荐，无损压缩）
- PDF（推荐，矢量图）
- JPG（照片）
- EPS（矢量图，需转换）

**不支持**：
- SVG（需先转换为 PDF）

---

## 📦 实用技巧

### 1. 避免内容溢出

**每页内容限制**：
- 文字要点：不超过 6-7 个
- 图片高度：`height=0.6\textheight` 或更小
- 双列布局：每列不超过 4-5 个要点

**调试方法**：
```latex
\begin{frame}[shrink=10]{标题}  % 自动缩小 10%
  ...
\end{frame}
```

### 2. 使用 Block 环境

```latex
\begin{block}{重要结论}
  这里是需要强调的内容
\end{block}

\begin{alertblock}{警告}
  注意事项
\end{alertblock}

\begin{exampleblock}{示例}
  代码或示例
\end{exampleblock}
```

### 3. 列表环境

```latex
% 无序列表
\begin{itemize}
  \item 要点 1
  \item 要点 2
\end{itemize}

% 有序列表
\begin{enumerate}
  \item 第一步
  \item 第二步
\end{enumerate}

% 描述列表
\begin{description}
  \item[术语1] 解释 1
  \item[术语2] 解释 2
\end{description}
```

### 4. 数学公式

```latex
% 行内公式
这是行内公式 $E = mc^2$

% 独立公式
$$
\Delta G = k \cdot \text{CV}^2 + c
$$

% 对齐多行公式
\begin{align*}
  \text{CV}_{\text{cyl}} &= 1 - d/\text{CV}_{\text{eq}} \\
  \text{CV}_{\text{radius}} &= r_{\text{min}}/r_{\text{unit}}
\end{align*}
```

### 5. 表格

```latex
\begin{frame}{数据表格}
  \centering
  \begin{tabular}{lcc}
    \toprule
    \textbf{方法} & \textbf{准确率} & \textbf{速度} \\
    \midrule
    方法 A & 78\% & 快 \\
    方法 B & 85\% & 中 \\
    我们的 & 92\% & 快 \\
    \bottomrule
  \end{tabular}
\end{frame}
```

（需要 `\usepackage{booktabs}`）

---

## 🎯 完整页面示例

### 示例 1：复杂图文混排

```latex
\setsection{Results}
\begin{frame}{关键发现}
  \iqblayoutonethird{
    \textbf{观察结果}：
    \begin{enumerate}
      \item 序列恢复: 92\%
      \item RMSD < 2.0 Å
      \item 亲和力提高 3×
      \item 保持热稳定性
    \end{enumerate}

    \vspace{0.5cm}

    \textbf{意义}：\\
    这代表重大突破。

    \vspace{0.3cm}

    \begin{block}{下一步}
      验证实验中
    \end{block}
  }{
    \centering
    \includegraphics[width=0.9\textwidth,height=0.55\textheight,keepaspectratio]{images/key-result.png}

    \vspace{0.2cm}
    \small
    \textbf{图}：蛋白质设计结果对比\\
    (A) 野生型 (B) 设计型 (C) 叠加图
  }
\end{frame}
```

### 示例 2：四子图展示

```latex
\setsection{Methods}
\begin{frame}{模型架构}
  \iqbgridtwobytwo{
    \includegraphics[width=\textwidth]{images/encoder.png}
    \small\centering (A) 编码器模块
  }{
    \includegraphics[width=\textwidth]{images/attention.png}
    \small\centering (B) 注意力层
  }{
    \includegraphics[width=\textwidth]{images/decoder.png}
    \small\centering (C) 解码器模块
  }{
    \includegraphics[width=\textwidth]{images/output.png}
    \small\centering (D) 输出层
  }
\end{frame}
```

---

## 🔍 调试技巧

### 1. 显示边框（调试布局）

```latex
\usepackage{showframe}  % 在 preamble 中
```

### 2. 单页调试

```latex
\begin{frame}{调试这一页}
  ...
\end{frame}
\end{document}  % 临时结束，调试完删除
```

### 3. 检查溢出

编译后查看 log 文件中的警告：
```
Overfull \vbox (10.0pt too high)
```

---

## 📚 参考资源

- **Beamer 官方文档**: https://ctan.org/pkg/beamer
- **IQB 模板示例**: `examples/membrane-pore-jc.tex`
- **空白模板**: `template/jc-template.tex`

---

**更新时间**: 2025-10-20
**模板版本**: 1.0
