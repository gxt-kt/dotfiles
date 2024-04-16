import os
import argparse
import codecs
from tabulate import tabulate
import pandas as pd

type_lines_list = {}
type_directory_list = {}


# 数单个文件的行号
def count_lines(file_path):
    with codecs.open(file_path, "r", encoding="utf-8", errors="ignore") as file:  
        lines = file.readlines()
        return len(lines)


# 数一个目录中文件的行号
# 可以指定是否递归，排除的文件或目录，搜索的文件或目录，指定文件类型
def count_code_lines(directory, recursive: bool = True, search_hide = False, exclude_files=[],exclude_dirs=[],file_types=[],searchs=[]):
    total_lines = 0
    file_list = searchs if searchs else os.listdir(directory)  
    for file in file_list:
        file_path = os.path.join(directory, file)
        if (
            os.path.isfile(file_path)
            and str(os.path.splitext(file)[-1][1:]) in file_types
            and file not in exclude_files
            and (search_hide or not file.startswith('.'))
        ):
            lines = count_lines(file_path)
            type_lines_list[str(os.path.splitext(file)[-1][1:])] = type_lines_list.get(
                str(os.path.splitext(file)[-1][1:]), 0
            ) + lines

            # Track the directory with the highest occurrence for each code type
            type_directory_list[str(os.path.splitext(file)[-1][1:])] = directory

            total_lines += lines
        elif (
            os.path.isdir(file_path) 
            and recursive 
            and file not in exclude_dirs
            and (search_hide or not file.startswith('.'))
        ):
            # 排除exlude_dirs
            if any(exclude_dir in file_path for exclude_dir in exclude_dirs):
                continue
            total_lines += count_code_lines(file_path, search_hide, recursive, exclude_files, exclude_dirs, file_types, None)
    return total_lines

# 递归查找一个目录中所有的文件后缀类型
# 返回到一个列表里
def get_all_file_extensions(directory, extensions=set()):  
    for item in os.listdir(directory):  
        item_path = os.path.join(directory, item)  
        if os.path.isfile(item_path):  
            _, extension = os.path.splitext(item)  
            if extension:  
                extensions.add(extension[1:])  
        elif os.path.isdir(item_path):  
            get_all_file_extensions(item_path, extensions)  
    return list(extensions)  

# 创建命令行参数解析器
parser = argparse.ArgumentParser(description="Count code lines in a directory.")
parser.add_argument("--recursive", "-r", type=str, choices=["True", "False"], default="True", help="Recursive flag",)
parser.add_argument("--searchs", "-s", nargs="*", help="List of files to count")
parser.add_argument("--type", "-t", nargs="*", help="List of file types, if not the default is py cpp cc c h hpp md")
parser.add_argument("--exclude_files", "-e", nargs="*", help="List of files to exclude")
parser.add_argument("--exclude_dirs", "-E", nargs="*", help="List of dires to exclude")
parser.add_argument("--search_hide", "-H", action="store_true", help="search hide dirs and files")
parser.add_argument("--occur_sub_dirs", "-o", action="store_true", help="print occur most sub directory")
parser.add_argument("--all", "-a", action="store_true", help="Include all file types")

# 解析命令行参数
args = parser.parse_args()

current_directory = os.getcwd()  # 获取当前脚本所在路径
recursive_str = args.recursive  # 是否递归检查子目录
recursive_check = True if args.recursive == "True" else False
exclude_files_list = args.exclude_files if args.exclude_files else []  # 要排除的文件列表，如果没有传入参数则为空列表
exclude_dirs_list = args.exclude_dirs if args.exclude_dirs else []  # 要排除的文件夹列表，如果没有传入参数则为空列表
searchs_list = args.searchs if args.searchs else []

# check searchs_list is exist
for search_ in searchs_list:
    path = os.path.join(current_directory, search_)
    if not os.path.isdir(path) and not os.path.isfile(path):
        print(path + " is not exist." + " Please check the '-s' parameters.")
        exit(1)

# init the file type and 
file_types = args.type if args.type else ['py','cpp','cc','c','h','hpp','md']
# 如果指定了查找所有，就查找所有的文件类型
if args.all:
    file_types = get_all_file_extensions(current_directory)
for file_type in file_types:
    type_lines_list[file_type] = 0
    type_directory_list[file_type] = ""

# 是否搜索隐藏文件
search_hide=False
if args.search_hide:
    search_hide=True

total_code_lines = count_code_lines(
    current_directory, search_hide, recursive_check, exclude_files_list, exclude_dirs_list, file_types, searchs_list
)

if total_code_lines > 0:
    # 使用pandas和tabulate的版本
    # 创建 DataFrame
    df = pd.DataFrame(list(type_lines_list.items()), columns=["types", "code lines"])
    # 计算百分比
    df["percentage"] = (
        df["code lines"]/ total_code_lines * 100
    ).round(2).astype(str) + "%"
    # 按照代码行数降序排序
    df = df.sort_values(by="code lines", ascending=False)
    # 添加最多出现子目录的列
    if args.occur_sub_dirs:
        df["occur most sub directory"] = [type_directory_list[type_] for type_ in df["types"]]
    # 打印表格
    print(tabulate(df, headers="keys", tablefmt="github", showindex=False))

print()
print(f"Total code lines: {total_code_lines}")
