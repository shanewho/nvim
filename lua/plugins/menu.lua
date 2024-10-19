local lspMenu = {

  {
    name = "Goto Definition",
    cmd = vim.lsp.buf.definition,
    rtxt = "gd",
  },

  {
    name = "Goto Implementation",
    cmd = vim.lsp.buf.implementation,
    rtxt = "gi",
  },

  { name = "separator" },

  {
    name = "Show signature help",
    cmd = vim.lsp.buf.signature_help,
    rtxt = "<leader>sh",
  },

  {
    name = "Show References",
    cmd = vim.lsp.buf.references,
    rtxt = "gr",
  },

  { name = "separator" },

  {
    name = "Format Buffer",
    cmd = function()
      local ok, conform = pcall(require, "conform")

      if ok then
        conform.format { lsp_fallback = true }
      else
        vim.lsp.buf.format()
      end
    end,
    rtxt = "<leader>fm",
  },

  {
    name = "Rename",
    cmd = require "nvchad.lsp.renamer",
  },

  {
    name = "Code Actions",
    cmd = vim.lsp.buf.code_action,
    rtxt = "<leader>ca",
  },
}
return {
  "nvchad/menu",
  lazy = false,
  config = function()
    local defaultMenu = {
      {
        name = "Tools",
        items = {
          {
            name = "Edit Config",
            cmd = function()
              --vim.cmd "tabnew"
              local conf = vim.fn.stdpath "config"
              vim.cmd("tcd " .. conf .. " | e init.lua")
            end,
          },

          {
            name = "Edit Menu Config",
            cmd = function()
              --vim.cmd "tabnew"
              local conf = vim.fn.stdpath "config"
              vim.cmd("tcd " .. conf .. " | e lua/plugins/menu.lua")
            end,
            rtxt = "ed",
          },
          { name = "separator" },
          {
            name = "  Open in terminal",
            hl = "ExRed",
            cmd = function()
              local old_buf = require("menu.state").old_data.buf
              local old_bufname = vim.api.nvim_buf_get_name(old_buf)
              local old_buf_dir = vim.fn.fnamemodify(old_bufname, ":h")

              local cmd = "cd " .. old_buf_dir

              -- base46_cache var is an indicator of nvui user!
              if vim.g.base46_cache then
                require("nvchad.term").new { cmd = cmd, pos = "sp" }
              else
                vim.cmd "enew"
                vim.fn.termopen { vim.o.shell, "-c", cmd .. " ; " .. vim.o.shell }
              end
            end,
          },
        },
      },
      { name = "separator" },
      {
        name = "Format Buffer",
        cmd = function()
          local ok, conform = pcall(require, "conform")

          if ok then
            conform.format { lsp_fallback = true }
          else
            vim.lsp.buf.format()
          end
        end,
        rtxt = "<leader>fm",
      },

      {
        name = "Code Actions",
        cmd = vim.lsp.buf.code_action,
        rtxt = "<leader>ca",
      },

      { name = "separator" },

      {
        name = "  Lsp Actions",
        hl = "Exblue",
        --items = "lsp",
        items = lspMenu,
      },

      {
        name = "Open Code",
        cmd = function()
          vim.cmd "tabnew"
          vim.cmd "tcd ~/code/"
          vim.cmd "NvimTreeOpen"
        end,
        rtxt = "ed",
      },

      { name = "separator" },

      {
        name = "View Actions",
        items = {
          {
            name = "Vertical Split",
            cmd = function()
              vim.cmd "vsplit"
            end,
          },
          {
            name = "Horizontal Split",
            cmd = function()
              vim.cmd "split"
            end,
          },
          { name = "separator" },
          {
            name = "Horizontal Terminal",
            cmd = function()
              vim.cmd "split"
              vim.cmd "term"
            end,
          },
          {
            name = "Vertical Terminal",
            cmd = function()
              vim.cmd "vsplit"
              vim.cmd "term"
            end,
          },
        },
      },
    }

    require("typescript-tools").setup {}

    vim.keymap.set("n", "<RightMouse>", function()
      vim.cmd.exec '"normal! \\<RightMouse>"'

      local options = vim.bo.ft == "NvimTree" and "nvimtree" or defaultMenu
      require("menu").open(options, { mouse = true })
    end, {})
  end,
}
