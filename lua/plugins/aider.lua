return {
  "GeorgesAlkhouri/nvim-aider",
  cmd = {
    "AiderTerminalToggle",
  },
  args = {
    "--no-stream",
    "--sonnet",
    "--cache-prompts",
  },
  keys = {
    { "<leader>a/", "<cmd>AiderTerminalToggle<cr>", desc = "Open Aider" },
    { "<leader>as", "<cmd>AiderTerminalSend<cr>", desc = "Send to Aider", mode = { "n", "v" } },
    { "<leader>ac", "<cmd>AiderQuickSendCommand<cr>", desc = "Send Command To Aider" },
    { "<leader>ab", "<cmd>AiderQuickSendBuffer<cr>", desc = "Send Buffer To Aider" },
    { "<leader>aa", "<cmd>AiderQuickAddFile<cr>", desc = "Add File to Aider" },
    { "<leader>ad", "<cmd>AiderQuickDropFile<cr>", desc = "Drop File from Aider" },
    { "<leader>aa", "<cmd>AiderTreeAddFile<cr>", desc = "Add File to Aider", ft = "NvimTree" },
    { "<leader>ad", "<cmd>AiderTreeDropFile<cr>", desc = "Drop File from Aider", ft = "NvimTree" },
  },
  dependencies = {
    "folke/snacks.nvim",
    "nvim-telescope/telescope.nvim",
    --- The below dependencies are optional
    "catppuccin/nvim",
  },
  config = true,
}
