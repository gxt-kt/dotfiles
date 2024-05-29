-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- 这个文件我是想要禁止astronvim中默认使用的状态栏（来自heirline）
-- 然后自己配置自己的

local heirline_statuscol_enabled = require("my_sys").GetConfig("config_", "heirline.statuscol_enabled", false)
if heirline_statuscol_enabled then return {} end

-- https://github.com/kevinhwang91/nvim-ufo/issues/4#issuecomment-1512772530

return {
  {
    -- disable heirline's statuscolumn
    "rebelot/heirline.nvim",
    optional = true,
    opts = function(_, opts) opts.statuscolumn = nil end,
  },
  -- UFO folding
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
    },
    event = "BufReadPost",
    opts = {
      provider_selector = function() return { "treesitter", "indent" } end,
    },
    init = function()
      vim.keymap.set("n", "zR", function() require("ufo").openAllFolds() end)
      vim.keymap.set("n", "zM", function() require("ufo").closeAllFolds() end)
    end,
  },
  {
    -- 定义自己的状态栏，比如让git标识显示在行号右侧
    "luukvbaal/statuscol.nvim",
    config = function()
      local builtin = require "statuscol.builtin"
      require("statuscol").setup {
        -- disable for neo-tree
        ft_ignore = { "neo-tree" },
        -- whether to right-align the cursor line number with 'relativenumber' set
        relculright = false,
        -- Default segments (fold -> sign -> line number + separator), explained below
        segments = {
          -- 显示别的乱七八遭的
          {
            sign = {
              name = { ".*" },
              namespace = { ".*" },
              max_width = 2,
              colwidth = 2,
              auto = true,
            },
            condition = { true, builtin.not_empty },
            click = "v:lua.ScLa",
          },
          -- 显示折叠（ufo)
          { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
          -- 显示行号
          {
            text = { builtin.lnumfunc, " " },
            -- condition = { true, builtin.not_empty },
            click = "v:lua.ScLa",
          },
          -- 显示git状态
          {
            -- Ref: https://github.com/luukvbaal/statuscol.nvim/issues/71
            sign = {
              name = { "GitSign" },
              namespace = { "gitsign" },
              max_width = 1,
              colwidth = 1,
              auto = false,
            },
            -- condition = { true, builtin.not_empty },
            click = "v:lua.ScLa",
          },
        },
      }
    end,
  },
}
