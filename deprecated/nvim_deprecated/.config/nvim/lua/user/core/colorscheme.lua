local status, tn=pcall(require,"tokyonight")
if not status then
  return
end

tn.setup({
  style="storm",
  dim_inactivate=true,
})

--vim.cmd("colorscheme tokyonight-storm")
vim.cmd("colorscheme palenight")



