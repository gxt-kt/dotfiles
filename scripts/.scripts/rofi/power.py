#!/usr/bin/env python

import os
import subprocess
import time

import choose

SLEEP_TIME = 0.2


def shutdown():
    time.sleep(SLEEP_TIME)  # 需要加入延时否则鼠标点击的话反应不过来，不会显示下一级菜单
    ret = choose.ChooseYesOrNo("shutdown")
    if ret == "yes":
        os.system("shutdown -h now")


def reboot():
    time.sleep(SLEEP_TIME)  # 需要加入延时否则鼠标点击的话反应不过来，不会显示下一级菜单
    ret = choose.ChooseYesOrNo("reboot")
    if ret == "yes":
        os.system("reboot")


def logout():
    time.sleep(SLEEP_TIME)  # 需要加入延时否则鼠标点击的话反应不过来，不会显示下一级菜单
    ret = choose.ChooseYesOrNo("log out")
    if ret == "yes":
        os.system("i3-msg exit")


def suspend():
    time.sleep(SLEEP_TIME)  # 需要加入延时否则鼠标点击的话反应不过来，不会显示下一级菜单
    ret = choose.ChooseYesOrNo("suspend to ram")
    if ret == "yes":
        os.system("systemctl suspend ")


def hibernate():
    time.sleep(SLEEP_TIME)  # 需要加入延时否则鼠标点击的话反应不过来，不会显示下一级菜单
    ret = choose.ChooseYesOrNo("hibernate to disk")
    if ret == "yes":
        os.system("systemctl hibernate ")


def lock():
    os.system("bash ~/.scripts/i3lock/lock.sh")


def MenuRofi():
    #      key:display information   value:function
    choose = {
        "⏻ shutdown": "shutdown",
        " reboot": "reboot",
        "󰍃 log out": "logout",
        "⏾ suspend to ram": "suspend",
        "󰒲 hibernate to disk": "hibernate",
        " lock": "lock",
    }
    cmd = "echo $(echo -e '"
    for choose_string in choose.keys():
        cmd += choose_string + "\\n"
    cmd = cmd[:-2]
    cmd += "' | rofi -dmenu -window-title '󰹯 POWER')"
    # print(cmd)
    result = subprocess.run(
        cmd, shell=True, stderr=subprocess.PIPE, stdout=subprocess.PIPE
    )
    choose_ret = result.stdout.decode("utf-8").replace("\n", "")
    # print(choose_ret)
    match_function = choose[choose_ret]
    try:
        exec(str(match_function) + "()")
    except Exception:
        pass


if __name__ == "__main__":
    MenuRofi()
