-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE
vim.g.mapleader = ","

local opts = { noremap = true, silent = true }
local keymap = vim.keymap
keymap.set("i", "jk", "<Esc>")
keymap.set("n", "<leader>\\", "<C-w>v")
keymap.set("n", "<leader><BS>", "<C-w>v")
keymap.set("n", "<leader>-", "<C-w>s")
keymap.set("n", "<C-s>", ":w<cr>")
keymap.set("n", "<S-h>", ":bnext<CR>")
keymap.set("n", "<S-l>", ":bpre<CR>")
keymap.set("n", "<leader>w", ":w<cr>")


keymap.set("n", "<leader>h", ":nohl<cr>")
keymap.set("n", "<leader>H", ":Twilight<cr>")
keymap.set("n", "<leader>W", ":set wrap!<cr>")
keymap.set("n", "<leader>S", ":set invspell<cr>") -- https://vimtricks.com/p/vim-spell-check/
keymap.set("n", "<leader>n", ":set relativenumber!<cr>")
keymap.set("n", "<leader>j", ":ClangdSwitchSourceHeader<cr>")

-- vim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

-- require("my_sys").DEBUG("123")

return {

}
