# @author gxt_kt
# @date 2024-05-22
# @mail gxt_kt@163.com

import codecs
import os
import argparse


convert_cnt = 0
successful_cnt = 0


def convert_encoding(file, input_encoding, output_encoding):
    global convert_cnt, successful_cnt
    convert_cnt += 1
    print(f"[{convert_cnt}]：{file} ", end="")
    try:
        with codecs.open(file, "r", input_encoding) as f:
            try:
                content = f.read()
            except Exception as e:
                print(f"文件读取错误？也许编码本来就有问题：{e}")
                return
    except Exception as e:
        print(f"文件打开失败：{e}")
        return
    # with codecs.open(file, 'r', input_encoding) as f:
    #     content = f.read()
    with codecs.open(file, "w", output_encoding) as f:
        try:
            f.write(content)
            successful_cnt += 1
        except Exception as e:
            print(f"文件写入失败：{e}")
            return
    print(f"文件转换成功")


def convert_directory(input_path, input_encoding, output_encoding):
    if os.path.isfile(input_path):
        convert_encoding(input_path, input_encoding, output_encoding)
    elif os.path.isdir(input_path):
        for root, dirs, files in os.walk(input_path):
            for file in files:
                file_path = os.path.join(root, file)
                convert_encoding(file_path, input_encoding, output_encoding)
    else:
        print(f"未知问题，文件/文件夹 '{input_path}' 存在吗？")


parser = argparse.ArgumentParser(description="Convert file or directory encoding")
parser.add_argument("path", help="File or directory path to convert")
parser.add_argument(
    "--input_encoding", default="gbk", help="Input encoding (default: gbk)"
)
parser.add_argument(
    "--output_encoding", default="utf-8", help="Output encoding (default: utf-8)"
)

args = parser.parse_args()

if __name__ == "__main__":
    convert_directory(args.path, args.input_encoding, args.output_encoding)
    print("总计检测{}个文件，转换成功{}个", convert_cnt, successful_cnt)
