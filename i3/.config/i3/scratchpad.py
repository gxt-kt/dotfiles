# !/usr/bin/env python3
# -*- coding: utf-8 -*-

import i3ipc
import os

i3 = i3ipc.Connection()

def find_scratchpad_window(i3):
    current_workspace = i3.get_tree().find_focused().workspace().name
    find = 0
    for con in i3.get_tree():
        if con.window_title == "scratchpad":
            find = 1
            print("scratchpad")
            print(con.window_class)
            print(con.workspace().name)
            print(con.id)
            if con.workspace().name == current_workspace:
                i3.command("[con_id={}] move scratchpad".format(con.id))
            else:
                move_window_to_workspace_focus(i3, con.id, current_workspace)
            break
    if find == 0: # not find
        os.system("alacritty -t scratchpad --class floatingTerminal")

        # else :
        #     print("no")
        # print(con.window_title)
    # for workspace in i3.get_workspaces():
    #     scratchpad = next((window for window in workspace.nodes if window.name == 'scratchpad'), None)
    #     if scratchpad:
    #         return scratchpad


def move_window_to_workspace_focus(i3, window_id, workspace):
    i3.command("[con_id={}] move to workspace {}".format(window_id, workspace))
    i3.command("[con_id={}] focus".format(window_id))

if __name__ == "__main__":
    find_scratchpad_window(i3)
