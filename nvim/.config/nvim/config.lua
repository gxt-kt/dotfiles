-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
  notify = {
    notify_enabled = false,
  },
  gp = {
    gp_enabled = true,
    gp_proxy = "127.0.0.1:7890",
    -- gp_openai_key_file_path = vim.fn.stdpath("config") .. "/.openai_api_key"
  },
  markdown = {
    highlight_by_headlines = true,
  }
}
