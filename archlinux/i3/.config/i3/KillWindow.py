#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import i3ipc
import sys
import os

i3 = i3ipc.Connection()

# kill not able kill
kill_disable_kill = [
    # "tmux", # now use kitty will ask when open tmux
]

kill_user = {
    "scratchpad": "move scratchpad",
    "WeChat": "move scratchpad",
    "QQ": "move scratchpad",
}


def KillWindow():
    # 获取当前窗口
    current_window = i3.get_tree().find_focused()
    # 获取当前窗口的名称
    current_window_name = current_window.name
    # print(current_window_name)
    # 检查当前窗口名称是否在列表中
    if current_window_name in kill_disable_kill:
        os.system(
            "notify-send '"
            + str(current_window_name)
            + "\nKillclient protected!\nPlease use forcekill'"
        )
    elif current_window_name in kill_user:
        i3.command(kill_user[current_window_name])
        pass
    else:
        i3.command("kill")


if __name__ == "__main__":
    if(len(sys.argv)) < 2 :
        print("GXT_KT : error : len(sys.argv) dose not meet the requirements")
    if(sys.argv[1]=="forcekill") :
        os.system("xdotool getwindowfocus windowkill")
    else :
        KillWindow(*sys.argv[2:])
