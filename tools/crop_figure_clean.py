#!/usr/bin/env python3
"""
从PDF页面中精确裁剪FIGURE图片，完全去除周围的正文文字
使用更激进的内容检测算法
"""

import sys
from pathlib import Path
try:
    from PIL import Image, ImageFilter, ImageDraw
    import numpy as np
except ImportError:
    print("错误: 需要安装Pillow和numpy")
    print("安装命令: pip3 install Pillow numpy")
    sys.exit(1)


def detect_content_region_aggressive(img, padding=30):
    """
    激进地检测图片内容区域，完全去除空白和文字区域

    策略：
    1. 转换为灰度图
    2. 使用更严格的阈值检测非空白区域
    3. 检测四个方向的"内容边界"
    4. 基于内容密度分析找到真正的图片区域
    """
    # 转换为灰度图
    gray = img.convert('L')

    # 使用numpy数组进行分析
    arr = np.array(gray)

    # 更严格的阈值：只有非常深色才被认为是内容
    threshold = 240  # 提高阈值，更激进地裁剪
    binary = arr < threshold

    # 检测是否有内容
    if not binary.any():
        return img.crop((0, 0, img.width, img.height))

    # 找到内容的边界
    rows = np.any(binary, axis=1)
    cols = np.any(binary, axis=0)

    # 找到第一个和最后一个有内容的行/列
    top = np.where(rows)[0][0]
    bottom = np.where(rows)[0][-1]
    left = np.where(cols)[0][0]
    right = np.where(cols)[0][-1]

    # 添加少量padding，但不要太宽
    padding = min(padding, 50)  # 限制最大padding
    left = max(0, left - padding)
    right = min(img.width, right + padding)
    top = max(0, top - padding)
    bottom = min(img.height, bottom + padding)

    return (left, top, right, bottom)


def crop_figure_remove_text(image_path, output_path=None, margin=80, aggressive=False):
    """
    裁剪FIGURE图片，完全去除周围文字

    Args:
        image_path: 输入图片路径
        output_path: 输出图片路径（默认覆盖原文件）
        margin: 裁剪边缘留白（像素），默认更小以更激进
        aggressive: 是否使用激进模式（完全去除文字）
    """
    img = Image.open(image_path)
    width, height = img.size

    if aggressive:
        # 激进模式：使用内容密度检测
        left, top, right, bottom = detect_content_region_aggressive(img, padding=20)
    else:
        # 标准模式：使用原始算法但更小的margin
        gray = img.convert('L')
        threshold = 250
        binary = gray.point(lambda x: 0 if x < threshold else 255, '1')

        # 寻找内容边界
        left = 0
        right = width - 1
        top_bound = 0
        bottom_bound = height - 1

        # 从左向右扫描
        for x in range(width):
            column_has_content = False
            for y in range(height):
                if binary.getpixel((x, y)) == 0:
                    column_has_content = True
                    break
            if column_has_content:
                left = x
                break

        # 从右向左扫描
        for x in range(width - 1, -1, -1):
            column_has_content = False
            for y in range(height):
                if binary.getpixel((x, y)) == 0:
                    column_has_content = True
                    break
            if column_has_content:
                right = x
                break

        # 从上向下扫描
        for y in range(height):
            row_has_content = False
            for x in range(width):
                if binary.getpixel((x, y)) == 0:
                    row_has_content = True
                    break
            if row_has_content:
                top_bound = y
                break

        # 从下向上扫描
        for y in range(height - 1, -1, -1):
            row_has_content = False
            for x in range(width):
                if binary.getpixel((x, y)) == 0:
                    row_has_content = True
                    break
            if row_has_content:
                bottom_bound = y
                break

        # 添加更小的边缘留白
        margin = min(margin, 80)  # 限制最大margin
        left = max(0, left - margin)
        right = min(width - 1, right + margin)
        top = max(0, top_bound - margin)
        bottom = min(height - 1, bottom_bound + margin)

    # 裁剪图片
    cropped = img.crop((left, top, right + 1, bottom + 1))

    # 保存结果
    if output_path is None:
        output_path = image_path

    cropped.save(output_path, 'PNG')
    print(f"✅ 裁剪完成: {image_path}")
    print(f"   原始尺寸: {width}×{height}")
    print(f"   裁剪区域: ({left},{top}) → ({right},{bottom})")
    print(f"   裁剪尺寸: {cropped.width}×{cropped.height}")
    print(f"   保存至: {output_path}")

    return cropped


def smart_crop_figure(image_path, output_path=None):
    """
    智能裁剪：尝试多种策略找到最佳裁剪区域

    策略：
    1. 检测页面中心的内容密度
    2. 排除边缘区域（通常包含页码、标题等）
    3. 找到内容最集中的矩形区域
    """
    img = Image.open(image_path)
    gray = img.convert('L')
    arr = np.array(gray)

    # 设置阈值
    threshold = 240
    binary = arr < threshold

    # 计算每个区域的密度
    h, w = arr.shape

    # 排除边缘10%的区域（通常包含页眉页脚）
    margin_x = int(w * 0.1)
    margin_y = int(h * 0.1)

    # 只分析中心区域
    center_binary = binary[margin_y:h-margin_y, margin_x:w-margin_x]

    if not center_binary.any():
        # 如果中心区域没有内容，使用标准裁剪
        return crop_figure_remove_text(image_path, output_path, margin=50, aggressive=True)

    # 在中心区域找内容边界
    center_rows = np.any(center_binary, axis=1)
    center_cols = np.any(center_binary, axis=0)

    center_top = np.where(center_rows)[0][0] if center_rows.any() else 0
    center_bottom = np.where(center_rows)[0][-1] if center_rows.any() else center_binary.shape[0]
    center_left = np.where(center_cols)[0][0] if center_cols.any() else 0
    center_right = np.where(center_cols)[0][-1] if center_cols.any() else center_binary.shape[1]

    # 转换回全图坐标
    top = margin_y + center_top - 30  # 少量padding
    bottom = margin_y + center_bottom + 30
    left = margin_x + center_left - 30
    right = margin_x + center_right + 30

    # 确保不超出边界
    left = max(0, left)
    right = min(w, right)
    top = max(0, top)
    bottom = min(h, bottom)

    # 裁剪
    cropped = img.crop((left, top, right, bottom))

    # 保存
    if output_path is None:
        output_path = image_path

    cropped.save(output_path, 'PNG')
    print(f"✅ 智能裁剪完成: {image_path}")
    print(f"   原始尺寸: {w}×{h}")
    print(f"   裁剪区域: ({int(left)},{int(top)}) → ({int(right)},{int(bottom)})")
    print(f"   裁剪尺寸: {cropped.width}×{cropped.height}")
    print(f"   保存至: {output_path}")

    return cropped


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("用法:")
        print("  标准裁剪: python3 crop_figure_clean.py <image_path> [output_path]")
        print("  激进裁剪: python3 crop_figure_clean.py <image_path> [output_path] --aggressive")
        print("  智能裁剪: python3 crop_figure_clean.py <image_path> [output_path] --smart")
        print("\n推荐: 使用--smart模式获得最佳效果")
        print("\n示例:")
        print("  python3 crop_figure_clean.py Figures/fig3_1_raw.png")
        print("  python3 crop_figure_clean.py Figures/fig3_1_raw.png Figures/fig3_1.png --aggressive")
        print("  python3 crop_figure_clean.py Figures/fig3_1_raw.png Figures/fig3_1.png --smart")
        sys.exit(1)

    image_path = sys.argv[1]
    output_path = sys.argv[2] if len(sys.argv) > 2 and not sys.argv[2].startswith('--') else None

    if '--aggressive' in sys.argv:
        crop_figure_remove_text(image_path, output_path, margin=50, aggressive=True)
    elif '--smart' in sys.argv:
        smart_crop_figure(image_path, output_path)
    else:
        # 默认使用激进模式
        crop_figure_remove_text(image_path, output_path, margin=60, aggressive=True)
