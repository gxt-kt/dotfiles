--[[
lvim is the global options object
Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]


local home = os.getenv("HOME")
-- package.path = home .. "/.dotfiles/lvim/?.lua"
package.path = "/home/gxt_kt/.config/lvim/?.lua;"

-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
-- general
lvim.log.level = "warn"
lvim.format_on_save.enabled = false -- lvim.colorscheme = "lunar"
-- themes: https://vimcolorschemes.com/
-- lvim.colorscheme = "gruvbox"
-- lvim.colorscheme = "onedarker"
lvim.colorscheme = "tokyonight-storm"

--
--
--   'kaicataldo/material.vim',
--[[ lvim.colorscheme = "material"
-- let g:material_theme_style = 'default' | 'palenight' | 'ocean' | 'lighter' | 'darker' | 'default-community' | 'palenight-community' | 'ocean-community' | 'lighter-community' | 'darker-community'
vim.g.material_theme_style = 'palenight'
vim.g.material_terminal_italics = 1 ]]
--
-- 'marko-cerovac/material.nvim',
-- lvim.colorscheme = "material"
-- vim.g.material_style = "palenight"
-- lvim.builtin.lualine.options.theme = "auto"
-- lvim.builtin.lualine.options.theme = "material-nvim"
-- lvim.builtin.lualine.options.theme="material-stealth"
--

-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

--  options fold from treesitter
do
  vim.opt.foldlevel = 99
  vim.opt.foldmethod = "expr"
  vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
end

vim.opt.relativenumber = true -- set relative numbered lines
vim.opt.colorcolumn = "80"

vim.opt.signcolumn = "yes:2"


-- This will not change the clipboard content in V mode
lvim.keys.visual_mode["p"] = '"_dP'

lvim.leader                          = ","
lvim.keys.insert_mode["jj"]          = "<Esc>"
lvim.keys.normal_mode["<leader>\\"]  = "<C-w>v"
lvim.keys.normal_mode["<leader>-"]   = "<C-w>s"
lvim.keys.normal_mode["<C-s>"]       = ":w<cr>"
lvim.keys.normal_mode["<S-h>"]       = false -- default combine to ^
lvim.keys.normal_mode["<S-h>"]       = ":BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["<S-l>"]       = false -- default combine to $
lvim.keys.normal_mode["<S-l>"]       = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["H"] = "^"
-- lvim.keys.normal_mode["L"] = "$"
-- lvim.keys.normal_mode["Q"] = "q"
lvim.keys.normal_mode["<leader>h"]   = ":nohl<cr>"
lvim.keys.normal_mode["<leader>j"]   = ":ClangdSwitchSourceHeader<cr>"
lvim.builtin.which_key.mappings.o    = nil
lvim.builtin.which_key.mappings["o"] = {
  name = "+outline",
  s = { "<cmd>SymbolsOutline <cr>", "Outline" },
  v = { "<cmd>Vista!! <cr>", "Vista" },
  h = { "<cmd>ClangdTypeHierarchy<cr>", "Hierarchy" },
}
-- lvim.keys.normal_mode["<leader>os"] = "<cmd> SymbolsOutline"
-- lvim.keys.normal_mode["<leader>ov"] = ":Vista!!<cr>"
lvim.keys.normal_mode["<leader>q"]   = ":bd<cr>"
lvim.keys.normal_mode["<leader>c"]   = ":q<cr>"
-- 暂时还不懂这个映射是干嘛，什么都没做？
lvim.keys.normal_mode["q"]           = "<Nop>"
-- 搜索时把结果置于中间并打开折叠
lvim.keys.normal_mode["n"]           = "nzzzv"
lvim.keys.normal_mode["N"]           = "Nzzzv"
-- 让下一行加到当前行末尾，删掉所有缩进，并加一个空格
lvim.keys.normal_mode["J"]           = "mzJ`z"
-- lvim.keys.visual_mode["p"] = "P"
-- lvim.keys.visual_mode["H"] = "^"
-- lvim.keys.visual_mode["L"] = "$"
-- lvim.keys.visual_mode["J"] = ":m '>+1<CR>gv=gv"
-- lvim.keys.visual_mode["K"] = ":m '<-2<CR>gv=gv"

-- maximal keymap
---- toggle split window maximization
lvim.keys.normal_mode["<leader>z"] = ":MaximizerToggle<CR>"

-- Markdown-preview keymap
lvim.keys.normal_mode["<leader>md"] = ":MarkdownPreview<CR>"

-- cmp配置修改
-- lvim.builtin.cmp.confirm_opts.select=true
lvim.builtin.cmp.completion = { -- 修改默认就选择第一条
  completeopt = 'menu,menuone,noinsert'
}
-- 修改tab为替换，<CR>默认就是直接插入了
lvim.builtin.cmp.mapping["<Tab>"] = require("cmp").mapping {
  i = require("cmp").mapping.confirm { behavior = require("cmp").ConfirmBehavior.Replace, select = true },
  c = function(fallback)
    if require("cmp").visible() then
      require("cmp").confirm { behavior = require("cmp").ConfirmBehavior.Replace, select = true }
    else
      fallback()
    end
  end,
}
-- lvim.builtin.cmp.mapping["<Tab>"]= require("cmp").mapping(function(fallback)
--         if require("cmp").visible() then
--           local confirm_opts = vim.deepcopy(lvim.builtin.cmp.confirm_opts) -- avoid mutating the original opts below
--           local is_insert_mode = function()
--             return vim.api.nvim_get_mode().mode:sub(1, 1) == "i"
--           end
--           if is_insert_mode() then -- prevent overwriting brackets
--             confirm_opts.behavior = require("cmp").ConfirmBehavior.Insert
--           end
--           if require("cmp").confirm(confirm_opts) then
--             return -- success, exit early
--           end
--         end
--         fallback() -- if not exited early, always fallback
--       end)

-- lsp
lvim.keys.normal_mode["<leader>in"] = ":lua vim.lsp.buf.incoming_calls()<cr>"
lvim.keys.visual_mode["<leader>lf"] = "<ESC><cmd>lua vim.lsp.buf.range_formatting()<CR>"
lvim.builtin.which_key.mappings["la"] = { ":CodeActionMenu<CR>", "My code action" }


-- spectre
-- open in current file
lvim.keys.normal_mode["sf"] = ":lua require('spectre').open_file_search()<CR>"
-- open in whole ws
lvim.keys.normal_mode["sF"] = ":lua require('spectre').open()<CR>"

-- SnipRun
lvim.keys.normal_mode["<leader>r"] = ":%SnipRun<CR>"
lvim.keys.visual_mode["<leader>r"] = ":'<,'>SnipRun<CR>"

-- Use which-key to add extra bindings with the leader-key prefix
-- orverwirte old 's'
lvim.builtin.which_key.mappings.f     = nil
lvim.builtin.which_key.mappings.s     = nil
--lvim.keys.normal_mode["<leader>fe"] = ":lua require('my_funcs').live_grep_raw({default_text =''})<cr>"
lvim.builtin.which_key.mappings["fy"] = { "<cmd>Telescope neoclip<cr>", "Find clipboard" }
lvim.builtin.which_key.mappings["ff"] = { ":lua require('lvim.core.telescope.custom-finders').find_project_files()<cr>",
  "Find file" }
lvim.builtin.which_key.mappings["fs"] = { ":lua require('telescope.builtin').live_grep()<cr>", "Find string" }
lvim.builtin.which_key.mappings["fp"] = { "<cmd>Telescope projects<CR>", "Recent projects" }
lvim.builtin.which_key.mappings["fr"] = { ":Telescope oldfiles<cr>", "Recent files" }
lvim.builtin.which_key.mappings["fk"] = { "<cmd>Telescope keymaps<cr>", "Show all keymaps" }
-- 原作者自己的
lvim.keys.visual_mode["<leader>fw"]   = "<Esc>:lua require('my_funcs').live_grep_raw({}, 'v')<cr>"
lvim.keys.normal_mode["<leader>fw"]   = ":lua require('my_funcs').live_grep_raw({default_text = vim.fn.expand('<cword>')})<cr>"
lvim.keys.normal_mode["<leader>fd"]   = ":lua require('my_funcs').live_grep_raw({default_text =  '-g' .. vim.fn.fnamemodify(vim.fn.expand('%'), ':.:h') .. '/*' .. ' ' .. vim.fn.expand('<cword>')})<cr>"

lvim.keys.normal_mode["<leader>s"] = ":lua require('telescope.builtin').lsp_document_symbols()<cr>"
lvim.keys.normal_mode["<leader>S"] = ":lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<cr>"


-- hop
do
  vim.keymap.set('', 'f', function()
    require('hop').hint_char1({ direction = require('hop.hint').HintDirection.AFTER_CURSOR, current_line_only = true })
  end, { remap = true })
  vim.keymap.set('', 'F', function()
    require('hop').hint_char1({ direction = require('hop.hint').BEFORE_CURSOR, current_line_only = true })
  end, { remap = true })
  vim.keymap.set('', 't', function()
    require('hop').hint_char1({ direction = require('hop.hint').AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
  end, { remap = true })
  vim.keymap.set('', 'T', function()
    require('hop').hint_char1({ direction = require('hop.hint').BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
  end, { remap = true })
  -- lvim.keys.normal_mode["f"] = "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>"
  -- lvim.keys.normal_mode["F"] = "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>"
  lvim.keys.normal_mode["ss"] = "<cmd>HopChar2<cr>"
  lvim.keys.normal_mode["sS"] = "<cmd>HopChar2MW<cr>"
end


-- auto pairs
lvim.builtin.autopairs.disable_filetype = { "TelescopePrompt", "spectre_panel", "repl" }

-- dap
lvim.keys.normal_mode["<F12>"] = ":Telescope dap configurations<cr>"
-- lvim.keys.normal_mode["d"] = false
-- lvim.lsp.buffer_mappings.normal_mode['d'] = nil
-- lvim.builtin.which_key.mappings.d= nil
-- lvim.keys.normal_mode["dt"] = "<cmd>lua require'dap'.toggle_breakpoint()<cr>"
-- lvim.builtin.which_key.mappings["db"] = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" }
-- lvim.builtin.which_key.mappings.d = {
--   name = "Debug",
--   h = { "<cmd>lua require'dap.ui.widgets'.hover()<cr>", "Hover Variables" },
--   x = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
--   t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
--   b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
--   c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
--   C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
--   d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
--   g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
--   i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
--   o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
--   u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
--   p = { "<cmd>lua require'dap'.pause()<cr>", "Pause" },
--   r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
--   s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
--   q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
--   U = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
-- }

-- unmap a default keymapping
-- vim.keymap.del("n", "q")
-- override a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
  -- for input mode
  i = {
    -- ["<C-j>"] = actions.move_selection_next,
    -- ["<C-k>"] = actions.move_selection_previous,
    ["<C-j>"] = actions.cycle_history_next,
    ["<C-k>"] = actions.cycle_history_prev,
    -- ["<C-n>"] = actions.cycle_history_next,
    -- ["<C-p>"] = actions.cycle_history_prev,
    ["<C-n>"] = actions.move_selection_next,
    ["<C-p>"] = actions.move_selection_previous,
  },
  -- for normal mode
  n = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
    ["<C-n>"] = actions.move_selection_next,
    ["<C-p>"] = actions.move_selection_previous,
  },
}

-- Change theme settings
-- lvim.builtin.theme.options.dim_inactive = true
-- lvim.builtin.theme.options.style = "storm"


lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  -- l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  l = { "<cmd>TroubleToggle loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
  t = { "<cmd>TodoTrouble<cr>", "Todo" },
}

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"

lvim.builtin.terminal.active = true
lvim.builtin.terminal.execs = {
      -- Change keys to needed
      -- { vim.o.shell, "<M-1>", "Horizontal Terminal", "horizontal", 0.3 },
      -- { vim.o.shell, "<M-2>", "Vertical Terminal", "vertical", 0.4 },
      { vim.o.shell, "<M-`>", "Float Terminal", "float", nil },
    }
-- vim.keymap.set("n", "<C-t>", "<cmd>ToggleTerm<cr>")
-- vim.keymap.set("t", "<C-t>", "<cmd>ToggleTerm<cr>")
-- lvim.keys.normal_mode["<C-t>"] = "<cmd>ToggleTerminal<cr>"


-- nvim tree
--("n", "<leader>e", ":NvimTreeToggle<cr>", opts)
-- lvim.builtin.project.manual_mode = true
lvim.builtin.nvimtree.setup.hijack_directories.enable = true
lvim.builtin.nvimtree.setup.hijack_directories.auto_open = true
lvim.builtin.nvimtree.setup.diagnostics = {
  enable = true,
  show_on_dirs = true,
  icons = {
    hint = "",
    info = "",
    warning = "",
    error = "",
  },
}
lvim.builtin.nvimtree.setup.actions.open_file.quit_on_open = true
lvim.builtin.nvimtree.setup.view = {
  -- 浮动效果不理想，不开了 gxt_kt
  -- float={
  --   enable=false,
  --   quit_on_focus_loss=true,
  --   open_win_config={
  --             relative = "editor",
  --             border = "rounded",
  --             width = 30,
  --             height = 30,
  --             row = 1,
  --             col = 1,
  --   },
  -- },
  width = 30,
  side = "left",
  mappings = {
    list = {
      { key = { "l", "<CR>", "o" }, action = "edit" },
      { key = "h", action = "close_node" },
      { key = "v", action = "vsplit" },
      -- { key = "C-t", action = false}, -- remove default key C-t
      -- { key = "g", action = "toggle_git_ignored" },--[[  default I ]]
      -- { key = "<BS>", action = "toggle_dotfiles" },--[[  default H ]]
    },
  },
}


-- cmp
lvim.builtin.cmp.cmdline.enable = true
table.insert(lvim.builtin.cmp.sources, {
  name = 'nvim_lsp_signature_help'
});


-- gitsigns
lvim.builtin.gitsigns.opts.current_line_blame = false
lvim.builtin.gitsigns.opts.current_line_blame_opts.virt_text_pos = "right_align"
lvim.builtin.gitsigns.opts.current_line_blame_opts.delay = 200

-- buffer line
lvim.builtin.bufferline.highlights.buffer_selected = {
  bold = true,
  fg = "#ffd43b"
}


-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  -- "all",
  "bash",
  "c",
  "cpp",
  "json",
  "lua",
  "python",
  "yaml",
  "rust",
}
-- lvim.builtin.treesitter.auto_install = false
-- lvim.builtin.treesitter.ensure_installed="all"

-- lvim.builtin.treesitter.ignore_install = {"markdown" }
lvim.builtin.treesitter.highlight.enable = true

-- About treesitter config my rainbow color see https://github.com/p00f/nvim-ts-rainbow/issues/104
lvim.builtin.treesitter.rainbow.enable = true
lvim.builtin.treesitter.rainbow.extended_mode = true
lvim.builtin.treesitter.rainbow.max_file_lines = 5000 -- default is 1000
lvim.builtin.treesitter.rainbow.colors = {
  "#d65d0e",
  "#689d6a",
  "#b16286",
  "#89ddff",
  "#d79921",
  "#a89984",
  "#cc241d",
}

-- generic LSP settings

-- -- make sure server will always be installed even if the server is in skipped_servers list
lvim.lsp.installer.setup.ensure_installed = {
  "clangd",
  "pyright",
}

-- -- change UI setting of `LspInstallInfo`
-- -- see <https://github.com/williamboman/nvim-lsp-installer#default-configuration>
-- lvim.lsp.installer.setup.ui.check_outdated_servers_on_open = false
-- lvim.lsp.installer.setup.ui.border = "rounded"
-- lvim.lsp.installer.setup.ui.keymaps = {
--     uninstall_server = "d",
--     toggle_server_expand = "o",
-- }

-- ---@usage disable automatic installation of servers
lvim.lsp.installer.setup.automatic_installation = false

-- disable diagnostics which is super annoying in my case
-- lvim.lsp.diagnostics.virtual_text = true
-- lvim.diagnostic.config({ virtual_text = true })

-- vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "clangd" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
--
---@diagnostic disable-next-line: missing-parameter
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright", "clangd" })
require("lvim.lsp.manager").setup("pyright", {
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "openFilesOnly",
        useLibraryCodeForTypes = true,
        typeCheckingMode = "off",
        autoImportCompletions = true
      }
    }
  },
})

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "pylsp"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
-- require "lsp_signature".on_attach()
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "black", filetypes = { "python" } },

  -- { command = "isort", filetypes = { "python" } },
  -- {
  --   -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
  --   command = "prettier",
  --   ---@usage arguments to pass to the formatter
  --   -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
  --   extra_args = { "--print-with", "100" },
  --   ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
  --   filetypes = { "typescript", "typescriptreact" },
  -- },
}

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   -- { command = "flake8", filetypes = { "python" } },
--   -- {
--   --   -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--   --   command = "shellcheck",
--   --   ---@usage arguments to pass to the formatter
--   --   -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--   --   extra_args = { "--severity", "warning" },
--   -- },
--   {
--     command = "cpplint",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "c", "cpp" },
--   },
-- }

lvim.lsp.null_ls.setup.on_init = function(new_client, _)
  new_client.offset_encoding = "utf-16"
end


-- Additional Plugins
lvim.plugins = {
  {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
    -- cmd = "TroubleToggle",
  },
  { -- better quick fix
    "kevinhwang91/nvim-bqf",
    config = function()
      require('bqf').setup(
        {
          func_map = {
            pscrollup = "<C-u>",
            pscrolldown = "<C-d>"
          },
        }
      )
    end
  },
  { -- only works on https://github.com/universal-ctags/ctags
    "liuchengxu/vista.vim",
    config = function()
      vim.cmd([[ 
      let g:vista_sidebar_position = 'vertical topleft' 
      let g:vista_default_executive = 'nvim_lsp' 
      ]])
    end
  },
  { -- telescope instant searching
    "nvim-telescope/telescope-live-grep-args.nvim"
  },
  {
    "ldelossa/litee.nvim",
    config = function()
      require("litee.lib").setup({})
    end
  },
  { -- calltree
    "ldelossa/litee-calltree.nvim",
    config = function()
      require("litee.calltree").setup({
        -- NOTE: the plugin is in-progressing
        on_open = "pannel", -- pannel | popout
        hide_cursor = false,
        keymaps = {
          expand = "o",
          collapse = "zc",
          collapse_all = "zM",
          jump = "<CR>",
          jump_split = "s",
          jump_vsplit = "v",
          jump_tab = "t",
          hover = "i",
          details = "d",
          close = "X",
          close_panel_pop_out = "<C-c>",
          help = "?",
          hide = "H",
          switch = "S",
          focus = "f"
        },
      })
    end
  },
  {
    "NLKNguyen/papercolor-theme"
  },
  { -- hop
    "phaazon/hop.nvim",
    branch = 'v2', -- optional but strongly recommended
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
    end
  },
  { -- resize window
    "simeji/winresizer"
  },
  { -- vim clip on server
    "wincent/vim-clipper",
    config = function()
      vim.cmd([[
      let g:ClipperAddress="127.0.0.1"
      let g:ClipperPort=8377
      let g:ClipperAuto=1
      call clipper#set_invocation('netcat -c 127.0.0.1 8377')
    ]] )
    end
  },
  { -- log file content highlighting
    "mtdl9/vim-log-highlighting"
  },
  {
    -- "tpope/vim-surround",
    'kylechui/nvim-surround',
    version = "*",
    config = function()
      require('nvim-surround').setup({
        --   keymaps = {
        --     insert = "<C-g>s",
        --     insert_line = "<C-g>S",
        --     normal = "ys",
        --     normal_cur = "yss",
        --     normal_line = "yS",
        --     normal_cur_line = "ySS",
        --     visual = "S",
        --     visual_line = "gS",
        --     -- delete = "<NOP>",
        --     delete = "ds",
        --     change = "cs",
        --   },
      })
    end
  },
  { -- theme
    "morhetz/gruvbox"
  },
  {
    "folke/todo-comments.nvim",
    config = function()
      require("todo-comments").setup {}
    end
  },
  { -- auto save
    "pocco81/auto-save.nvim"
  },
  {
    "p00f/clangd_extensions.nvim",
    after = "mason-lspconfig.nvim", -- make sure to load after mason-lspconfig
    config = function()
      local provider = "clangd"
      local clangd_flags = {
        -- 在后台自动分析文件（基于complie_commands)
        "--compile-commands-dir=build",
        "--background-index",
        "--completion-style=detailed",
        -- 同时开启的任务数量
        "--all-scopes-completion=true",
        "--recovery-ast",
        "--suggest-missing-includes",
        -- 告诉clangd用那个clang进行编译，路径参考which clang++的路径
        "--query-driver=/usr/locla/bin/clang++,/usr/bin/g++",
        "--clang-tidy",
        -- 全局补全（会自动补充头文件）
        "--all-scopes-completion",
        "--cross-file-rename",
        -- 更详细的补全内容
        "--completion-style=detailed",
        "--function-arg-placeholders=false",
        -- 补充头文件的形式
        "--header-insertion=never",
        -- pch优化的位置
        "--pch-storage=memory",
        "--offset-encoding=utf-16",
        "-j=12",
      }

      local custom_on_attach = function(client, bufnr)
        require("lvim.lsp").common_on_attach(client, bufnr)
        require("clangd_extensions.inlay_hints").setup_autocmd()
        require("clangd_extensions.inlay_hints").set_inlay_hints()
      end


      local custom_on_init = function(client, bufnr)
        require("lvim.lsp").common_on_init(client, bufnr)
        require("clangd_extensions.config").setup {}
        require("clangd_extensions.ast").init()
        vim.cmd [[
              command ClangdToggleInlayHints lua require('clangd_extensions.inlay_hints').toggle_inlay_hints()
              command -range ClangdAST lua require('clangd_extensions.ast').display_ast(<line1>, <line2>)
              command ClangdTypeHierarchy lua require('clangd_extensions.type_hierarchy').show_hierarchy()
              command ClangdSymbolInfo lua require('clangd_extensions.symbol_info').show_symbol_info()
              command -nargs=? -complete=customlist,s:memuse_compl ClangdMemoryUsage lua require('clangd_extensions.memory_usage').show_memory_usage('<args>' == 'expand_preamble')
              ]]
      end

      local opts = {
        cmd = { provider, unpack(clangd_flags) },
        on_attach = custom_on_attach,
        on_init = custom_on_init,
      }

      require("lvim.lsp.manager").setup("clangd", opts)
    end
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    config = function()
      require 'nvim-treesitter.configs'.setup {
        textobjects = {
          select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              -- You can optionally set descriptions to the mappings (used in the desc parameter of
              -- nvim_buf_set_keymap) which plugins like which-key display
              ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
            },
            -- You can choose the select mode (default is charwise 'v')
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * method: eg 'v' or 'o'
            -- and should return the mode ('v', 'V', or '<c-v>') or a table
            -- mapping query_strings to modes.
            selection_modes = {
              ['@parameter.outer'] = 'v', -- charwise
              ['@function.outer'] = 'V', -- linewise
              ['@class.outer'] = '<c-v>', -- blockwise
            },
            -- If you set this to `true` (default is `false`) then any textobject is
            -- extended to include preceding or succeeding whitespace. Succeeding
            -- whitespace has priority in order to act similarly to eg the built-in
            -- `ap`.
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * selection_mode: eg 'v'
            -- and should return true of false
            include_surrounding_whitespace = true,
          },
          move = {
            enable = true,
            set_jumps = false, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]]"] = "@function.outer",
              -- ["]["] = "@function.outer",
            },
            goto_next_end = {
              ["]["] = "@function.outer",
              -- ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[["] = "@function.outer",
              -- ["[]"] = "@function.outer",
            },
            goto_previous_end = {
              ["[]"] = "@function.outer",
              -- ["[]"] = "@class.outer",
            },
          },
          lsp_interop = {
            enable = true,
            border = 'none',
            peek_definition_code = {
              ["<leader>pf"] = "@function.outer",
              ["<leader>pF"] = "@class.outer",
            },
          },
        },
      }
    end
  },
  {
    "AckslD/nvim-neoclip.lua",
    config = function()
      require('neoclip').setup({
        keys = {
          telescope = {
            i = {
              ["<C-j>"] = actions.cycle_history_next,
              ["<C-k>"] = actions.cycle_history_prev,
              ["<C-n>"] = actions.move_selection_next,
              ["<C-p>"] = false,
              paste = false,
              ["<C-p>"] = actions.move_selection_previous,

              paste = '<CR>',

              -- 选择好像有点问题，不是很理解？
              -- ['<CR>'] = false,
              -- select = false ,
              -- select ='<CR>',

              --paste = '<c-p>',
              -- paste_behind = '<c-P>',

              -- replay好像也不行，复制不全？会报错?
              replay = '<c-r>', -- replay a macro

              delete = '<c-d>', -- delete an entry
              edit = '<c-e>', -- edit an entry
              custom = {},
            },
            n = {
              ["<C-j>"] = actions.cycle_history_next,
              ["<C-k>"] = actions.cycle_history_prev,
              ["<C-n>"] = actions.move_selection_next,
              ["<C-p>"] = false,
              paste = false,
              ["<C-p>"] = actions.move_selection_previous,

              paste = '<CR>',

              -- 选择好像有点问题，不是很理解？
              -- ['<CR>'] = false,
              -- select = false ,
              -- select ='<CR>',

              --paste = '<c-p>',
              -- paste_behind = '<c-P>',

              -- replay好像也不行，复制不全？会报错?
              replay = 'r',
              delete = 'd', -- delete an entry
              edit = 'e', -- edit an entry
              custom = {},
            },
          },
        },
      })
      require('telescope').load_extension('neoclip')
    end,
  },
  {
    "hrsh7th/cmp-nvim-lsp-signature-help",
  },
  {
    'ethanholz/nvim-lastplace'
  },
  -- { -- json parser for dap launch.json
  --   -- NOTE: cargo required: https://rustup.rs/
  --   'Joakker/lua-json5',
  --   run = './install.sh'
  -- },
  {
    "nvim-telescope/telescope-dap.nvim",
    config = function()
      require("telescope").load_extension('dap')
    end
  },
  { -- gxt_kt sniprun : run code
    'michaelb/sniprun', build = 'bash ./install.sh',
    config = function()
      require('sniprun').setup({
        selected_interpreters = {}, --# use those instead of the default for the current filetype
        repl_enable = {}, --# enable REPL-like behavior for the given interpreters
        repl_disable = {}, --# disable REPL-like behavior for the given interpreters

        interpreter_options = { --# intepreter-specific options, see docs / :SnipInfo <name>
          GFM_original = {
            use_on_filetypes = { "markdown.pandoc" } --# the 'use_on_filetypes' configuration key is
            --# available for every interpreter
          }
        },

        --# you can combo different display modes as desired
        display = {
          "Classic", --# display results in the command-line  area
          "VirtualTextOk", --# display ok results as virtual text (multiline is shortened)
          --"VirtualTextErr",          --# display error results as virtual text
          -- "TempFloatingWindow",      --# display results in a floating window
          -- "LongTempFloatingWindow",  --# same as above, but only long results. To use with VirtualText__
          "Terminal", --# display results in a vertical split
          --"TerminalWithCode",        --# display results and code history in a vertical split
          -- "NvimNotify",              --# display with the nvim-notify plugin
          -- "Api"                      --# return output to a programming interface
        },

        display_options = {
          terminal_width = 45, --# change the terminal display option width
          notification_timeout = 5 --# timeout for nvim_notify output
        },

        --# You can use the same keys to customize whether a sniprun producing
        --# no output should display nothing or '(no output)'
        show_no_output = {
          "Classic",
          "TempFloatingWindow", --# implies LongTempFloatingWindow, which has no effect on its own
        },

        --# customize highlight groups (setting this overrides colorscheme)
        snipruncolors = {
          SniprunVirtualTextOk  = { bg = "#66eeff", fg = "#000000", ctermbg = "Cyan", cterfg = "Black" },
          SniprunFloatingWinOk  = { fg = "#66eeff", ctermfg = "Cyan" },
          SniprunVirtualTextErr = { bg = "#881515", fg = "#000000", ctermbg = "DarkRed", cterfg = "Black" },
          SniprunFloatingWinErr = { fg = "#881515", ctermfg = "DarkRed" },
        },

        --# miscellaneous compatibility/adjustement settings
        inline_messages = 0, --# inline_message (0/1) is a one-line way to display messages
        --# to workaround sniprun not being able to display anything

        borders = 'single', --# display borders around floating windows
        --# possible values are 'none', 'single', 'double', or 'shadow'
        live_mode_toggle = 'off' --# live mode toggle, see Usage - Running for more info
      })
    end
  },
  { -- gxt_kt github-nvim-theme
    "projekt0n/github-nvim-theme"
  },
  { -- gxt_kt nvim-colorizer  for like #ff00ff css color
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end
  },
  { -- gxt_kt nvim-lightbulb  : Show a blub if there a lsp code action
    "kosayoda/nvim-lightbulb",
    config = function()
      require("nvim-lightbulb").setup({
        -- LSP client names to ignore
        -- Example: {"sumneko_lua", "null-ls"}
        ignore = {},
        sign = {
          enabled = true,
          -- Priority of the gutter sign
          priority = 10,
        },
        float = {
          enabled = false,
          -- Text to show in the popup float
          text = "💡",
          -- Available keys for window options:
          -- - height     of floating window
          -- - width      of floating window
          -- - wrap_at    character to wrap at for computing height
          -- - max_width  maximal width of floating window
          -- - max_height maximal height of floating window
          -- - pad_left   number of columns to pad contents at left
          -- - pad_right  number of columns to pad contents at right
          -- - pad_top    number of lines to pad contents at top
          -- - pad_bottom number of lines to pad contents at bottom
          -- - offset_x   x-axis offset of the floating window
          -- - offset_y   y-axis offset of the floating window
          -- - anchor     corner of float to place at the cursor (NW, NE, SW, SE)
          -- - winblend   transparency of the window (0-100)
          win_opts = {},
        },
        virtual_text = {
          enabled = true,
          -- Text to show at virtual text
          text = "💡",
          -- highlight mode to use for virtual text (replace, combine, blend), see :help nvim_buf_set_extmark() for reference
          hl_mode = "replace",
        },
        status_text = {
          enabled = false,
          -- Text to provide when code actions are available
          text = "💡",
          -- Text to provide when no actions are available
          text_unavailable = ""
        }
      })
    end,
    --vim.cmd([[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]])
  },
  { -- gxt_kt symbols-outline.nvim : show outline
    "simrat39/symbols-outline.nvim",
    config = function()
      require("symbols-outline").setup({
        highlight_hovered_item = true,
        show_guides = true,
        auto_preview = false,
        position = 'right',
        relative_width = true,
        width = 25,
        auto_close = false,
        show_numbers = false,
        show_relative_numbers = false,
        show_symbol_details = true,
        preview_bg_highlight = 'Pmenu',
        autofold_depth = nil,
        auto_unfold_hover = true,
        fold_markers = { '', '' },
        wrap = false,
        keymaps = { -- These keymaps can be a string or a table for multiple keys
          close = { "<Esc>", "q" },
          goto_location = "<Cr>",
          focus_location = "o",
          hover_symbol = "<C-space>",
          toggle_preview = "K",
          rename_symbol = "r",
          code_actions = "a",
          fold = "h",
          unfold = "l",
          fold_all = "W",
          unfold_all = "E",
          fold_reset = "R",
        },
        lsp_blacklist = {},
        symbol_blacklist = {},
        symbols = {
          File = { icon = "", hl = "@text.uri" },
          Module = { icon = "", hl = "@namespace" },
          Namespace = { icon = "", hl = "@namespace" },
          Package = { icon = "", hl = "@namespace" },
          Class = { icon = "𝓒", hl = "@type" },
          Method = { icon = "ƒ", hl = "@method" },
          Property = { icon = "", hl = "@method" },
          Field = { icon = "", hl = "@field" },
          Constructor = { icon = "", hl = "@constructor" },
          Enum = { icon = "ℰ", hl = "@type" },
          Interface = { icon = "ﰮ", hl = "@type" },
          Function = { icon = "", hl = "@function" },
          Variable = { icon = "", hl = "@constant" },
          Constant = { icon = "", hl = "@constant" },
          String = { icon = "𝓐", hl = "@string" },
          Number = { icon = "#", hl = "@number" },
          Boolean = { icon = "⊨", hl = "@boolean" },
          Array = { icon = "", hl = "@constant" },
          Object = { icon = "⦿", hl = "@type" },
          Key = { icon = "🔐", hl = "@type" },
          Null = { icon = "NULL", hl = "@type" },
          EnumMember = { icon = "", hl = "@field" },
          Struct = { icon = "𝓢", hl = "@type" },
          Event = { icon = "🗲", hl = "@type" },
          Operator = { icon = "+", hl = "@operator" },
          TypeParameter = { icon = "𝙏", hl = "@parameter" },
          Component = { icon = "", hl = "@function" },
          Fragment = { icon = "", hl = "@constant" },
        },
      })
    end
  },
  { -- gxt_kt nvim-ts-rainbow : Show rainbow bracket
    "p00f/nvim-ts-rainbow",
  },
  { -- gxt_kt tmux.nvim: Use tmux and nvim better
    "aserowy/tmux.nvim",
    config = function()
      require("tmux").setup(
        {
          copy_sync = {
            -- enables copy sync. by default, all registers are synchronized.
            -- to control which registers are synced, see the `sync_*` options.
            enable = false,

            -- ignore specific tmux buffers e.g. buffer0 = true to ignore the
            -- first buffer or named_buffer_name = true to ignore a named tmux
            -- buffer with name named_buffer_name :)
            ignore_buffers = { empty = false },

            -- TMUX >= 3.2: all yanks (and deletes) will get redirected to system
            -- clipboard by tmux
            redirect_to_clipboard = false,

            -- offset controls where register sync starts
            -- e.g. offset 2 lets registers 0 and 1 untouched
            register_offset = 0,

            -- overwrites vim.g.clipboard to redirect * and + to the system
            -- clipboard using tmux. If you sync your system clipboard without tmux,
            -- disable this option!
            sync_clipboard = false,

            -- synchronizes registers *, +, unnamed, and 0 till 9 with tmux buffers.
            sync_registers = false,

            -- syncs deletes with tmux clipboard as well, it is adviced to
            -- do so. Nvim does not allow syncing registers 0 and 1 without
            -- overwriting the unnamed register. Thus, ddp would not be possible.
            sync_deletes = false,

            -- syncs the unnamed register with the first buffer entry from tmux.
            sync_unnamed = false,
          },
          navigation = {
            -- cycles to opposite pane while navigating into the border
            cycle_navigation = false,

            -- enables default keybindings (C-hjkl) for normal mode
            enable_default_keybindings = true,

            -- prevents unzoom tmux when navigating beyond vim border
            persist_zoom = false,
          },
          resize = {
            -- enables default keybindings (A-hjkl) for normal mode
            enable_default_keybindings = true,

            -- sets resize steps for x axis
            resize_step_x = 1,

            -- sets resize steps for y axis
            resize_step_y = 1,
          }
        }
      )
    end
  },
  -- { -- gxt_kt nvim-semantic-tokens :
  --   'theHamsta/nvim-semantic-tokens',
  --   config = function()
  --     require("nvim-semantic-tokens").setup {
  --       preset = "default",
  --       -- highlighters is a list of modules following the interface of nvim-semantic-tokens.table-highlighter or
  --       -- function with the signature: highlight_token(ctx, token, highlight) where
  --       --        ctx (as defined in :h lsp-handler)
  --       --        token  (as defined in :h vim.lsp.semantic_tokens.on_full())
  --       --        highlight (a helper function that you can call (also multiple times) with the determined highlight group(s) as the only parameter)
  --       highlighters = { require 'nvim-semantic-tokens.table-highlighter' }
  --     }
  --   end
  -- },
  { -- gxt_kt vim-autoread : Auto load file if file changes
    'djoshea/vim-autoread',
  },
  -- { -- gxt_kt far.vim : Search and substitute plugin
  --   'brooth/far.vim'
  -- },
  { -- gxt_kt brooth/far.vim : Search use ripgrep
    'jremmen/vim-ripgrep',
  },
  { -- gxt_kt nvim-spectre : Search and substitute
    'windwp/nvim-spectre',
    config = function()
      require('spectre').setup({
        open_cmd           = 'vnew',
        live_update        = true, -- auto excute search again when you write any file in vim
        replace_vim_cmd    = "cdo",
        is_open_target_win = true, --open file on opener window
        is_insert_mode     = true, -- start open panel on is_insert_mode
        mapping            = {
          ['send_to_qf'] = {
            map = "F",
            cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
            desc = "send all item to quickfix"
          },
          ['replace_cmd'] = {
            map = "C",
            cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>",
            desc = "input replace vim command"
          },
          ['show_option_menu'] = {
            map = "M",
            cmd = "<cmd>lua require('spectre').show_options()<CR>",
            desc = "show option"
          },
          ['run_current_replace'] = {
            map = "r",
            cmd = "<cmd>lua require('spectre.actions').run_current_replace()<CR>",
            desc = "replace current line"
          },
          ['run_replace'] = {
            map = "R",
            cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
            desc = "replace all"
          },
          ['change_view_mode'] = {
            map = "<A-v>",
            cmd = "<cmd>lua require('spectre').change_view()<CR>",
            desc = "change result view mode"
          },
          ['toggle_live_update'] = {
            map = "U",
            cmd = "<cmd>lua require('spectre').toggle_live_update()<CR>",
            desc = "update change when vim write file."
          },
          ['toggle_ignore_case'] = {
            map = "I",
            cmd = "<cmd>lua require('spectre').change_options('ignore-case')<CR>",
            desc = "toggle ignore case"
          },
          ['toggle_ignore_hidden'] = {
            map = "H",
            cmd = "<cmd>lua require('spectre').change_options('hidden')<CR>",
            desc = "toggle search hidden"
          },
          ['resume_last_search'] = {
            map = "L",
            cmd = "<cmd>lua require('spectre').resume_last_search()<CR>",
            desc = "resume last search before close"
          },
          -- you can put your mapping here it only use normal mode
        }
      })
    end
  },
  {
    'mg979/vim-visual-multi',
  },
  {
    'weilbith/nvim-code-action-menu',
    config = function()
      vim.g.code_action_menu_show_details = false
      vim.g.code_action_menu_show_diff = true
      vim.g.code_action_menu_show_action_kind = true
    end
  },
  {
    'theHamsta/nvim-dap-virtual-text',
    config = function()
      require("nvim-dap-virtual-text").setup {
        enabled = true, -- enable this plugin (the default)
        enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
        highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
        highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
        show_stop_reason = true, -- show stop reason when stopped for exceptions
        commented = false, -- prefix virtual text with comment string
        only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
        all_references = false, -- show virtual text on all all references of the variable (not only definitions)
        --- A callback that determines how a variable is displayed or whether it should be omitted
        --- @param variable Variable https://microsoft.github.io/debug-adapter-protocol/specification#Types_Variable
        --- @param buf number
        --- @param stackframe dap.StackFrame https://microsoft.github.io/debug-adapter-protocol/specification#Types_StackFrame
        --- @param node userdata tree-sitter node identified as variable definition of reference (see `:h tsnode`)
        --- @return string|nil A text how the virtual text should be displayed or nil, if this variable shouldn't be displayed
        display_callback = function(variable, _buf, _stackframe, _node)
          return variable.name .. ' = ' .. variable.value
        end,

        -- experimental features:
        virt_text_pos = 'eol', -- position of virtual text, see `:h nvim_buf_set_extmark()`
        all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
        virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
        virt_text_win_col = nil -- position the virtual text at a fixed window column (starting from the first text column) ,
        -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
      }
    end
  },
  -- {
  --   'kaicataldo/material.vim',
  -- },
  {
    'marko-cerovac/material.nvim',
    config = function()
      require('material').setup({

        contrast = {
          terminal = false, -- Enable contrast for the built-in terminal
          sidebars = false, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
          floating_windows = false, -- Enable contrast for floating windows
          cursor_line = false, -- Enable darker background for the cursor line
          non_current_windows = false, -- Enable darker background for non-current windows
          filetypes = {}, -- Specify which filetypes get the contrasted (darker) background
        },

        styles = { -- Give comments style such as bold, italic, underline etc.
          comments = { italic = true },
          strings = { bold = true },
          keywords = { underline = false },
          functions = { bold = true, undercurl = false },
          variables = {},
          operators = {},
          types = {},
        },

        plugins = { -- Uncomment the plugins that you use to highlight them
          -- Available plugins:
          "dap",
          "dashboard",
          "gitsigns",
          "hop",
          "indent-blankline",
          "lspsaga",
          "mini",
          "neogit",
          "nvim-cmp",
          "nvim-navic",
          "nvim-tree",
          "nvim-web-devicons",
          "sneak",
          "telescope",
          "trouble",
          "which-key",
        },

        disable = {
          colored_cursor = false, -- Disable the colored cursor
          borders = false, -- Disable borders between verticaly split windows
          background = false, -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
          term_colors = false, -- Prevent the theme from setting terminal colors
          eob_lines = false -- Hide the end-of-buffer lines
        },

        high_visibility = {
          lighter = false, -- Enable higher contrast text for lighter style
          darker = false -- Enable higher contrast text for darker style
        },

        lualine_style = "default", -- Lualine style ( can be 'stealth' or 'default' )

        async_loading = true, -- Load parts of the theme asyncronously for faster startup (turned on by default)

        -- If you want to everride the default colors, set this to a function
        -- custom_colors = nil,
        custom_colors = function(colors)
          -- colors.editor.selection = "#ff0000"
        end,

        -- change can refer here : https://github.com/marko-cerovac/material.nvim/issues/126
        custom_highlights = {
          IncSearch = { fg = "#000000", bg = "#ECF9ff", underline = true },
          Search    = { fg = "#000000", bg = "#ECF9ff", bold = true },

          -- change hop-nvim color
          HopNextKey = { fg = "#ff0000", bold = true },
          -- HopNextKey1 = { fg = "#00ff00", bold = true },
          -- HopNextKey2 = { fg = "#0000ff" },
        }, -- Overwrite highlights with your own
      })
    end
  },
  {
    'szw/vim-maximizer',
  },
  {
    'iamcco/markdown-preview.nvim',
    -- run = function()
    --   vim.fn["mkdp#util#install"]()
    -- end,
  },
  {
    'folke/tokyonight.nvim',
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      vim.opt.termguicolors = true
      vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]

      vim.opt.list = true
      vim.opt.listchars:append "space:⋅"
      -- vim.opt.listchars:append "eol:↴"

      require("indent_blankline").setup {
          space_char_blankline = " ",
          char_highlight_list = {
            "IndentBlanklineIndent1",
            "IndentBlanklineIndent2",
            "IndentBlanklineIndent3",
            "IndentBlanklineIndent4",
            "IndentBlanklineIndent5",
            "IndentBlanklineIndent6",
          },
      }
    end
  },
  -- { -- gxt_kt vim-tmux-clipboard : vim tmux clipboard
  --   'roxma/vim-tmux-clipboard',
  -- },
  --
  --
}

-- gxt_kt Show rainbow bracket
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern="cpp",
--   command="autocmd BufEnter,TextChanged <buffer> lua require 'lvim.lsp.buf'.semantic_tokens_full()"
-- })


vim.cmd([[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]])

--- dap config
-- load non-standard json file
-- require('dap.ext.vscode').json_decode = require 'json5'.parse
-- require('dap.ext.vscode').load_launchjs()
-- require("dap.dap-lldb")
-- require("dap.dap-cppdbg")

-- gxt_kt debug config :
lvim.builtin.dap.active = true
require('dap.python')
require('dap.c_cpp_rust')

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
--
--
--
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  command = "set tabstop=4  shiftwidth=4"
})
