-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

require "dap.c_cpp_rust"
require "dap.dap-lldb"
require "dap.python"

return {
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = {
      ensure_installed = { "python", "cpp", "rust" },
    },
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    config = function() require("nvim-dap-virtual-text").setup() end,
  },
}
