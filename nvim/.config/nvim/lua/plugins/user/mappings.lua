-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE
vim.g.mapleader = ","

local opts = { noremap = true, silent = true }
local keymap = vim.keymap
keymap.set("i", "jk", "<Esc>", opts)
keymap.set("n", "<leader>\\", "<C-w>v", opts)
keymap.set("n", "<leader><BS>", "<C-w>v", opts)
keymap.set("n", "<leader>-", "<C-w>s", opts)
keymap.set("n", "<C-s>", "<cmd>w<cr>", opts)
keymap.set("n", "<S-h>", "<cmd>bpre<cr>", opts)
keymap.set("n", "<S-l>", "<cmd>bnext<cr>", opts)

-- Visual --
-- Stay in indent mode
keymap.set("v", "<", "<gv", opts)
keymap.set("v", ">", ">gv", opts)
-- Move text up and down
keymap.set("v", "<A-j>", ":m .+1<CR>==", opts)
keymap.set("v", "<A-k>", ":m .-2<CR>==", opts)
-- Visual Block --
-- Move text up and down
keymap.set("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap.set("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap.set("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap.set("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

keymap.set("n", "<leader>H", "<cmd>Twilight<cr>", opts)

-- require("my_sys").DEBUG("123")

-- 支持%跳转"<>"
vim.opt.matchpairs:append "<:>"

return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        -- first key is the mode
        n = {
          -- universal
          ["<Leader>h"] = { "<cmd>nohl<cr>", desc = "<cmd>nohl", noremap = true, silent = true },
          ["<leader>W"] = { "<cmd>set wrap!<cr>", desc = "set wrap!", noremap = true, silent = true },
          -- keymap.set("n", "<leader>S", "<cmd>set invspell<cr>", opts) -- https<cmd>//vimtricks.com/p/vim-spell-check/
          ["<leader>n"] = {
            "<cmd>set relativenumber!<cr>",
            desc = "set relativenumber!",
            noremap = true,
            silent = true,
          },
          ["<leader>b<C-n>"] = { "<cmd>enew<cr>", desc = "New file", noremap = true, silent = true },
          ["q"] = { "<Nop>", desc = "disable micro", noremap = true, silent = true },

          ["<Leader>b"] = { name = "Buffers" },

          -- max current buffer
          ["<Leader>z"] = { "<cmd>MaximizerToggle<cr>", desc = "Max current buffer", noremap = true, silent = true },

          -- max current buffer
          ["<Leader>s"] = {
            "<cmd>lua require('flash').jump()<cr>",
            desc = "Max current buffer",
            noremap = true,
            silent = true,
          },

          -- smart-splists
          ["<C-e>"] = {
            "<cmd>lua require('smart-splits').start_resize_mode()<cr>",
            desc = "smart-splits",
            noremap = true,
            silent = true,
          },

          -- gitui
          ["<Leader>gg"] = {
            "<cmd>lua require('my_funcs').git_gitui_toggle()<cr>",
            desc = "gitui",
            noremap = true,
            silent = true,
          },

          -- sniprun
          ["<Leader>r"] = {
            "<cmd>%SnipRun<cr>",
            desc = "Sniprun",
            noremap = true,
            silent = true,
          },

          -- save file
          ["<leader>w"] = { "<cmd>w<cr>", desc = "Save File", noremap = true, silent = true },
          ["<C-s>"] = { "<cmd>w<cr>", desc = "Save File", noremap = true, silent = true },
          ["<Leader><C-s>"] = {
            "<cmd>lua require('my_funcs').sudo_write()<cr>",
            desc = "Write with root",
            noremap = true,
            silent = true,
          },

          -- run cmd
          ["<Leader>R"] = {
            "V<cmd>lua require('my_funcs').execute_and_print_cmd()<cr>",
            desc = "Run cmd",
            noremap = true,
            silent = true,
          },

          -- gitsigns
          ["<Leader>gj"] = {
            "<cmd>lua require('gitsigns').nav_hunk('next')<cr>",
            desc = "Hunk next",
            noremap = true,
            silent = true,
          },
          ["<Leader>gk"] = {
            "<cmd>lua require('gitsigns').nav_hunk('prev')<cr>",
            desc = "Hunk prev",
            noremap = true,
            silent = true,
          },
          ["<Leader>gr"] = {
            "<cmd>lua require('gitsigns').reset_hunk()<cr>",
            desc = "Reset hunk",
            noremap = true,
            silent = true,
          },
          ["<Leader>gR"] = {
            "<cmd>lua require('gitsigns').reset_buffer()<cr>",
            desc = "Reset buffer",
            noremap = true,
            silent = true,
          },
          ["<Leader>gp"] = {
            "<cmd>lua require('gitsigns').preview_hunk()<cr>",
            desc = "Preview Hunk",
            noremap = true,
            silent = true,
          },
          ["<Leader>gh"] = {
            function() require("gitsigns").blame_line { full = true } end,
            desc = "Blame hunk",
            noremap = true,
            silent = true,
          },
          ["<Leader>gl"] = {
            "<cmd>lua require('gitsigns').toggle_current_line_blame()<cr>",
            desc = "Blame line",
            noremap = true,
            silent = true,
          },
          ["<Leader>gd"] = {
            "<cmd>lua require('gitsigns').diffthis()<cr>",
            desc = "git diff",
            noremap = true,
            silent = true,
          },
          ["<Leader>gD"] = {
            function() require("gitsigns").diffthis "~" end,
            desc = "git diff!",
            noremap = true,
            silent = true,
          },
          ["<Leader>gt"] = {
            "<cmd>lua require('gitsigns').toggle_deleted()<cr>",
            desc = "toggle deleted",
            noremap = true,
            silent = true,
          },

          -- remove all toggle terminal keymap
          ["<F7>"] = false,
          ["<Leader>t"] = false,
          ["<Leader>tf"] = false,
          ["<Leader>th"] = false,
          ["<Leader>tv"] = false,
          ["<Leader>tl"] = false,
          ["<Leader>tn"] = false,
          ["<Leader>tp"] = false,
          ["<Leader>tt"] = false,

          -- change to tab
          ["<Leader>t"] = { name = "Tabs" },
          ["<Leader>t<C-n>"] = { "<cmd>tabnew<cr>", desc = "New tab", noremap = true, silent = true },
          ["<Leader>tn"] = { "<cmd>tabnext<cr>", desc = "New tab", noremap = true, silent = true },
          ["<Leader>tp"] = { "<cmd>tabprevious<cr>", desc = "New tab", noremap = true, silent = true },

          -- telescope
          ["<Leader>fw"] = {
            "<cmd>lua require('my_funcs').live_grep_raw({default_text = vim.fn.expand('<cword>')})<cr>",
            desc = "Find words",
            noremap = true,
            silent = true,
          },
          ["<Leader>fW"] = {
            "<cmd>lua require('my_funcs').live_grep_raw({default_text = vim.fn.expand('<cword>'),search_all=true})<cr>",
            desc = "Find all words",
            noremap = true,
            silent = true,
          },
          ["<Leader>fs"] = {
            "<cmd>lua require('my_funcs').live_grep_raw({default_text = ''})<cr>",
            desc = "Find string",
            noremap = true,
            silent = true,
          },
          ["<Leader>fS"] = {
            "<cmd>lua require('my_funcs').live_grep_raw({default_text = '',search_all=true})<cr>",
            desc = "Find all string",
            noremap = true,
            silent = true,
          },

          -- spectre
          ["sf"] = {
            "<cmd>lua require('spectre').open_file_search({select_word=false})<cr>",
            desc = "Search on current file",
            noremap = true,
            silent = true,
          },
          ["sF"] = {
            "<cmd>lua require('spectre').open_visual({select_word=false})<cr>",
            desc = "Search on whole directory",
            noremap = true,
            silent = true,
          },
          ["sw"] = {
            "<cmd>lua require('spectre').open_file_search({select_word=true})<cr>",
            desc = "Search on current file",
            noremap = true,
            silent = true,
          },
          ["sW"] = {
            "<cmd>lua require('spectre').open_visual({select_word=true})<cr>",
            desc = "Search on whole directory",
            noremap = true,
            silent = true,
          },
        },
        v = {
          -- This will not change the clipboard content in V mode
          ["p"] = { '"_dP', desc = "", noremap = true, silent = true },

          ["<Leader>R"] = {
            "<cmd>lua require('my_funcs').execute_and_print_cmd()<cr>",
            desc = "Run cmd",
            noremap = true,
            silent = true,
          },

          -- gitsigns
          ["<Leader>gr"] = {
            function() require("gitsigns").reset_hunk { vim.fn.line ".", vim.fn.line "v" } end,
            desc = "Run cmd",
            noremap = true,
            silent = true,
          },
          ["<Leader>gs"] = {
            function() require("gitsigns").stage_hunk { vim.fn.line ".", vim.fn.line "v" } end,
            desc = "Run cmd",
            noremap = true,
            silent = true,
          },

          -- sniprun
          ["<Leader>r"] = {
            "<cmd>'<,'>SnipRun<cr>",
            desc = "Sniprun",
            noremap = true,
            silent = true,
          },

          -- telescope
          ["<Leader>fw"] = {
            "<Esc><cmd>lua require('my_funcs').live_grep_raw({default_text=''}, 'v')<cr>",
            desc = "Find words",
            noremap = true,
            silent = true,
          },
          ["<Leader>fW"] = {
            "<Esc><cmd>lua require('my_funcs').live_grep_raw({default_text='',search_all=true}, 'v')<cr>",
            desc = "Find all words",
            noremap = true,
            silent = true,
          },

          -- spectre
          ["sw"] = {
            '<esc><cmd>lua require("spectre").open({ search_text=require("my_funcs").get_text("v"), path=require("my_funcs").GetBufRelativePath()})<cr>',
            desc = "Search on current file",
            noremap = true,
            silent = true,
          },
          ["sW"] = {
            '<esc><cmd>lua require("spectre").open({ search_text=require("my_funcs").get_text("v") })<cr>',
            desc = "Search on whole directory",
            noremap = true,
            silent = true,
          },
        },
        t = {
          -- setting a mapping to false will disable it
          -- ["<esc>"] = false,
          -- ["<Leader>h"] = false,
        },
      },
    },
  },
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      mappings = {
        n = {
          -- this mapping will only be set in buffers with an LSP attached
          gh = {
            function() vim.lsp.buf.hover() end,
            desc = "Hover symbol details",
          },
          ["<Leader>j"] = {
            "<cmd>ClangdSwitchSourceHeader<cr>",
            desc = "Jump between source and head file",
          },
          -- condition for only server with declaration capabilities
          gD = {
            function() vim.lsp.buf.declaration() end,
            desc = "Declaration of current symbol",
            cond = "textDocument/declaration",
          },
        },
      },
    },
  },
}
