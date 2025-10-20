#!/usr/bin/env python3
"""
图片布局分析工具
分析指定文件夹中所有图片的尺寸和宽高比，推荐合适的Beamer布局方案
"""

import os
import sys
from pathlib import Path
from PIL import Image
from typing import List, Tuple, Dict

def get_aspect_ratio(width: int, height: int) -> float:
    """计算宽高比"""
    return width / height if height > 0 else 0

def classify_orientation(aspect_ratio: float) -> str:
    """根据宽高比分类图片方向"""
    if aspect_ratio > 1.3:
        return "横向 (Landscape)"
    elif aspect_ratio < 0.75:
        return "竖向 (Portrait)"
    else:
        return "方形 (Square)"

def recommend_layout(aspect_ratio: float, orientation: str) -> str:
    """根据图片特征推荐Beamer布局"""
    if orientation == "横向 (Landscape)":
        if aspect_ratio > 2.0:
            return "\\iqbfig (单图，全宽)"
        else:
            return "\\iqblayoutonethird (1/3文字+2/3图) 或 \\iqbfig"
    elif orientation == "竖向 (Portrait)":
        return "\\iqblayouttwo (图在左，文字在右) 或 \\iqblayoutonethird"
    else:  # Square
        return "\\iqbfig 或 \\iqblayouttwo"

def analyze_images(folder_path: str) -> List[Dict]:
    """分析文件夹中所有图片"""
    folder = Path(folder_path)
    if not folder.exists():
        print(f"❌ 错误：文件夹不存在: {folder_path}")
        sys.exit(1)

    # 支持的图片格式
    image_extensions = {'.png', '.jpg', '.jpeg', '.pdf', '.svg', '.webp'}

    results = []
    for img_file in sorted(folder.iterdir()):
        if img_file.suffix.lower() not in image_extensions:
            continue

        # PDF文件跳过PIL处理（需要特殊处理）
        if img_file.suffix.lower() == '.pdf':
            results.append({
                'filename': img_file.name,
                'width': 'N/A',
                'height': 'N/A',
                'aspect_ratio': 'N/A',
                'orientation': 'PDF (需手动检查)',
                'layout': '使用 pdfinfo 或手动查看',
                'size_kb': img_file.stat().st_size / 1024
            })
            continue

        try:
            with Image.open(img_file) as img:
                width, height = img.size
                aspect_ratio = get_aspect_ratio(width, height)
                orientation = classify_orientation(aspect_ratio)
                layout = recommend_layout(aspect_ratio, orientation)

                results.append({
                    'filename': img_file.name,
                    'width': width,
                    'height': height,
                    'aspect_ratio': aspect_ratio,
                    'orientation': orientation,
                    'layout': layout,
                    'size_kb': img_file.stat().st_size / 1024
                })
        except Exception as e:
            print(f"⚠️  无法读取 {img_file.name}: {e}")

    return results

def print_report(results: List[Dict], folder_path: str):
    """打印格式化的分析报告"""
    print("\n" + "="*80)
    print(f"📊 图片布局分析报告")
    print(f"📁 文件夹: {folder_path}")
    print(f"🖼️  总计: {len(results)} 张图片")
    print("="*80 + "\n")

    # 按宽高比分组统计
    landscape = sum(1 for r in results if isinstance(r['aspect_ratio'], float) and r['aspect_ratio'] > 1.3)
    portrait = sum(1 for r in results if isinstance(r['aspect_ratio'], float) and r['aspect_ratio'] < 0.75)
    square = sum(1 for r in results if isinstance(r['aspect_ratio'], float) and 0.75 <= r['aspect_ratio'] <= 1.3)

    print(f"📈 方向分布:")
    print(f"  • 横向图片: {landscape} 张")
    print(f"  • 竖向图片: {portrait} 张")
    print(f"  • 方形图片: {square} 张")
    print(f"  • 其他/PDF: {len(results) - landscape - portrait - square} 个\n")

    # 详细列表
    print("📋 详细信息:\n")
    print(f"{'文件名':<30} {'尺寸':<15} {'宽高比':<8} {'方向':<18} {'推荐布局':<25} {'大小(KB)':<10}")
    print("-" * 130)

    for r in results:
        if isinstance(r['width'], int):
            size_str = f"{r['width']}×{r['height']}"
            ratio_str = f"{r['aspect_ratio']:.2f}"
        else:
            size_str = "N/A"
            ratio_str = "N/A"

        # 颜色标记（简化版，终端支持的话）
        orientation = r['orientation']
        if "Portrait" in orientation:
            orientation = f"🔴 {orientation}"
        elif "Landscape" in orientation:
            orientation = f"🟢 {orientation}"

        print(f"{r['filename']:<30} {size_str:<15} {ratio_str:<8} {orientation:<25} {r['layout']:<35} {r['size_kb']:<10.1f}")

    print("\n" + "="*80)
    print("💡 布局建议:")
    print("  🟢 横向图 (ratio > 1.3): 适合 \\iqbfig 或 \\iqblayoutonethird")
    print("  🔴 竖向图 (ratio < 0.75): 建议 \\iqblayouttwo (图左文字右)")
    print("  🟡 方形图 (0.75-1.3): 灵活，\\iqbfig 或 \\iqblayouttwo 均可")
    print("="*80 + "\n")

    # 特别关注竖向图片
    portrait_imgs = [r for r in results if isinstance(r['aspect_ratio'], float) and r['aspect_ratio'] < 0.75]
    if portrait_imgs:
        print("⚠️  需要特别注意的竖向图片（建议使用横向布局）:")
        for r in portrait_imgs:
            print(f"  • {r['filename']}: {r['width']}×{r['height']} (ratio={r['aspect_ratio']:.2f})")
        print()

def main():
    if len(sys.argv) < 2:
        print("用法: python analyze_image_layout.py <图片文件夹路径>")
        print("示例: python analyze_image_layout.py examples/images/membrane-pore-jc")
        sys.exit(1)

    folder_path = sys.argv[1]
    results = analyze_images(folder_path)

    if not results:
        print(f"⚠️  未找到任何图片文件在: {folder_path}")
        sys.exit(0)

    print_report(results, folder_path)

if __name__ == "__main__":
    main()
