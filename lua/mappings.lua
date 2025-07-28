require "nvchad.mappings"

local map = vim.keymap.set

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>") -- Go to Definition
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>") -- Go to Implementation
--map("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>") -- Rename Symbol
map("n", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>") -- Code Actions
map("n", "gy", "<cmd>lua vim.lsp.buf.type_definition()<CR>") -- Type Definition
map("n", "sh", "<cmd>lua vim.lsp.buf.signature_help()<CR>") -- Signature Help
map("n", "<leader>lo", "<cmd>TSToolsOrganizeImports<cr>")
map("n", "<leader>lO", "<cmd>TSToolsSortImports<cr>")
map("n", "<leader>lu", "<cmd>TSToolsRemoveUnused<cr>")
map("n", "<leader>lz", "<cmd>TSToolsGoToSourceDefinition<cr>")
map("n", "<leader>lR", "<cmd>TSToolsRemoveUnusedImports<cr>")
map("n", "<leader>lF", "<cmd>TSToolsFixAll<cr>")
map("n", "<leader>r", require "nvchad.lsp.renamer")
map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action)
map("n", "gr", vim.lsp.buf.references)
map("n", "<leader>la", "<cmd>TSToolsAddMissingImports<cr>")

vim.api.nvim_set_keymap("t", "<D-v>", '<C-M><C-n>"+pi', { noremap = true }) --Allow paste into floating term

map("n", "<leader>tf", "<cmd>NvimTreeFindFile<cr>")

map("n", "<leader>s", "<cmd>split<cr>")
map("n", "<leader>q", "<cmd>close<cr>")

vim.keymap.set("n", "<leader>te", function()
  require("pretty-ts-errors").show_formatted_error()
end, { desc = "Show TS error" })
-- Show all errors in file
vim.keymap.set("n", "<leader>tE", function()
  require("pretty-ts-errors").open_all_errors()
end, { desc = "Show all TS errors" })
-- Toggle auto-display
vim.keymap.set("n", "<leader>tt", function()
  require("pretty-ts-errors").toggle_auto_open()
end, { desc = "Toggle TS error auto-display" })
