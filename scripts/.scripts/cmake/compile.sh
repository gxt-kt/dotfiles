#!/bin/bash

myecho() {
  echo -e "\033[34m$1\033[0m"
}

myecho "============================================="
myecho "-- COMPILE INFO --"
myecho "Current Path : $(pwd)"
myecho "Compile Time : $(date)"
myecho "============================================="

# 判断当前目录是否存在CMakeLists.txt文件
if [ ! -f "CMakeLists.txt" ]; then
  echo -e "\033[31m[ ERROR ] : There is no CMakeLists.txt file in current directory\033[0m"
  exit 1
fi

# 判断是否存在build目录，如果不存在就创建
if [ ! -d "build" ]; then
  if ! mkdir -p build; then
    echo -e '\033[31m[ ERROR ] : Failed Run "mkdir -p build"\033[0m'
    exit 1
  fi
  myecho ""
  myecho "============================================="
  myecho "mkdir -p build"
  myecho "============================================="
fi

# 执行cmake ..
ExecCmake() {
  myecho ""
  myecho "============================================="
  myecho "cmake -S. -Bbuild"
  myecho "============================================="
  if ! cmake -S. -Bbuild; then
    echo -e '\033[31m[ ERROR ] : Failed Run "cmake -S. -Bbuild"\033[0m'
    exit 1
  fi
}

# 执行build
ExecBuild() {
  # for macos
  if [ "$(uname)" = "Darwin" ]; then
    cpu_cores=$(sysctl -n hw.physicalcpu)  
  else
    cpu_cores=$(grep -c '^processor' /proc/cpuinfo)  
  fi
  compile_cores=$((cpu_cores - 2))
  myecho ""
  myecho "============================================="
  myecho "cmake --build build -j${compile_cores}"
  myecho "============================================="
  if ! cmake --build build -j${compile_cores}; then
    echo -e "\033[31m[ ERROR ] : Failed Run \"cmake --build build -j${compile_cores}\"\033[0m"
    exit 1
  fi
}

# 递归查找文件，返回所有符合的
find_file() {
  local path="$1"
  local file="$2"
  local found_files=()  # 用于存储匹配到的文件

  # 遍历指定路径下的所有条目
  for entry in "$path"/*; do
    if [[ -f "$entry" && "$(basename "$entry")" == "$file" ]]; then
      found_files+=("$entry")  # 添加找到的文件到数组
    elif [[ -d "$entry" ]]; then
      # 递归调用查找子目录
      local sub_found_files
      sub_found_files=$(find_file "$entry" "$file")  # 获取子目录中的文件
      found_files+=($sub_found_files)  # 将找到的文件添加到数组
    fi
  done

  # 如果找到文件，返回文件列表
  if [[ ${#found_files[@]} -gt 0 ]]; then
    echo "${found_files[@]}"
    return 0
  else
    return 1
  fi
}

# 检查文件是否存在的函数
check_file_exists() {
  local path="$1"
  if [[ -f "$path" ]]; then
    return 0
  else
    return 1
  fi
}

ExecFile() {
  if [[ -z "$1" ]]; then
    :
    # for file in *; do
    #     if [[ -x $file && ! -d $file ]]; then
    #         myecho ""
    #         myecho ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    #         myecho "Exec File Name : \033[33m$file"
    #         myecho "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
    #         # ./$file
    #         shift # 移除第一个参数
    #         ./$file $@ # 执行文件并传递剩余的参数
    #         # break # 看需求是否需要遍历所有可执行文件
    #     fi
    # done
  else
    # 在当前目录下递归查找文件
    if check_file_exists "$1"; then
      file_path=$(realpath "$1")
      shift
      myecho ""
      myecho ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
      myecho "Exec : \033[33m$file_path $@"
      myecho "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
      $file_path $@
    elif matching_files=$(find_file "$(pwd)" "$1"); then
      # 检查是否找到了文件
      if [[ -n "$matching_files" ]]; then
        shift
        # 遍历找到的文件
        for file_path in $matching_files; do
          myecho ""
          myecho ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
          myecho "Exec : \033[33m$file_path $@"
          myecho "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
          $file_path $@
        done
      else
        echo "No files found."
      fi
    else
      # echo "不存在"
      myecho ""
      myecho ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
      echo -e "\033[31m[ ERROR ] : $1 not exist\033[0m"
      myecho "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
    fi
  fi
}

# cmake+make+run
cmr() {
  ExecCmake
  ExecBuild
  ExecFile $@
}

# make+run
mr() {
  ExecBuild
  ExecFile $@
}

if [[ "$1" == "cmr" ]]; then
  shift
  cmr "$@"
elif [[ "$1" == "mr" ]]; then
  shift
  mr "$@"
else 
  cmr "$@"
fi
