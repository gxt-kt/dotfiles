# !/usr/bin/env python3
# -*- coding: utf-8 -*-

import i3ipc
import sys
import os

i3 = i3ipc.Connection()

scratchpad_user = {
    # "scratchpad":"alacritty -t scratchpad --class FloatingTerminal -e tmux",
    "scratchpad":"kitty -T scratchpad --class FloatingTerminal tmux",
    "scratchpad_term":"kitty -T scratchpad_term --class FloatingTerminal -o initial_window_width=130c -o initial_window_height=40c tmux",
    "WeChat" :"/opt/apps/com.qq.weixin.deepin/files/run.sh", # wechat with wine
    "wechat" :"wechat-universal", # wechat-universal-bwrap 
    "QQ":" ",
    "yesplaymusic":"/opt/YesPlayMusic/yesplaymusic ",
}


def find_scratchpad_window(title: str, cmd: str = ""):
    current_workspace = i3.get_tree().find_focused().workspace().name
    print("current_workspace",current_workspace)
    # print(i3.get_tree().descendants())
    for con in i3.get_tree().descendents():  
        if con.type == 'con' and con.window:  
            print("Window ID: {}".format(con.window))  
            print("Title: {}".format(con.name))  
            print("Position: ({}, {})".format(con.rect.x, con.rect.y))  
            print("Size: {}x{}".format(con.rect.width, con.rect.height))  
            print("---")  
    find = 0
    for con in i3.get_tree():
        if con.window_title == title or con.window_class == title:
            find = 1
            print(con.window_class)
            print(con.workspace().name)
            print(con.id)
            if con.workspace().name == current_workspace:
                i3.command("[con_id={}] move scratchpad".format(con.id))
            else:
                move_window_to_workspace_focus(con.id, current_workspace)
            break
    if find == 0:  # not find
        os.system(str(cmd))


def move_window_to_workspace_focus(window_id, workspace):
    i3.command("[con_id={}] move to workspace {}".format(window_id, workspace))
    i3.command("[con_id={}] focus".format(window_id))


if __name__ == "__main__":
    if (len(sys.argv)) < 2:
        print("GXT_KT : error : len(sys.argv) dose not meet the requirements")
        sys.exit()
    if sys.argv[1] in scratchpad_user:
        find_scratchpad_window(sys.argv[1], scratchpad_user[sys.argv[1]])


