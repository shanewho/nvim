local options = {
  --log_level = vim.log.levels.DEBUG,
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettierd", stop_after_first = true },
    html = { "prettierd", stop_after_first = true },
    typescript = { "prettierd", stop_after_first = true },
    typescriptreact = { "prettierd", stop_after_first = true },
    javascript = { "prettierd", stop_after_first = true },
    markdown = { "prettierd", stop_after_first = true },
  },
  format_on_save = {
    --These options will be passed to conform.format()
    timeout_ms = 2000,
    lsp_fallback = true,
  },
}

return options
