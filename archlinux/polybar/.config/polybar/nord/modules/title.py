#!/usr/bin/env python

import os
import sys

import i3ipc
import yaml

import common


LENGTH = 20


def is_non_english_character(character):
    return character.isalpha() and not character.isascii()


def get_string_length(input_string):
    sum = 0
    for c in input_string:
        if is_non_english_character(c) == True:
            sum += 2
        else:
            sum += 1
    return sum


def ProcessString(s):
    length = get_string_length(s)
    if length > LENGTH:
        return s[: LENGTH - 3] + "..."
    elif length < LENGTH:
        return s + " " * (LENGTH - length)
    else:
        return s


def slice_string(input_string):
    sliced_string = input_string
    while get_string_length(sliced_string) > LENGTH:
        sliced_string = sliced_string[:-1]
    return ProcessString(sliced_string)


def Geti3wmTitle():
    i3 = i3ipc.Connection()
    focused = i3.get_tree().find_focused()
    title = focused.window_title
    if focused is None or focused.window_title is None:
        title = " "
    return slice_string(title)


if __name__ == "__main__":
    if len(sys.argv) > 1:
        if sys.argv[1] == "toggle":
            common.ToggleState("title show", "true", "false")
        elif sys.argv[1] == "title":
            if common.GetState("title show", "true") == "true":
                print(Geti3wmTitle())
            else:
                print("❱")
