-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

local gp_enabled = require("my_sys").GetConfig("config", "gp.gp_enabled", false)
local gp_proxy = require("my_sys").GetConfig("config", "gp.gp_proxy")
local openai_api_key_file_path = require("my_sys").GetConfig("config", "gp.gp_openai_key_file_path")

-- chatgpt openai插件
return {
  enabled = gp_enabled,

  "robitx/gp.nvim",
  config = function()
    require("gp").setup({
      -- openai_api_key = { "cat", openai_api_key_file_path },
      openai_api_key = (openai_api_key_file_path == nil) and { "" } or { "cat", openai_api_key_file_path },
      -- curl_params = { "--proxy", gp_proxy },
      curl_params = (gp_proxy == nil) and {} or { "--proxy", gp_proxy },
      -- openai_api_key = os.getenv("OPENAI_API_KEY"),
    })
  end,
}
