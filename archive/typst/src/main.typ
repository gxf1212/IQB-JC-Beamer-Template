// ============================================================
// IQB Journal Club 主模板
// 版本: 2.0
// 基于 Touying 0.6.1
// ============================================================

#import "@preview/touying:0.6.1": *

// 导入 IQB 自定义主题
#import "themes/iqb-theme.typ": *

// 导入所有组件
#import "components/cover.typ": *
#import "components/authors.typ": *
#import "components/layouts.typ": *
#import "components/closing.typ": *

// ============================================================
// 使用说明
// ============================================================

/*
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

// 使用组件
#jc-cover(
  title: [文献标题],
  author: [汇报人],
  date: datetime.today(),
)

#jc-authors-page(
  author1: (name: "Dr. A", affiliation: "MIT"),
  author2: (name: "Dr. B", affiliation: "Stanford"),
)

#jc-two-column(
  section: [Methods],
  subsection: [Dataset],
  [左列内容],
  [右列内容],
)

#jc-closing(
  message: [Thanks for listening!],
)
```

## 组件列表

### 封面页组件
- `jc-cover()` - 标准封面页
- `jc-cover-simple()` - 简化封面页

### 作者介绍组件
- `jc-authors-page()` - 双作者介绍（无 Journal）
- `jc-authors-page-three()` - 三作者介绍

### 布局组件
- `jc-two-column()` - 双列布局（35% 使用率）
- `jc-three-column()` - 三列布局（25% 使用率）
- `jc-four-images-layout()` - 四图不规则布局（10% 使用率）
- `jc-left-two-right-full()` - 左二右一布局
- `jc-single-wide-image()` - 单图全宽
- `jc-grid-2x2()` - 2x2 网格
- `jc-text-only()` - 纯文本页

### 致谢页组件
- `jc-closing()` - 标准致谢页
- `jc-closing-simple()` - 简化致谢页
- `jc-closing-with-contact()` - 带联系信息致谢页
- `jc-summary()` - 总结页

## 主题特性

- ✅ 全宽 header 横幅（13cm × 0.8cm）
- ✅ 优化的 footer（12pt 字号）
- ✅ 中文字体自动降级
- ✅ IQB 主题色（#003366）
- ✅ 13cm × 7cm 页面尺寸

## 快速参考

### 精确定位（13cm × 7cm 页面）
```typst
#place(
  dx: 6cm,   // 距左边 6cm
  dy: 1cm,   // 距顶部 1cm
  content
)
```

### 常用尺寸
- 全宽: 13cm
- 半宽: 6cm
- 1/3宽: 4cm
- 全高: 7cm
- 半高: 3.5cm

### 动画
```typst
#pause          // 暂停
#meanwhile      // 同时显示
#uncover("2-")  // 条件显示
```

*/
