from pydub import AudioSegment
import numpy as np
import argparse

# 设置音频参数
sample_rate = 44100  # 采样率

# 创建命令行参数解析器
parser = argparse.ArgumentParser(
    description="Generate an mp3 audio of selectable length without sound"
)
parser.add_argument(
    "--time",
    "-t",
    type=int,
    default=1000,
    help="duration times: ms",
)
args = parser.parse_args()


duration = args.time  # 持续时间（毫秒）

# 生成空白音频数据
audio_data = np.zeros((duration * sample_rate // 1000, 2), dtype=np.int16)
audio = AudioSegment(
    audio_data.tobytes(), frame_rate=sample_rate, sample_width=2, channels=2
)


# 保存为MP3文件
audio.export("empty_" + str(duration) + "ms" + ".mp3", format="mp3")
