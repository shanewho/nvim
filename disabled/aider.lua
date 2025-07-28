return {
  "GeorgesAlkhouri/nvim-aider",
  cmd = {
    "AiderTerminalToggle",
  },
  keys = {
    { "<leader>a/", "<cmd>Aider toggle<cr>", desc = "Toggle Aider" },
    { "<leader>as", "<cmd>Aider send<cr>", desc = "Send to Aider", mode = { "n", "v" } },
    { "<leader>ac", "<cmd>Aider command<cr>", desc = "Aider Commands" },
    { "<leader>ab", "<cmd>Aider buffer<cr>", desc = "Send Buffer" },
    { "<leader>an", "<cmd>Aider reset<cr><cmd>Aider add<cr>", desc = "Add File" },
    { "<leader>aa", "<cmd>Aider add<cr>", desc = "Add File" },
    { "<leader>ad", "<cmd>Aider drop<cr>", desc = "Drop File" },
    { "<leader>aR", "<cmd>Aider reset<cr>", desc = "Reset Session" },
    -- Example nvim-tree.lua integration if needed
    { "<leader>aa", "<cmd>AiderTreeAddFile<cr>", desc = "Add File from Tree to Aider", ft = "NvimTree" },
    { "<leader>ad", "<cmd>AiderTreeDropFile<cr>", desc = "Drop File from Tree from Aider", ft = "NvimTree" },
  },
  dependencies = {
    "folke/snacks.nvim",
    "nvim-telescope/telescope.nvim",
    --- The below dependencies are optional
    "catppuccin/nvim",
  },
  opts = {
    auto_reload = true,
    args = {
      "--no-stream",
      "--model sonnet",
      "--cache-prompts",
    },
  },
  config = true,
}
