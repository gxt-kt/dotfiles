-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE


-- vim.opt.colorcolumn = "80" -- a line at 80 column postion -- 80 for google c++ style

return {
  notify = {
    notify_enabled = false,
  },
  image = {
    image_enabled = false,
  },
  gp = {
    gp_enabled = true,
    gp_proxy = "127.0.0.1:7890",
    -- gp_openai_key_file_path = vim.fn.stdpath("config") .. "/.openai_api_key"
  },
  markdown = {
    highlight_by_headlines = true,
  },
  leetcode = {
    leetcode_enabled = true,
    show_image = true,
    lang = "cpp",
    cn = {
      cn_enabled = true,
      translator = false,
      translate_problems = true,
    },
  },
}
