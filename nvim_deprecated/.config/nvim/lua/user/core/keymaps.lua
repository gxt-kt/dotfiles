local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

vim.g.mapleader = ","
local keymap = vim.keymap
keymap.set("i","jj","<Esc>")  
keymap.set("n","<leader>v","<C-w>v") -- split
keymap.set("n","<leader>h","<C-w>h") -- split
keymap.set("n","<leader>w",":w<cr>")


--keymap.set("n","<leader>q",":quit<cr>")


-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap.set("n", "<C-h>", "<C-w>h")
keymap.set("n", "<C-j>", "<C-w>j")
keymap.set("n", "<C-k>", "<C-w>k")
keymap.set("n", "<C-l>", "<C-w>l")

-- Resize with arrows
keymap.set("n", "<C-Up>", ":resize +2<CR>")
keymap.set("n", "<C-Down>", ":resize -2<CR>")
keymap.set("n", "<C-Left>", ":vertical resize -2<CR>")
keymap.set("n", "<C-Right>", ":vertical resize +2<CR>")

-- Navigate buffers
keymap.set("n", "<S-l>", ":bnext<CR>")
keymap.set("n", "<S-h>", ":bprevious<CR>")

-- Visual --
-- Stay in indent mode
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

-- Move text up and down
keymap.set("v", "<A-j>", ":m .+1<CR>==")
keymap.set("v", "<A-k>",":m .-2<CR>==")

-- This will not change the clipboard content in V mode
keymap.set("v", "p", '"_dP')

-- Visual Block --
-- Move text up and down
keymap.set("x", "J", ":move '>+1<CR>gv-gv")
keymap.set("x", "K", ":move '<-2<CR>gv-gv")
keymap.set("x", "<A-j>", ":move '>+1<CR>gv-gv")
keymap.set("x", "<A-k>", ":move '<-2<CR>gv-gv")

-- Terminal --
-- Better terminal navigation
keymap.set("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap.set("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap.set("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap.set("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

--------------------------------
-- plugins keymaps
--------------------------------

-- NvimTree
keymap.set("n","<leader>e",":NvimTreeToggle<cr>")


-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags
keymap.set("n", "<leader>lds", "<cmd>Telescope lsp_document_symbols<cr>") -- list all functions/structs/classes/modules in the current buffer

-- telescope git commands
keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>") -- list all git commits (use <cr> to checkout) ["gc" for git commits]
keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>") -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>") -- list git branches (use <cr> to checkout) ["gb" for git branch]
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>") -- list current changes per file with diff preview ["gs" for git status]

-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>") -- toggle split window maximization

-- hop cmd
--keymap.set("n", "<leader>hw", ":HopWord<cr>")
--keymap.set("n", "<leader>hww", ":HopWordMW<cr>")
keymap.set("n", "ss", ":HopChar2<cr>")
keymap.set("n", "sm", ":HopChar2MW<cr>")
--keymap.set("n", "<leader>hl", ":HopLine<cr>")
--keymap.set("n", "<leader>hls", ":HopLineStart<cr>")

--------------------------------
-- format code
--------------------------------
keymap.set("v", "=", "=")
keymap.set("n", "=", "gg=G")

