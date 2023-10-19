from gtts import gTTS
import os
import sys
# import time
# import subprocess
from pydub import AudioSegment
import argparse
import tempfile
import random




# 创建命令行参数解析器
parser = argparse.ArgumentParser(description="Generate an mp3 audio from words")
parser.add_argument(
    "--repeat",
    "-r",
    type=int,
    default=3,
    help="repeat times",
)
parser.add_argument(
    "--time",
    "-t",
    type=int,
    default=1000,
    choices=[250, 500, 1000, 1500, 2000, 3000],
    help="interval times: ms",
)
parser.add_argument(
    "--file",
    "-f",
    type=str,
    default="words.txt",
    help="input file",
)
parser.add_argument(
    "--output_file",
    "-o",
    type=str,
    default="",
    help="output file",
)
parser.add_argument(
    "--random",
    action="store_true",
    default=False,
    help="random words",
)
args = parser.parse_args()

interval = args.time
file_path = args.file
output_file_path = args.output_file
repeats = args.repeat
random_flag = args.random
# print("random_flag",random_flag)


# 读取单词列表
def read_word_list(file_path):
    word_list = []
    with open(file_path, "r") as file:
        for line in file:
            word = line.strip()
            if word:
                word_list.append(word)
    return word_list


# 将单词列表写入文件
def write_word_list(file_path, word_list):
    with open(file_path, "w") as file:
        for word in word_list:
            file.write(word + "\n")

def generate_mp3_from_words(
    word_lists, generate_file_name, repeats_times, interval_file
):
    temp_file_path = tempfile.mktemp(suffix=".mp3")
    audio = AudioSegment.from_file(interval_file, format="mp3")
    audio_interval = AudioSegment.from_file(interval_file, format="mp3")
    for word in word_lists:
        tts = gTTS(text=word, lang="en")
        tts.save(temp_file_path)
        for _ in range(repeats_times):
            print(word)
            audio_word = AudioSegment.from_file(temp_file_path, format="mp3")
            audio += audio_word + audio_interval

    print(">>>>>>>>>>>>>>>>>>>>>END<<<<<<<<<<<<<<<<<<<<<")
    # 导出拼接后的音频为MP3文件
    print("generating "+generate_file_name+" ...")
    audio.export(generate_file_name, format="mp3")
    print("generating "+generate_file_name+" completely")

  
print("Because this script use gtts with google translate")
print("It's better to set proxy before start this scipt")
print(">>>>>>>>>>>>>>>>>>>>BEGIN<<<<<<<<<<<<<<<<<<<<")

word_lists = read_word_list(file_path)
if random_flag == True:
    random.shuffle(word_lists)
    base_name = os.path.basename(file_path)
    write_word_list(os.path.splitext(base_name)[0]+"_random"+".txt", word_lists)  
    if output_file_path=="":
        output_file_path = os.path.splitext(base_name)[0] + "_random" ".mp3"

if output_file_path=="":
    base_name = os.path.basename(file_path)
    output_file_path = os.path.splitext(base_name)[0] + ".mp3"

script_path = os.path.abspath(sys.argv[0])
script_directory = os.path.dirname(script_path)
interval_file = script_directory + "/empty_" + str(interval) + "ms" + ".mp3"
# print("interval_file",interval_file)

generate_mp3_from_words(word_lists, output_file_path, repeats, interval_file)
