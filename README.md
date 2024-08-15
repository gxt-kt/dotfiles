# my personal dotfiles

Use `stow` to manage my dotfiles.
使用stow管理我自己的配置

## 目录结构

一般通用配置文件都在根目录，比如vim/nvim/tmux/fzf等

关于i3/polybar等archlinux专属配置，可以进入到archlinux文件夹查看


## 怎么使用

```
cd ~
git clone git@github.com:gxt-kt/dotfiles.git
cd dotfiles
stow -t ~ */
```

具体可以查看stow命令的使用，也可以自己手动软链接

If you have config file exists, there may some erros. Backup your original files and remove them. Then try `stow -t ~ */` again.

Or you can also stow single directory like `stow zsh`, this will only link the contain package data.

**Notice** 

If you stow a folder while the folder is exist. Then stow will only link the files under the folder instead of the whole folder.

It's really different and it's better to link the whole folder.

**So it's recommend to remove the whole folder before stow it.**

