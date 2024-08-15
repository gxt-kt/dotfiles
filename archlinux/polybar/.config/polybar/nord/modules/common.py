import os
import yaml

FILE_PATH = "~/.cache/polybar_title.yaml"
FILE_PATH = os.path.expanduser(FILE_PATH)

def GetState(key:str,default:str="")->str:
    if (os.path.exists(str(FILE_PATH))==False):
        os.system("touch "+str(FILE_PATH))
    with open(FILE_PATH, 'r') as f:
        data = yaml.safe_load(f)
    # 文件为空
    if not data:
        data = {}
    if key not in data:
        data[key] = default 
        with open(FILE_PATH, 'w') as f:
            yaml.dump(data, f)
    else:
        return data[key]

def ToggleState(key:str,value1:str,value2:str):
    if (os.path.exists(str(FILE_PATH))==False):
        os.system("touch "+str(FILE_PATH))
    with open(FILE_PATH, 'r') as f:
        data = yaml.safe_load(f)
    # 文件为空
    if not data:
        data = {}
    if key not in data:
        data[key] = value1
    else:
        if data[key] == value1:
            data[key] = value2
        else:
            data[key] = value1
    with open(FILE_PATH, 'w') as f:
        yaml.dump(data, f)
