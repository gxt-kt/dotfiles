import curses
import pyfiglet
import time


# Ref:
# https://www.programcreek.com/python/example/96391/pyfiglet.figlet_format
# CMD_FIG = {"slant": "slant", "3D": "3-d", "5line": "5lineoblique", "alpha": "alphabet", "banner": "banner3-D", "doh": "doh", "iso": "isometric1", "letter": "letters", "allig": "alligator", "dotm": "dotmatrix", "bubble": "bubble", "bulb": "bulbhead", "digi": "digital"}
CMD_FIG = [
    "3-d",
    "standard",
    "slant",
    "5lineoblique",
    "alphabet",
    "banner3-D",
    # "doh",
    # "isometric1",
    "letters",
    "alligator",
    # "dotmatrix",
    "bubble",
    "bulbhead",
    "digital",
]


def convert_to_ascii_art(text, font):
    ascii_art = pyfiglet.figlet_format(text, font=font, width=100)
    lines = ascii_art.split("\n")
    return lines


def print_centered_text(window, lines, color_pair):
    terminal_height, terminal_width = window.getmaxyx()

    # 计算文本在终端中居中显示所需的行和列位置
    row = (terminal_height - len(lines)) // 2

    # 打印居中文本
    for line in lines:
        # 计算每行文本的列位置
        col = (terminal_width - len(line)) // 2

        # 设置颜色
        window.attron(color_pair)

        # 打印文本
        window.addstr(row, col, line)

        # 更新行位置
        row += 1

    # 刷新终端显示
    window.refresh()


def main(stdscr):
    # 初始化curses
    curses.curs_set(0)
    stdscr.nodelay(1)
    stdscr.timeout(100)

    # 创建颜色对
    curses.start_color()
    curses.init_pair(1, curses.COLOR_BLUE, curses.COLOR_BLACK)
    curses.init_pair(2, curses.COLOR_RED, curses.COLOR_BLACK)
    curses.init_pair(3, curses.COLOR_YELLOW, curses.COLOR_BLACK)
    curses.init_pair(4, curses.COLOR_GREEN, curses.COLOR_BLACK)
    curses.init_pair(5, curses.COLOR_MAGENTA, curses.COLOR_BLACK)
    curses.init_pair(6, curses.COLOR_CYAN, curses.COLOR_BLACK)
    curses.init_pair(7, curses.COLOR_WHITE, curses.COLOR_BLACK)

    # 设置颜色选项
    color_options = [curses.color_pair(1), curses.color_pair(2)
                     , curses.color_pair(3)
                     , curses.color_pair(4)
                     , curses.color_pair(5)
                     , curses.color_pair(6)
                     , curses.color_pair(7)
                     ]
    current_color_index = 0

    # 设置字体大小选项
    font_sizes = [40, 60, 80]
    current_font_size_index = 1

    # 设置多行文本
    text_lines = ["  W E L C O M E  \n\n  g x t   k t  "]

    # 设置艺术字字体
    font = CMD_FIG[0]
    font_index = 0

    # 循环监听键盘输入
    while True:
        # 将文本转换为艺术字
        ascii_art_lines = [convert_to_ascii_art(line, font) for line in text_lines]

        # 清空终端
        stdscr.clear()

        # 获取当前颜色选项和字体大小选项
        current_color = color_options[current_color_index]
        current_font_size = font_sizes[current_font_size_index]

        # 打印居中文本
        for lines in ascii_art_lines:
            print_centered_text(stdscr, lines, current_color)

        start_time = time.time()  
        while True:
            # 获取键盘输入
            key = stdscr.getch()

            # 根据键盘输入切换颜色选项和字体大小选项
            if key == ord("q"):
                exit(1)
            elif key == curses.KEY_RIGHT:
                font_index = (font_index + 1) % len(CMD_FIG)
                font = CMD_FIG[font_index]
                break
            elif key == curses.KEY_LEFT:
                font_index = (font_index - 1) % len(CMD_FIG)
                font = CMD_FIG[font_index]
                break
            elif key == curses.KEY_UP:
                current_color_index = (current_color_index - 1) % len(color_options)
                break
            elif key == curses.KEY_DOWN:
                current_color_index = (current_color_index + 1) % len(color_options)
                break

            current_time = time.time()  
            elapsed_time = current_time - start_time  
            time.sleep(0.02)
          
            if elapsed_time >= 1.5:  
                break
        current_color_index = (current_color_index + 1) % len(color_options)
            # time.sleep(1)


if __name__ == "__main__":
    curses.wrapper(main)
