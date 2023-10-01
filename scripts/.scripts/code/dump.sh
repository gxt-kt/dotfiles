#!/bin/bash

# 检测是否为帮助选项
if [[ $1 == "-h" || $1 == "--help" ]]; then
    # echo "用法: bash ./script.sh [选项] [参数]"
    echo "how to use: bash ./dump.sh [file] [param(opt)]"
    echo "example: bash ./dump.sh test.cc"
    echo "example: bash ./dump.sh src/test.cc -lpthread"
    echo "example: bash ./dump.sh src/test.cc -lpthread -Iinclude"
    exit 0
fi

# 获取输入文件的路径和文件名
filepath=$1
# echo "filepath: ${filepath}"
filename=$(basename "$filepath")
# echo "filename: ${filename}"
extension="${filename##*.}"
# echo "extension: ${extension}"
filename="${filename%.*}"
# echo "filename: ${filename}"

# 判断当前文件是否为已经g++后的文件，适用于cmake工程
# 检查文件扩展名是否为 .o 
if [ "$extension" == "o" ]; then  
    # 递归搜索当前目录下的 .o 文件，并对其执行 objdump  
    found_files=$(find . -name "$filename.o")  
    if [ -z "$found_files" ]; then  
        echo -e "\033[31mcannot find file: $filename.o\033[0m"  
        exit 1  
    fi  
    for file in $found_files; do  
        objdump -d "$file" > "$filename.txt"  
        echo -e "\033[32mobjdump $file successfully\033[0m"  
        echo -e "\033[32mgenerate file $filename.txt\033[0m"  
    done  
    exit 0  
fi  

# 提取额外参数
shift
extra_args="$@"

echo "extra_args ${extra_args}"

# 编译源文件
g++ $extra_args -o "$filename.out" "$filepath"

# 检查编译是否成功
if [ $? -ne 0 ]; then
    # echo "编译失败"
    exit 1
fi

# 反汇编生成的可执行文件
objdump -d "$filename.out" > "$filename.txt"


echo -e "\033[32mg++ and objdump exec successfully\033[0m"
