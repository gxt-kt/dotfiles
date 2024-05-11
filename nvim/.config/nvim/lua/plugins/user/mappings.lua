-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE
vim.g.mapleader = ","

local opts = { noremap = true, silent = true }
local keymap = vim.keymap
keymap.set("i", "jk", "<Esc>", opts)
keymap.set("n", "<leader>\\", "<C-w>v", opts)
keymap.set("n", "<leader><BS>", "<C-w>v", opts)
keymap.set("n", "<leader>-", "<C-w>s", opts)
keymap.set("n", "<C-s>", ":w<cr>", opts)
keymap.set("n", "<S-h>", ":bnext<CR>", opts)
keymap.set("n", "<S-l>", ":bpre<CR>", opts)


keymap.set("n", "<leader>h", ":nohl<cr>", opts)
keymap.set("n", "<leader>H", ":Twilight<cr>", opts)
keymap.set("n", "<leader>W", ":set wrap!<cr>", opts)
keymap.set("n", "<leader>S", ":set invspell<cr>", opts) -- https://vimtricks.com/p/vim-spell-check/
keymap.set("n", "<leader>n", ":set relativenumber!<cr>", opts)



-- vim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

-- require("my_sys").DEBUG("123")

return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        -- first key is the mode
        n = {
          ["<Leader>b"] = { name = "Buffers" },
          ["<Leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab", noremap = true, silent = true },

          -- gitui
          ["<Leader>gg"] = { "require('my_funcs').git_gitui_toggle()", desc = "gitui", noremap = true, silent = true },

          -- save file
          ["<leader>w"] = { ":w<cr>", desc = "Save File", noremap = true, silent = true },
          ["<C-s>"] = { ":w<cr>", desc = "Save File", noremap = true, silent = true },
          ["<Leader><C-s>"] = { ":lua require('my_funcs').sudo_write()<CR>", desc = "Write with root", noremap = true, silent = true },

          -- run cmd
          ["<Leader>R"] = { "V:lua require('my_funcs').execute_and_print_cmd()<cr>", desc = "Run cmd", noremap = true, silent = true },

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
        },
        v = {
          ["<Leader>R"] = { ":lua require('my_funcs').execute_and_print_cmd()<cr>", desc = "Run cmd", noremap = true, silent = true },
        },
        t = {
          -- setting a mapping to false will disable it
          -- ["<esc>"] = false,
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
            function()
              vim.lsp.buf.hover()
            end,
            desc = "Hover symbol details",
          },
          ["<Leader>j"] = {
            ":ClangdSwitchSourceHeader<cr>",
            desc = "Jump between source and head file",
          },
          -- condition for only server with declaration capabilities
          gD = {
            function()
              vim.lsp.buf.declaration()
            end,
            desc = "Declaration of current symbol",
            cond = "textDocument/declaration",
          },
        },
      },
    },
  },
}
