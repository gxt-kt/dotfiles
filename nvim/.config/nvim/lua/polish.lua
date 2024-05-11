-- if true then return end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- NOTE: gxt: Astronvim Feature_or_Bug?
-- https://www.reddit.com/r/AstroNvim/comments/108cir5/keep_word_search_highlighting/
-- https://github.com/AstroNvim/AstroNvim/issues/2109
vim.on_key(nil, vim.api.nvim_get_namespaces()["auto_hlsearch"])

-- Set up custom filetypes
vim.filetype.add {
  extension = {
    foo = "fooscript",
  },
  filename = {
    ["Foofile"] = "fooscript",
  },
  pattern = {
    ["~/%.config/foo/.*"] = "fooscript",
  },
}
