# !/usr/bin/env python3
# -*- coding: utf-8 -*-

import i3ipc
import sys
import os

i3 = i3ipc.Connection()

scratchpad_user = {
    # "scratchpad":"alacritty -t scratchpad --class FloatingTerminal -e tmux",
    "scratchpad":"kitty -T scratchpad --class FloatingTerminal tmux",
    "WeChat" :"/opt/apps/com.qq.weixin.deepin/files/run.sh",
    "QQ":" ",
}


def find_scratchpad_window(title: str, cmd: str = ""):
    current_workspace = i3.get_tree().find_focused().workspace().name
    find = 0
    for con in i3.get_tree():
        if con.window_title == title:
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


