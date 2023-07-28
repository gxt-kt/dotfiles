# my personal dotfiles

Use `stow` to manage my dotfiles.


## How to use

```
cd ~
git clone git@github.com:gxt-kt/dotfiles.git
cd dotfiles
stow -t ~ */
```

If you have config file exists, there may some erros. Backup your original files and remove them. Then try `stow -t ~ */` again.

Or you can also stow single directory like `stow zsh`, this will only link the contain package data.

**Notice** 

If you stow a folder while the folder is exist. Then stow will only link the files under the folder instead of the whole folder.

It's really different and it's better to link the whole folder.

**So it's recommend to remove the whole folder before stow it.**

