-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--



local keymap = vim.keymap
keymap.set("i", "jk", "<Esc>")
keymap.set("n", "<leader>\\", "<C-w>v")
keymap.set("n", "<leader>-", "<C-w>s")

keymap.set("n", "p", '"_dP')
keymap.set("n", "<leader>q", ":bd<cr>")
keymap.set("n", "<leader>c", ":q<cr>")

-- 禁用vim中的宏
keymap.set("n", "q", "<Nop>")

-- 搜索时把结果置于中间并打开折叠
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "nzzzv")

