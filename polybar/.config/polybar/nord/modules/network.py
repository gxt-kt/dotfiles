#!/usr/bin/env python

import os
import sys
import subprocess


def get_speed(val:int)->str:
  ret="0"
  if(val<1024) :
    ret="{:^8}".format(str(val)+"B")
  elif val<1048576 :
    ret="{:^8}".format("{:.1f}".format(val/1024)+"KB")
  else :
    ret="{:^8}".format("{:.1f}".format(val/1048576)+"MB")
  return ret

def GetRx()->str:
    rx_bytes_cur=0
    cmd="cat /sys/class/net/[ew]*/statistics/rx_bytes"
    result = subprocess.run(cmd, shell=True, timeout=3, stderr=subprocess.PIPE, stdout=subprocess.PIPE)
    rx_bytes_string=result.stdout.decode('utf-8')
    for rx in rx_bytes_string.splitlines():
      rx_bytes_cur+=int(rx)
    TX_POSITON="~/.cache/rx_bytes"
    if (os.path.exists(TX_POSITON)==False):
      os.system("touch "+TX_POSITON)
    cmd="cat "+TX_POSITON
    result = subprocess.run(cmd, shell=True, timeout=3, stderr=subprocess.PIPE, stdout=subprocess.PIPE)
    rx_bytes_pre=result.stdout.decode('utf-8').replace("\n","")
    rx_bytes=0
    if rx_bytes_pre!="":
        rx_bytes=abs(int(rx_bytes_cur)-int(rx_bytes_pre))
    # write new rx_bytes_cur
    cmd="echo "+str(rx_bytes_cur)+" > "+TX_POSITON
    os.system(cmd)
    recv_string=str(get_speed(rx_bytes))
    return (recv_string)

def GetTx()->str:
    tx_bytes_cur=0
    cmd="cat /sys/class/net/[ew]*/statistics/tx_bytes"
    result = subprocess.run(cmd, shell=True, timeout=3, stderr=subprocess.PIPE, stdout=subprocess.PIPE)
    tx_bytes_string=result.stdout.decode('utf-8')
    for tx in tx_bytes_string.splitlines():
      tx_bytes_cur+=int(tx)
    TX_POSITON="~/.cache/tx_bytes"
    if (os.path.exists(TX_POSITON)==False):
      os.system("touch "+TX_POSITON)
    cmd="cat "+TX_POSITON
    result = subprocess.run(cmd, shell=True, timeout=3, stderr=subprocess.PIPE, stdout=subprocess.PIPE)
    tx_bytes_pre=result.stdout.decode('utf-8').replace("\n","")
    tx_bytes=0
    if tx_bytes_pre!="":
        tx_bytes=abs(int(tx_bytes_cur)-int(tx_bytes_pre))
    # write new tx_bytes_cur
    cmd="echo "+str(tx_bytes_cur)+" > "+TX_POSITON
    os.system(cmd)
    send_string=str(get_speed(tx_bytes))
    return (send_string)

def GetDynamic(convert=False):
    DYNAMIC_POSITON="~/.cache/network_dynamic_flag"
    if (os.path.exists(DYNAMIC_POSITON)==False): 
        os.system("touch "+DYNAMIC_POSITON)
    cmd="cat "+DYNAMIC_POSITON
    result = subprocess.run(cmd, shell=True, timeout=3, stderr=subprocess.PIPE, stdout=subprocess.PIPE)
    tx_or_rx=result.stdout.decode('utf-8').replace("\n","")
    if tx_or_rx=="TX":
        if convert==True:
            cmd="echo "+"RX"+" > "+DYNAMIC_POSITON
            os.system(cmd)
            print(GetRx())
        else :
            print(GetTx())
    elif tx_or_rx=="RX":
        if convert==True:
            cmd="echo "+"TX"+" > "+DYNAMIC_POSITON
            os.system(cmd)
            print(GetTx())
        else :
            print(GetRx())
    else :
        cmd="echo "+"RX"+" > "+DYNAMIC_POSITON
        os.system(cmd)
        print(GetRx())

if __name__ == "__main__":
  if len(sys.argv) > 1:
    if(sys.argv[1]=="TX") :
        print(GetTx())
    elif (sys.argv[1]=="RX") :
        print(GetRx())
    elif (sys.argv[1]=="DYNAMIC") :
        GetDynamic(convert=False)
    elif (sys.argv[1]=="DYNAMIC_CONVERT") :
        GetDynamic(convert=True)
    else :
        print("Unknown Pparameter!")
   
