vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "
vim.opt.showcmd = false

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

if vim.g.neovide then
  vim.g.neovide_position_animation_length = 0
  vim.g.neovide_cursor_animation_length = 0.00
  vim.g.neovide_cursor_trail_size = 0
  vim.g.neovide_cursor_animate_in_insert_mode = false
  vim.g.neovide_cursor_animate_command_line = false
  vim.g.neovide_scroll_animation_far_lines = 0
  vim.g.neovide_scroll_animation_length = 0.00
  vim.g.neovide_input_macos_option_key_is_meta = "both"

  local function paste()
    vim.opt.paste = true
    return '"+P'
  end

  vim.keymap.set({ "i", "n" }, "<D-a>", "<Esc>ggVG") -- select all
  vim.keymap.set({ "i", "n" }, "<D-w>", ":tabclose<CR>") -- close tab
  vim.keymap.set({ "i", "n" }, "<D-[>", function()
    vim.cmd "BufferPrevious"
  end) -- previous tab
  vim.keymap.set({ "i", "n" }, "<D-]>", function()
    vim.cmd "BufferNext"
  end) -- next tab
  vim.keymap.set("i", "<D-t>", "<C-o>:tabnew<CR><Esc>") -- new tab (insert)
  vim.keymap.set("n", "<D-t>", ":tabnew<CR>") -- new tab (insert)
  vim.keymap.set("i", "<D-s>", "<C-o>:w<CR>") -- save (insert)
  vim.keymap.set("n", "<D-s>", ":w<CR>") -- save (normal)
  vim.keymap.set("x", "<D-x>", '"+dm0i<Esc>`0') -- cut (include insert hack to fix whichkey issue #518)
  vim.keymap.set("x", "<D-c>", '"+y') -- copy
  vim.keymap.set("i", "<D-v>", "<C-r><C-o>+") -- paste (insert)
  vim.keymap.set("n", "<D-v>", "i<C-r><C-o>+<Esc>l") -- paste (normal)
  vim.keymap.set("x", "<D-v>", '"+P') -- paste (visual)
  vim.keymap.set("c", "<D-v>", "<C-r>+") -- paste (command)
  vim.keymap.set("n", "<D-z>", "u") -- undo
  vim.keymap.set({ "i", "n" }, "<D-q>", function()
    vim.cmd "confirm qa"
  end) -- quit
end

--Show errors in window
vim.diagnostic.config { virtual_text = false }
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

-- Allow clipboard copy paste in neovim
--vim.api.nvim_set_keymap('', '<D-v>', '+p<CR>', { noremap = true, silent = true })
--vim.api.nvim_set_keymap('!', '<D-v>', '<C-R>+', { noremap = true, silent = true })
--vim.api.nvim_set_keymap('t', '<D-v>', '<C-R>+', { noremap = true, silent = true })
--vim.api.nvim_set_keymap('v', '<D-v>', '<C-R>+', { noremap = true, silent = true })

--vim.keymap.set('c', 'q', '<C-w><C-q>') -- Paste visual mode

local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set("n", "C", api.tree.change_root_to_node, opts "CD")
  vim.keymap.set("n", "i", api.node.open.horizontal, opts "Open Horizontal")
  vim.keymap.set("n", "v", api.node.open.vertical, opts "Open Vertical")
end

require("nvim-tree").setup {
  on_attach = my_on_attach,
  update_cwd = true,
  filters = {
    dotfiles = false, -- Set to true to show hidden files
    custom = {}, -- You can add any other custom filters here
  },
  git = {
    enable = false,
  },
  -- update_focused_file = {
  --   enable = true,
  --   update_cwd = true
  -- },
}

local actions = require "telescope.actions"
require("telescope").setup {
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
      },
    },
  },
}

--make it so quickfix window (gd) closes when you open a file
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "qf" },
  command = [[nnoremap <buffer> <CR> <CR>:cclose<CR>]],
})
