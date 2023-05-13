#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import i3ipc
import sys

i3 = i3ipc.Connection()

def OpenApplicationIfThereIsNoOpen(application:str,command:str,workspace:str="-1"):
    if(workspace=="-1") : workspace=i3.get_tree().find_focused().workspace().name
    find_application=0
    for con in i3.get_tree():
        if con.window and con.parent.type != "dockarea":
            # print(
            #     "id = {} class = {} name = {} workspace = {}".format(
            #         con.window, con.window_class, con.name, con.workspace().name
            #     )
            # )
            if (con.workspace().name==workspace and con.window_class==str(application)) :
                find_application=1
                break
    if find_application==0:
        i3.command("exec --no-startup-id "+str(command))
    else :
        pass


if __name__ == "__main__":
    if(len(sys.argv)) < 3 :
        print("GXT_KT : error : len(sys.argv) dose not meet the requirements")
    OpenApplicationIfThereIsNoOpen(*sys.argv[1:])
