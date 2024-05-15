-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
  {
    -- 可以再浏览器中预览markdown文件
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = "markdown",
    build = function() vim.fn["mkdp#util#install"]() end,
    config = function()
      vim.g.mkdp_auto_close = 0 -- not close when changing buffer
    end,
  },
  {
    -- 增强笔记文件显示，markdown, orgmode, neorg
    -- show latex on markdown file can use plugin "jbyuki/nabla.nvim"
    'lukas-reineke/headlines.nvim',
    enabled = require("my_sys").GetConfig("config_", "markdown.highlight_by_headlines", true),
    ft = "markdown",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      vim.cmd [[highlight Headline1 guibg=#3B4736]]
      vim.cmd [[highlight Headline2 guibg=#40464E]]
      vim.cmd [[highlight Headline3 guibg=#50565E]]
      vim.cmd [[highlight Headline4 guibg=#60666E]]
      -- vim.cmd [[highlight CodeBlock guibg=#1c1c1c]]
      vim.cmd [[highlight Dash guibg=#D19A66 gui=bold]]
      require("headlines").setup({
        markdown = {
          bullets = { "#", "##", "###", "###" },
          headline_highlights = { "Headline1", "Headline2", "Headline3", "Headline4" },
        },
      })
    end,
  },
}
