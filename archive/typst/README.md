# IQB Journal Club Touying Template

**专业的学术文献汇报幻灯片模板**

基于 [Touying](https://touying-typ.github.io/) · 为 IQB 课题组定制

---

## 项目简介

本项目为 IQB 课题组的 Journal Club 文献汇报提供了一套完整的 Typst/Touying 幻灯片模板系统。基于对 56 页历史 JC 幻灯片的深度分析，实现了所有常用布局模式，并提供可复用的组件化设计。

### 核心特性

- 纯文本编辑：`.typ` 格式，支持版本控制和 LLM 辅助生成
- 专业视觉：全宽 header 横幅，优化的 footer
- 精确布局控制：像素级定位，支持复杂的不规则布局
- 组件化设计：4 大类可复用组件（封面、作者、布局、致谢）
- 中文支持：自动降级字体列表，确保中文正常显示
- 快速编译：秒级生成 PDF，增量编译

---

## 快速开始

### 1. 安装 Typst

```bash
# Ubuntu/Debian
sudo snap install typst

# macOS
brew install typst

# Windows
winget install --id Typst.Typst

# 验证安装
typst --version
```

### 2. 克隆项目

```bash
git clone https://github.com/your-org/IQB-JC-master.git
cd IQB-JC-master
```

### 3. 编译示例

```bash
# 编译演示 JC
typst compile --root . examples/demo-jc.typ examples/output/demo-jc.pdf

# 或使用 watch 模式（自动重新编译）
typst watch --root . examples/demo-jc.typ examples/output/demo-jc.pdf
```

---

## 基本用法

```typst
#import "src/main.typ": *

// 应用 IQB 主题
#show: iqb-theme.with(
  aspect-ratio: "16-9",
  config-info(
    title: [你的文献标题],
    author: [你的名字],
    date: datetime.today(),
    institution: [IQB Lab],
  ),
)

// 封面页
#jc-cover(
  title: [文献标题],
  author: [汇报人],
  date: datetime.today(),
)

// 双列布局
#jc-two-column(
  section: [Methods],
  [左列内容],
  [右列内容],
)

// 致谢页
#jc-closing(
  message: [Thanks for listening!],
)
```

---

## 可用组件

### 封面页组件
- `jc-cover()` - 标准封面页
- `jc-cover-simple()` - 简化封面页

### 作者介绍组件
- `jc-authors-page()` - 双作者介绍
- `jc-authors-page-three()` - 三作者介绍

### 布局组件
- `jc-two-column()` - 双列布局
- `jc-three-column()` - 三列布局
- `jc-four-images-layout()` - 四图不规则布局
- `jc-left-two-right-full()` - 左二右一布局
- `jc-single-wide-image()` - 单图全宽
- `jc-grid-2x2()` - 2×2 网格
- `jc-text-only()` - 纯文本页

### 致谢页组件
- `jc-closing()` - 标准致谢页
- `jc-closing-simple()` - 简化致谢页
- `jc-closing-with-contact()` - 带联系信息致谢页
- `jc-summary()` - 总结页

---

## 常用命令

```bash
# 单次编译
typst compile --root . your-jc.typ output/your-jc.pdf

# 自动编译（推荐）
typst watch --root . your-jc.typ output/your-jc.pdf
```

---

## 文档资源

详细使用指南请参阅 `docs/` 目录：

- [完整使用指南](docs/USER_GUIDE.md) - 详细的组件参数、布局技巧、自定义配置
- [快速参考](docs/QUICK_REFERENCE.md) - 常用语法速查表
- [常见问题](docs/FAQ.md) - 常见问题解答

外部资源：
- [Touying 官方文档](https://touying-typ.github.io/)
- [Typst 官方文档](https://typst.app/docs/)

---

## 项目结构

```
IQB-JC-master/
├── src/                   # 核心模板和组件
│   ├── main.typ           # 主模板入口
│   ├── components/        # 可复用组件
│   └── themes/            # 自定义主题
├── examples/              # 完整示例
├── assets/                # 静态资源
├── docs/                  # 详细文档
└── tools/                 # 开发工具
```

---

## 许可证

本项目基于 [MIT License](LICENSE) 开源。

---

**如有问题或建议，欢迎联系 IQB Lab**
