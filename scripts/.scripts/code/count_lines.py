import os
import argparse
import codecs

type_lines_list={}


def count_lines(file_path):
    with codecs.open(file_path, "r", encoding="utf-8", errors="ignore") as file:  
        lines = file.readlines()
        return len(lines)


def count_code_lines(directory, recursive: bool = True, exclude_files=[],file_types=[],searchs=[]):
    total_lines = 0
    file_list = searchs if searchs else os.listdir(directory)  
    for file in file_list:
        file_path = os.path.join(directory, file)
        if ( os.path.isfile(file_path) and str(os.path.splitext(file)[-1][1:]) in file_types and file not in exclude_files):
            lines = count_lines(file_path)
            type_lines_list[str(os.path.splitext(file)[-1][1:])]=type_lines_list[str(os.path.splitext(file)[-1][1:])]+lines
            total_lines += lines
        elif os.path.isdir(file_path) and recursive:
            total_lines += count_code_lines(file_path, recursive, exclude_files, file_types, None)
    return total_lines


# 创建命令行参数解析器
parser = argparse.ArgumentParser(description="Count code lines in a directory.")
parser.add_argument("--recursive", "-r", type=str, choices=["True", "False"], default="True", help="Recursive flag",)
parser.add_argument("--searchs", "-s", nargs="*", help="List of files to count")
parser.add_argument("--type", "-t", nargs="*", help="List of file types, if not the default is py cpp cc c h hpp md")
parser.add_argument("--exclude", "-e", nargs="*", help="List of files to exclude")

# 解析命令行参数
args = parser.parse_args()


current_directory = os.getcwd()  # 获取当前脚本所在路径
recursive_str = args.recursive  # 是否递归检查子目录
recursive_check = True if args.recursive == "True" else False
exclude_files_list = args.exclude if args.exclude else []  # 要排除的文件列表，如果没有传入参数则为空列表
searchs_list = args.searchs if args.searchs else []

# check searchs_list is exist
for search_ in searchs_list :
    path = os.path.join(current_directory, search_)
    if not os.path.isdir(path) and not os.path.isfile(path):  
        print(path+" is not exist."+" Please check the '-s' parameters.")
        exit(1)

# init the file type and 
file_types = args.type if args.type else ['py','cpp','cc','c','h','hpp','md']
for file_type in file_types:
    type_lines_list[file_type]=0

total_code_lines=0 
total_code_lines = count_code_lines( current_directory, recursive_check, exclude_files_list,file_types,searchs_list)

if(total_code_lines>0):
    for item in type_lines_list :  
        count = type_lines_list[item]  
        percentage = round(count / total_code_lines * 100, 4)  
        output = "{}:\t{}\t{:.2f}%".format(item, count, percentage)  
        print(output)  
print()
print(f"Total code lines: {total_code_lines}")
