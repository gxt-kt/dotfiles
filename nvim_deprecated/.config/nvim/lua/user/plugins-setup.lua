local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end


local packer_bootstrap = ensure_packer()

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
  augroup packer_user_config
  autocmd!
  autocmd bufwritepost plugins-setup.lua source <afile> | packersync
  augroup end
]])

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  local use = require('packer').use
  require('packer').startup(function()
    use 'wbthomason/packer.nvim' -- package manager
  end)

  use "nvim-lua/plenary.nvim"
  use "nvim-lua/popup.nvim"

  use 'nvim-tree/nvim-web-devicons'

  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }

  use 'folke/tokyonight.nvim'
  use 'drewtempelmeyer/palenight.vim'
  use 'joosepalviste/palenightfall.nvim'

  use {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  }

  use("christoomey/vim-tmux-navigator") -- tmux & split window navigation

  --use("ggandor/leap.nvim") -- tmux & split window navigation
  use {
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
    config = function()
      -- you can configure hop the way you like here; see :h hop-config
      require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
    end
  }

  use "szw/vim-maximizer"

  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters

  use 'neovim/nvim-lsp'
  use 'jackguo380/vim-lsp-cxx-highlight'

  use "rrethy/vim-illuminate"
  use 'kosayoda/nvim-lightbulb'
  use "ray-x/lsp_signature.nvim"

  --use {"hrsh7th/cmp-nvim-lsp",commit = "3cf38d9c957e95c397b66f91967758b31be4abe6"}
  use {"hrsh7th/cmp-nvim-lsp",commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8" }
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'saadparwaiz1/cmp_luasnip'
  use 'onsails/lspkind.nvim'

  -- snippets
  use "l3mon4d3/luasnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    --"nvim-treesitter/nvim-treesitter"
    run = ":tsupdate",
  }
  use 'joosepalviste/nvim-ts-context-commentstring'
  use "p00f/nvim-ts-rainbow"
  --use "nvim-treesitter/playground"
  use "numtostr/comment.nvim" -- easily comment stuff

  use({
    "kylechui/nvim-surround",
    tag = "*", -- use for stability; omit to use `main` branch for the latest features
    config = function()
      require("nvim-surround").setup({
        -- configuration here, or leave empty to use defaults
      })
    end
  })


  -- telescope
  use "nvim-telescope/telescope.nvim"
  use 'nvim-telescope/telescope-media-files.nvim'


  use "akinsho/bufferline.nvim"
  use "moll/vim-bbye"


  use "mtdl9/vim-log-highlighting"

  use "morhetz/gruvbox"


  use ({
    "folke/todo-comments.nvim",
    config = function()
      require("todo-comments").setup {}
    end
  })

  --[[ use ({ -- auto save ]]
  --[[   "pocco81/auto-save.nvim" ]]
  --[[ }) ]]


  use ({
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
        require("nvim.lsp").common_on_attach(client, bufnr)
        require("clangd_extensions.inlay_hints").setup_autocmd()
        require("clangd_extensions.inlay_hints").set_inlay_hints()
      end


      local custom_on_init = function(client, bufnr)
        require("nvim.lsp").common_on_init(client, bufnr)
        require("clangd_extensions.config").setup {}
        require("clangd_extensions.ast").init()
        vim.cmd [[
              command clangdtoggleinlayhints lua require('clangd_extensions.inlay_hints').toggle_inlay_hints()
              command -range clangdast lua require('clangd_extensions.ast').display_ast(<line1>, <line2>)
              command clangdtypehierarchy lua require('clangd_extensions.type_hierarchy').show_hierarchy()
              command clangdsymbolinfo lua require('clangd_extensions.symbol_info').show_symbol_info()
              command -nargs=? -complete=customlist,s:memuse_compl clangdmemoryusage lua require('clangd_extensions.memory_usage').show_memory_usage('<args>' == 'expand_preamble')
              ]]
      end

      local opts = {
        cmd = { provider, unpack(clangd_flags) },
        on_attach = custom_on_attach,
        on_init = custom_on_init,
      }

      --[[ require("lspconfig").setup("clangd", opts) ]]
      require("lspconfig")["clangd"].setup( opts)
    end
  })

  use "williamboman/mason-lspconfig.nvim"


  -- automatically set up your configuration after cloning packer.nvim
  -- put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
