#!/usr/bin/env python3
"""
简化嵌套列表：将嵌套的 iqbitemize 环境改为 \subitem 命令
"""

import re
import sys

def simplify_nested_lists(content):
    """将嵌套的 iqbitemize 环境简化为 \subitem 命令"""

    # 匹配嵌套的 iqbitemize 环境
    pattern = r'\\begin\{iqbitemize\}\s*\n(.*?)\\end\{iqbitemize\}'

    def replace_nested(match):
        items = match.group(1)
        # 提取所有 \item 内容
        item_contents = re.findall(r'\\item\s+(.*?)(?=\\item|\s*\\end\{iqbitemize\}|$)', items, re.DOTALL)
        # 转换为 \subitem 形式
        result = '\n        '.join([f'\\subitem{{{content.strip()}}}' for content in item_contents if content.strip()])
        return '\n        ' + result + '\n'

    # 多次处理以处理多层嵌套
    for _ in range(5):
        content = re.sub(pattern, replace_nested, content, flags=re.DOTALL)

    return content

if __name__ == '__main__':
    if len(sys.argv) != 2:
        print("Usage: python3 simplify_nested_lists.py <file.tex>")
        sys.exit(1)

    input_file = sys.argv[1]

    with open(input_file, 'r', encoding='utf-8') as f:
        content = f.read()

    # 处理
    new_content = simplify_nested_lists(content)

    # 写回
    with open(input_file, 'w', encoding='utf-8') as f:
        f.write(new_content)

    print(f"已简化 {input_file} 中的嵌套列表")
