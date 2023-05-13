#!/usr/bin/env python

import os
import subprocess
import tkinter as tk
from tkinter import messagebox

def show_dialog():
    result = messagebox.askyesno("对话框", "选择是或否?")
    if result == True:
        print("您选择了'是'")
    else:
        print("您选择了'否'")

def center_window(window):
    window.update_idletasks()
    width = window.winfo_width()
    height = window.winfo_height()
    x = (window.winfo_screenwidth() // 2) - (width // 2)
    y = (window.winfo_screenheight() // 2) - (height // 2)
    window.geometry(f"{width}x{height}+{x}+{y}")

def shutdown():
  os.system("shutdown -h now")
def reboot():
  os.system("reboot")
def logout():
  os.system("i3-msg exit")
def suspend():
  os.system("systemctl suspend ")
def hibernate():
  os.system("systemctl hibernate ")
def lock():
  os.system("bash ~/.scripts/i3lock/lock.sh")

def MenuRofi() :
    #      key:display information   value:function
    choose={"⏻ Shutdown":"shutdown",
            " Reboot":"reboot",
            "󰍃 Log out":"logout",
            "⏾ Suspend to ram":"suspend",
            "󰒲 Hibernate to disk":"hibernate",
            " Lock":"lock",
            }
    cmd="echo $(echo -e '"
    for choose_string in choose.keys():
      cmd+=choose_string+"\\n"
    cmd=cmd[:-2]
    cmd+="' | rofi -dmenu -window-title Power)"
    # print(cmd)
    result = subprocess.run(cmd, shell=True, stderr=subprocess.PIPE, stdout=subprocess.PIPE)
    choose_ret=result.stdout.decode('utf-8').replace("\n","")
    # print(choose_ret)
    match_function=choose[choose_ret]
    try:
      exec(str(match_function)+"()")
    except Exception:
      pass

if __name__ == "__main__":
    MenuRofi()
