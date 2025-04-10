return {
  "notjedi/nvim-rooter.lua",
  lazy = false,
  config = function()
    require("nvim-rooter").setup {
      rooter_patterns = { ".git", ".hg", "Makefile" },
      trigger_patterns = { "*" },
      manual = false,
      fallback_to_parent = false,
    }
  end,
}
