import os
import argparse
import codecs


def count_lines(file_path):
    with codecs.open(file_path, "r", encoding="utf-8", errors="ignore") as file:  
        lines = file.readlines()
        return len(lines)


def count_code_lines(directory, recursive: bool = True, exclude_files=[],file_types=[]):
    total_lines = 0
    for file in os.listdir(directory):
        file_path = os.path.join(directory, file)
        if ( os.path.isfile(file_path) and (file.endswith(tuple(file_types)) or file.endswith(tuple("." + t for t in file_types))) and file not in exclude_files):
            lines = count_lines(file_path)
            total_lines += lines
        elif os.path.isdir(file_path) and recursive:
            total_lines += count_code_lines(file_path, recursive, exclude_files, file_types)
    return total_lines


def count_specific_code_lines(directory,searchs=[],exclude_files=[],file_types=[]):
    total_lines = 0
    for file in searchs:
        file_path = os.path.join(directory, file)
        if ( os.path.isfile(file_path) and (file.endswith(tuple(file_types)) or file.endswith(tuple("." + t for t in file_types)) ) and file not in exclude_files):
            lines = count_lines(file_path)
            total_lines += lines
        elif os.path.isdir(file_path) :
            total_lines += count_code_lines(file_path, True, exclude_files, file_types)
    return total_lines


# 创建命令行参数解析器
parser = argparse.ArgumentParser(description="Count code lines in a directory.")
parser.add_argument("--searchs", "-s", nargs="*", help="List of files to count")
parser.add_argument("--type", "-t", nargs="*", help="List of file types, if not the default is py cpp cc c h hpp")
parser.add_argument( "--recursive", "-r", type=str, choices=["True", "False"], default="True", help="Recursive flag",)
parser.add_argument("--exclude", "-e", nargs="*", help="List of files to exclude")

# 解析命令行参数
args = parser.parse_args()


current_directory = os.getcwd()  # 获取当前脚本所在路径
recursive_str = args.recursive  # 是否递归检查子目录
recursive_check = True if args.recursive == "True" else False
exclude_files_list = args.exclude if args.exclude else []  # 要排除的文件列表，如果没有传入参数则为空列表
searchs_list = args.searchs if args.searchs else []
file_types = args.type if args.type else ['py','.cpp','.cc','c','.h','.hpp']
total_code_lines=0
if searchs_list:
    total_code_lines = count_specific_code_lines( current_directory, searchs_list, exclude_files_list,file_types)
else :
    total_code_lines = count_code_lines( current_directory, recursive_check, exclude_files_list,file_types)
print(f"Total code lines: {total_code_lines}")
