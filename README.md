# my personal dotfiles

Use `stow` to manage my dotfiles.


## How to use

```
cd ~

git clone git@github.com:gxt-kt/dotfiles.git

cd dotfiles

stow .

stow *
```

If you have config file exists, there may some erros. Backup your original files and remove them. Then try `stow *` again.

Or you can also stow single directory like `stow zsh`, this will only link the files under zsh.

