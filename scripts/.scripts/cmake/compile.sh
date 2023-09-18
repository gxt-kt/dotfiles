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
  if ! mkdir build; then
    echo -e '\033[31m[ ERROR ] : Failed Run "mkdir build"\033[0m'
    exit 1
  fi
  myecho ""
  myecho "============================================="
  myecho "mkdir build"
  myecho "============================================="
fi

# 进入build目录
if ! cd build; then
  echo -e '\033[31m[ ERROR ] : Failed Run "cd build"\033[0m'
  exit 1
fi


# 执行cmake ..
ExecCmake() {
  myecho ""
  myecho "============================================="
  myecho "cmake .."
  myecho "============================================="
  if ! cmake ..; then
    echo -e '\033[31m[ ERROR ] : Failed Run "cmake .."\033[0m'
    exit 1
  fi
}

# 执行build
ExecBuild() {
  myecho ""
  myecho "============================================="
  myecho "make"
  myecho "============================================="
  cpu_cores=$(grep -c '^processor' /proc/cpuinfo)  
  if ! make -j${cpu_cores}; then
    echo -e '\033[31m[ ERROR ] : Failed Run "make"\033[0m'
    exit 1
  fi
}

# 递归查找文件并执行
find_file() {
  local path="$1"
  local file="$2"
  for entry in "$path"/*; do
    if [[ -f "$entry" && "$(basename "$entry")" == "$file" ]]; then
      # echo "找到文件: $entry"
      myecho ""
      myecho ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
      myecho "Exec File Name : \033[33m$file"
      myecho "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
      shift 2 # 移除参数 $1 和 $2
      "$entry" "$@" # 执行文件并传递剩余的参数
      # "$entry" # exec file
      return 0
    elif [[ -d "$entry" ]]; then
      if find_file "$entry" "$file"; then
        return 0
      fi
    fi
  done
  return 1
}

ExecFile() {
  if [[ -z "$1" ]]; then
    for file in *; do
        if [[ -x $file && ! -d $file ]]; then
            myecho ""
            myecho ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
            myecho "Exec File Name : \033[33m$file"
            myecho "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
            # ./$file
            shift # 移除第一个参数
            ./$file $@ # 执行文件并传递剩余的参数
            # break # 看需求是否需要遍历所有可执行文件
        fi
    done
  else
    # 在当前目录下递归查找文件
    # if find_file "$(pwd)" "$1"; then
    if find_file "$(pwd)" "$@"; then
      # echo "存在"
      :
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
  # ExecFile "$1"
  ExecFile $@
}

# make+run
mr() {
  ExecBuild
  # ExecFile "$1"
  ExecFile $@
  # echo $@
}

if [[ "$1" == "cmr" ]]; then
  # cmr "$2"
  shift # 移除第一个参数
  cmr "$@"
elif [[ "$1" == "mr" ]]; then
  shift # 移除第一个参数
  mr "$@"
  # mr "$2"
else 
  # cmr
  cmr "$@"
fi

