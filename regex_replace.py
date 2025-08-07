import sys
import re

def main():
    if len(sys.argv) != 4:
        print("用法: python regex_replace.py <文件名> <正则表达式> <替换字符串>")
        sys.exit(1)

    filename = sys.argv[1]
    pattern = sys.argv[2]
    replacement = sys.argv[3]

    try:
        with open(filename, 'r', encoding='utf-8') as f:
            content = f.read()
    except Exception as e:
        print(f"读取文件出错: {e}")
        sys.exit(1)

    try:
        new_content = re.sub(pattern, replacement, content, flags=re.MULTILINE)
    except re.error as e:
        print(f"正则表达式错误: {e}")
        sys.exit(1)

    try:
        with open(filename, 'w', encoding='utf-8') as f:
            f.write(new_content)
    except Exception as e:
        print(f"写入文件出错: {e}")
        sys.exit(1)

    # print(f"regex replace: \"{pattern}\" -> \"{replacement}\"")

if __name__ == "__main__":
    main()
