return {
  "nickjvandyke/opencode.nvim",
  dependencies = {
    "folke/snacks.nvim",
  },
  keys = {
    { "<leader>oc", function() require("opencode").toggle() end, desc = "Toggle OpenCode", mode = { "n", "t" } },
  },
  config = function()
    -- Enable autoread for automatic buffer reloading when opencode edits files
    vim.o.autoread = true

    -- Configure opencode.nvim
    vim.g.opencode_opts = {
      -- Add any custom options here
      -- See :help opencode-config for available options
    }
  end,
  -- Load on VeryLazy for better startup performance
  event = "VeryLazy",
}
