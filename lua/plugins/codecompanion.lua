return {
  "olimorris/codecompanion.nvim",
  cmd = {
    "CodeCompanion",
    "CodeCompanionActions",
    "CodeCompanionChat",
    "CodeCompanionCmd",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    display = {
      diff = {
        enabled = false,
      },
    },
    strategies = {
      chat = {
        adapter = "anthropic",
      },
      inline = {
        adapter = "anthropic",
      },
    },
    adapters = {
      inline = {
        openai = {
          schema = {
            model = {
              default = "gpi-4o",
            },
          },
        },
      },
      chat = {
        slash_commands = {
          ["file"] = {
            callback = "strategies.chat.slash_commands.file",
            description = "Select a file using Telescope",
            opts = {
              provider = "telescope", -- Other options include 'default', 'mini_pick', 'fzf_lua'
              contains_code = true,
            },
          },
        },
        openai = {
          schema = {
            model = {
              default = "gpi-4o",
            },
          },
        },
      },
    },
  },
}
