require("conform").formatters["ts-standard"] = {
  command = "ts-standard", -- The command to run for formatting
  filetypes = { "typescript", "typescriptreact" }, -- Filetypes this formatter applies to
  args = { "--fix", "--stdin" },
  stdin = true, -- Whether to pipe buffer content via stdin
}

local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    -- css = { "prettier" },
    -- html = { "prettier" },
    typescript = { "ts-standard" },
    typescriptreact = { "ts-standard" },
    javascript = { "standard" },
  },

  format_on_save = {
    --These options will be passed to conform.format()
    timeout_ms = 2000,
    lsp_fallback = true,
  },
}

return options
