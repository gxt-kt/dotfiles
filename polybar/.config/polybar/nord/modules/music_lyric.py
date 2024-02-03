import json
import requests
import re
import sys
import common


def GetLyric():
    url = "http://127.0.0.1:27232/player"
    try:
        response = requests.get(url)
        parsed_data = json.loads(response.text)
    except requests.exceptions.RequestException as e:
        return "NO MUSIC"
    # print(response.text)
    track_id = parsed_data["currentTrack"]["id"]
    progress = parsed_data["progress"]
    # print(track_id)
    # print(progress)

    lyric_url = "http://127.0.0.1:10754/lyric?id=" + str(track_id)
    try:
        response = requests.get(lyric_url)
        parsed_data = json.loads(response.text)
    except requests.exceptions.RequestException as e:
        return "NO MUSIC"
    # 原版歌词
    # lyric = parsed_data["lrc"]["lyric"]
    lyric = parsed_data.get("lrc", {}).get("lyric", "No lyric available")
    if lyric == "No lyric available":
        return "No lyric available"
    # print(lyric)
    # 翻译歌词
    # tlyric = parsed_data["tlyric"]["lyric"]
    tlyric = parsed_data.get("tlyric", {}).get("lyric", "No translation available")
    # print(tlyric)

    def parse_lyrics(data, target_time):
        # 将文本数据解析成时间和歌词的列表
        pattern = r"\[(\d+:\d+\.\d+)\](.+)"
        parsed_data = re.findall(pattern, data)

        # 将时间转换为秒数
        def time_to_seconds(time_str):
            minutes, seconds = map(float, time_str.split(":"))
            return 60 * minutes + seconds

        # 找到与目标时间最接近的歌词
        closest_lyric = ""
        min_difference = float("inf")
        for time, lyric in parsed_data:
            current_time = time_to_seconds(time)
            difference = abs(current_time - target_time)
            if difference < min_difference:
                min_difference = difference
                closest_lyric = lyric

        return closest_lyric

    # 测试数据
    # lyric = """
    # [00:24.078]太久没有写歌我不知道怎么起笔
    # [00:27.340]寂寞的夜里我总是会想起你
    # [00:30.417]每次睡觉前总是渴望会发生奇迹
    # [00:33.253]能让我在梦里梦见你感受你的气息
    # [00:36.412]你进入我的视野来到我的心里
    # [00:39.342]你侵袭我的世界占取我的记忆
    # [00:42.078]就快要窒息那又是怎样的刺激
    # [00:45.031]你就像一只精灵
    # [00:46.605]让我怎么能忘记你的美丽
    # [00:48.358]虽然我是个烂人但是我的心也会疼
    # [00:51.222]我需要你的陪伴真的不想再一个人
    # [00:54.280]夜晚的冰冷 下降的体温
    # [00:57.251]我不想再失衡 我开始为你失魂
    # [01:00.057]我不是没有感情只是不想那么感性
    # [01:02.937]我喜欢你 如果你也能够感应
    # [01:06.052]把我想对你说的话录制成这段音频
    # [01:08.982]我已经开始迷失在这片有你的森林
    # [01:12.116]你存在我深深的脑海里
    # [01:17.488]我的梦里我的心里我的歌声里
    # [01:24.175]你存在我深深的脑海里
    # [01:29.338]我的梦里我的心里我的歌声里
    # """
    # lyric=""

    # 获取特定时间的歌词
    # progress = 60  # 例如，获取60秒时的歌词
    result = parse_lyrics(lyric, progress)
    # print(result)
    return result


if __name__ == "__main__":
    if len(sys.argv) > 1:
        if sys.argv[1] == "toggle":
            common.ToggleState("music lyric show", "true", "false")
        elif sys.argv[1] == "lyric":
            if common.GetState("music lyric show", "true") == "true":
                print(GetLyric())
            else:
                print("❱")
        else:
            print("Unknown Parameter!")
    else:
        print("Unknown Parameter!")


# import tkinter as tk
#
# class DraggableWindow:
#     def __init__(self, root):
#         self.root = root
#         self.root.title("yesplaymusic")
#
#         # 创建一个标签，用于显示文字
#         self.label = tk.Label(root, text="拖动我！", bg="lightgrey")
#         self.label.pack(pady=10)
#
#         # 绑定鼠标事件，实现窗口拖动
#         self.label.bind("<ButtonPress-1>", self.start_drag)
#         self.label.bind("<B1-Motion>", self.dragging)
#
#     def start_drag(self, event):
#         self._x = event.x
#         self._y = event.y
#
#     def dragging(self, event):
#         x = self.root.winfo_x() + event.x - self._x
#         y = self.root.winfo_y() + event.y - self._y
#         self.root.geometry("+%d+%d" % (x, y))
#
# # 创建主窗口
# root = tk.Tk()
# root.geometry("300x200")
# root.title("yesplaymusic")
#
# # 创建可拖动的浮动窗口实例
# draggable_window = DraggableWindow(root)
#
# # 运行程序
# root.mainloop()
