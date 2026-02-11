return {
  { "folke/which-key.nvim", enabled = false },
  { "windwp/nvim-autopairs", enabled = false },
  { "hrsh7th/nvim-cmp", enabled = false },
  { "NvChad/nvim-colorizer.lua", enabled = false },
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "saghen/blink.cmp",
    lazy = false, -- lazy loading handled internally
    dependencies = "rafamadriz/friendly-snippets",
    version = "v0.*",
    opts = {
      keymap = {
        preset = "enter",
        ["<tab>"] = { "accept", "fallback" },
        --["."] = { "accept", "fallback" },
      },
      completion = {
        list = {
          selection = {
            --preselect = false,
          },
        },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },
      signature = { enabled = true },
    },
    opts_extend = { "sources.default" },
  },
  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- {
  --   "nvchad/menu",
  --   config = function()
  --     require "configs.plugins.menu"
  --   end
  -- },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
