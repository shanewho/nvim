-- lua/plugins/snacks.lua
return {
  "folke/snacks.nvim",
  priority = 1000, -- Recommended for snacks.nvim
  lazy = false, -- Set to false to load on startup, or configure lazy loading options
  opts = {
    -- Your snacks.nvim configuration
    lazygit = {
      enabled = true, -- Enable the lazygit module
      -- Add any specific configurations for lazygit here if needed
    },
    -- Other snacks.nvim modules can be enabled/configured here
  },
  keys = {
    {
      "<leader>lg",
      function()
        require("snacks").lazygit()
      end,
      desc = "LazyGit",
    },
  },
}
