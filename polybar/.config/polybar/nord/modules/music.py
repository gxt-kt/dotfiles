#!/usr/bin/env python

import os
import sys
import subprocess

import common

MUSIC_PROGRAM="yesplaymusic"

def GetTitle():
    cmd="echo $(dbus-send --print-reply --dest=org.mpris.MediaPlayer2."+str(MUSIC_PROGRAM)+" /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:org.mpris.MediaPlayer2.Player string:Metadata | sed -n '/title/{n;p}' "+"| cut -d '"+'"'+"' -f 2) 2>/dev/null"
    result = subprocess.run(cmd, shell=True, timeout=3, stderr=subprocess.PIPE, stdout=subprocess.PIPE)
    title=result.stdout.decode('utf-8').replace('\n','')
    title=title.replace("'","") # 解决一些歌曲带'的问题
    if(title=="") :
        title="NO MUSIC"
    # title=" "+title+" "
    return (title)

def GetPlay():
  icon=""
  cmd="echo $(dbus-send --print-reply --dest=org.mpris.MediaPlayer2."+str(MUSIC_PROGRAM)+" /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:org.mpris.MediaPlayer2.Player string:PlaybackStatus | grep -Eo '"+'"'+".*?"+'"'+"'"+ " | cut -d '"+'"'+"'"+" -f 2) 2>/dev/null"
  # print(cmd)
  result = subprocess.run(cmd, shell=True, timeout=3, stderr=subprocess.PIPE, stdout=subprocess.PIPE)
  play_status=result.stdout.decode('utf-8').replace('\n','')
  # print(play_status)
  if play_status=="Paused" : icon="⏺" # ⏹
  elif play_status=="Playing" : icon="⏸"
  else : icon="𝝢𝝤" # 
  # print(icon)
  return icon

if __name__ == "__main__":
    if len(sys.argv) > 1:
        if(sys.argv[1]=="toggle") :
            common.ToggleState('music show','true','false')
        if(sys.argv[1]=="pre") :
            os.system("playerctl previous "+"-p "+str(MUSIC_PROGRAM))
        elif (sys.argv[1]=="next") :
            os.system("playerctl next "+"-p "+str(MUSIC_PROGRAM))
        elif (sys.argv[1]=="title") :
            if(common.GetState('music show','true')=="true"):
                print(GetTitle())
            else :
                print("❱")
        elif (sys.argv[1]=="play") :
            print(GetPlay())
        elif (sys.argv[1]=="play_click") :
            os.system("playerctl play-pause "+"-p "+str(MUSIC_PROGRAM))
        else :
            print("Unknown Pparameter!")
    else :
        print("Unknown Pparameter!")
   
