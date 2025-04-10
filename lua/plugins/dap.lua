local install_path = vim.fn.stdpath "data" .. "/lazy/vscode-js-debug"

return {
  "mfussenegger/nvim-dap",
  lazy = false,
  dependencies = {
    "nvim-neotest/nvim-nio",
    "rcarriga/nvim-dap-ui",
    { -- download and extract pre-built debugger
      "microsoft/vscode-js-debug",
      build = function()
        -- Extract URL from the AAAA comment
        local url = "https://github.com/microsoft/vscode-js-debug/releases/download/v1.97.1/js-debug-dap-v1.97.1.tar.gz"
        --local install_path = vim.fn.stdpath "data" .. "/lazy/vscode-js-debug"
        vim.fn.mkdir(install_path, "p")
        vim.fn.system {
          "curl",
          "-L",
          url,
          "-o",
          install_path .. "/vscode-js-debug.tar.gz",
        }
        vim.fn.system {
          "tar",
          "-xzf",
          install_path .. "/vscode-js-debug.tar.gz",
          "-C",
          install_path,
        }
        vim.fn.delete(install_path .. "/vscode-js-debug.tar.gz")
      end,
    },
  },
  keys = {
    -- normal mode is default
    {
      "<leader>d",
      function()
        require("dap").toggle_breakpoint()
      end,
    },
    {
      "<leader>c",
      function()
        require("dap").continue()
      end,
    },
    {
      "<C-'>",
      function()
        require("dap").step_over()
      end,
    },
    {
      "<C-;>",
      function()
        require("dap").step_into()
      end,
    },
    {
      "<C-:>",
      function()
        require("dap").step_out()
      end,
    },
  },
  config = function()
    -- require("dap-vscode-js").setup {
    --   debugger_path = vim.fn.stdpath "data" .. "/lazy/vscode-js-debug",
    --   adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
    -- }

    local function get_pkg_path(pkg, path)
      pcall(require, "mason")
      local root = vim.env.MASON or (vim.fn.stdpath "data" .. "/mason")
      path = path or ""
      local ret = root .. "/packages/" .. pkg .. "/" .. path
      return ret
    end
    require("dap").adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "9231",
      executable = {
        command = "node",
        args = {
          install_path .. "/js-debug/src/dapDebugServer.js",
          --"/Users/shane/Downloads/js-debug/src/dapDebugServer.js",
          "9231",
        },
      },
    }

    local js_based_languages = {
      "typescript",
      "javascript",
      "typescriptreact",
      "javascriptreact",
      "typescriptreact",
      "typescript",
      "vue",
    }

    for _, language in ipairs(js_based_languages) do
      require("dap").configurations[language] = {
        -- attach to a node process that has been started with
        -- `--inspect` for longrunning tasks or `--inspect-brk` for short tasks
        -- npm script -> `node --inspect-brk ./node_modules/.bin/vite dev`
        {
          type = "pwa-chrome",
          name = "Launch Chrome to debug client",
          request = "launch",
          url = "http://localhost:5173",
          sourceMaps = true,
          protocol = "inspector",
          port = 9222,
          webRoot = "${workspaceFolder}/src",
          -- skip files from vite's hmr
          skipFiles = { "**/node_modules/**/*", "**/@vite/*", "**/src/client/*", "**/src/*" },
        },
        {
          name = "Next.js: debug server-side",
          type = "pwa-node",
          request = "attach",
          port = 9230,
          skipFiles = { "<node_internals>/**", "node_modules/**" },
          cwd = "${workspaceFolder}",
          sourceMapPathOverrides = {
            "webpack-internal:///(rsc)/*",
            "apps/my-app/*",
          },
        },
        -- only if language is javascript, offer this debug action
        language == "javascript"
            and {
              -- use nvim-dap-vscode-js's pwa-node debug adapter
              type = "pwa-node",
              -- launch a new process to attach the debugger to
              request = "launch",
              -- name of the debug action you have to select for this config
              name = "Launch file in new node process",
              -- launch current file
              program = "${file}",
              cwd = "${workspaceFolder}",
            }
          or nil,
      }
    end

    require("dapui").setup()
    local dap, dapui = require "dap", require "dapui"
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open { reset = true }
    end
    dap.listeners.before.event_terminated["dapui_config"] = dapui.close
    dap.listeners.before.event_exited["dapui_config"] = dapui.close
  end,
}
