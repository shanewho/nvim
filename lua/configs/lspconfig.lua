-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

-- capabilities and on_init are set globally by defaults() via vim.lsp.config("*", ...)
-- just enable the servers you want
vim.lsp.enable { "html", "cssls" }
