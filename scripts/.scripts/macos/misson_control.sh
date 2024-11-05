#!/bin/bash

# 获取当前鼠标位置  
current_pos=$(cliclick p)

# 取出x,y坐标
x=$(echo $current_pos | awk -F, '{print $1}')
y=$(echo $current_pos | awk -F, '{print $2}')

# 使用osascript快速获取屏幕宽度  
screen_width=$(osascript -e 'tell application "Finder" to get bounds of window of desktop' | awk -F, '{print $3}')

# 移动鼠标到屏幕顶上中央位置  
cliclick m:$((screen_width-1)),0

# 打开misson control
open -a 'Mission Control'

# 延时一下
sleep 0.25
# 把鼠标移回来
cliclick m:$x,$y
