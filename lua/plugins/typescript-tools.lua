return {
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  ft = { "typescript", "typescriptreact" },
  opts = {
    config = function()
      require("typescript-tools").setup {
        on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
      }
    end,
    --settings = {
    ----tsserver_max_memory = 8072,
    --expose_as_code_action = "all",
    ----separate_diagnostic_server = false,
    --tsserver_file_preferences = {
    --includeInlayParameterNameHints = "all",
    --includeCompletionsForModuleExports = true,
    --quotePreference = "auto",
    --allowImportingTsExtensions = true,
    --},
    --},
  },
}
