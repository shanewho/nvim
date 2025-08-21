# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a personal Neovim configuration built on top of NvChad v2.5, a popular Neovim distribution. The configuration is structured as a modular Lua-based setup with custom plugins and configurations for development workflow optimization.

## Architecture & Structure

### Core Configuration Pattern
- **Base**: Uses NvChad v2.5 as the foundation with lazy.nvim plugin manager
- **Entry Point**: `init.lua` bootstraps lazy.nvim and loads the configuration chain
- **Plugin Management**: All plugins are managed through lazy.nvim with configs in `lua/plugins/`
- **Configuration Chain**: `init.lua` → `configs/lazy.lua` → `lua/plugins/` → individual configs

### Key Configuration Files
- `init.lua`: Main entry point, bootstraps lazy.nvim, handles Neovide-specific settings
- `lua/chadrc.lua`: NvChad theme configuration (currently using catppuccin)
- `lua/configs/lazy.lua`: Lazy.nvim configuration with performance optimizations
- `lua/configs/lspconfig.lua`: LSP server configurations and diagnostic settings
- `lua/mappings.lua`: Custom key mappings and LSP-related shortcuts
- `lua/options.lua`: Neovim options and settings

### Plugin Organization
Plugins are organized in `lua/plugins/` with each major functionality in separate files:
- `init.lua`: Core plugins (conform, nvim-cmp, lspconfig)
- `dap.lua`: Debug Adapter Protocol configuration for JavaScript/TypeScript
- `typescript-tools.lua`: TypeScript-specific tooling
- `claude-code.lua`, `lazygit.lua`, `menu.lua`, `rooter.lua`: Utility plugins

### LSP & Development Tools
- **TypeScript**: Uses typescript-tools.nvim instead of default ts_ls
- **Formatting**: Conform.nvim for code formatting on save
- **Debugging**: Full DAP setup for JavaScript/TypeScript with vscode-js-debug
- **Diagnostics**: Custom floating diagnostic windows on cursor hold

## Development Workflow

### Plugin Development Pattern
When adding new plugins:
1. **ALWAYS create new files** in `lua/plugins/` as siblings to existing plugin files (e.g., `typescript-tools.lua`, `dap.lua`)
2. **NEVER modify existing plugin files** unless specifically updating that plugin's configuration
3. Follow lazy.nvim plugin specification format with proper return table structure
4. Use lazy-loading with appropriate triggers (ft, keys, event)
5. Keep configurations modular and specific to plugin functionality
6. Name files descriptively based on the plugin's primary function

### Configuration Modifications
- Theme changes: Modify `lua/chadrc.lua`
- Key mappings: Add to `lua/mappings.lua`
- LSP configurations: Extend `lua/configs/lspconfig.lua`
- New plugins: Add to appropriate file in `lua/plugins/`

### Debugging Setup
The DAP configuration automatically downloads and sets up vscode-js-debug for JavaScript/TypeScript debugging. Key mappings:
- `<leader>d`: Toggle breakpoint
- `<leader>dc`: Continue debugging
- `<C-'>`: Step over
- `<C-;>`: Step into
- `<C-:>`: Step out

### Special Features
- **Neovide Integration**: Custom key mappings for macOS-style shortcuts when running in Neovide
- **NvimTree**: Custom mappings with Aider integration (`m` key to add files to Aider)
- **TypeScript Tools**: Comprehensive TypeScript utilities with leader-prefixed shortcuts
- **Diagnostic Display**: Automatic floating diagnostics on cursor hold instead of virtual text

### Performance Optimizations
- Lazy-loading enabled by default for all plugins
- Multiple built-in Neovim plugins disabled for faster startup
- Base46 caching for theme performance

## Key Mappings Reference

### LSP Navigation
- `gd`: Go to definition
- `gi`: Go to implementation
- `gy`: Go to type definition
- `gr`: Go to references
- `<leader>r`: Rename symbol
- `<leader>a` / `<leader>ca`: Code actions

### TypeScript Tools
- `<leader>lo`: Organize imports
- `<leader>lO`: Sort imports
- `<leader>lu`: Remove unused variables
- `<leader>lR`: Remove unused imports
- `<leader>lF`: Fix all issues
- `<leader>la`: Add missing imports

### File Navigation
- `<leader>tf`: Find file in NvimTree
- `<leader>s`: Split window
- `<leader>q`: Close window