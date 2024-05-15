-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
  {
    "FabijanZulj/blame.nvim",
    config = function() require("blame").setup() end,
  },
}
