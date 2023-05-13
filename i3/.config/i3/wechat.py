# !/usr/bin/env python3
# -*- coding: utf-8 -*-

import i3ipc
import sys
import os

i3 = i3ipc.Connection()

def show_window(win,move=False):
    focused = i3.get_tree().find_focused().workspace().name
    win.command('focus')
    if move == True :
        win.command('move window to workspace {}'.format(focused))
        if focused != i3.get_tree().find_focused().workspace().name:
            i3.command('workspace number {}'.format(focused))


if __name__ == "__main__":
    # if(len(sys.argv)) < 3 :
    #     print("GXT_KT : error : len(sys.argv) dose not meet the requirements")
    for con in i3.get_tree():
        if con.window_title == "WeChat" :
            # show_window(con,sys.argv[1])
            show_window(con,True)
            break
    os.system("/opt/apps/com.qq.weixin.deepin/files/run.sh -w")
