# AGENTS.md - Dotfiles Repository Guide

> Guide for AI agents working in this dotfiles repository.

## Repository Overview

Personal dotfiles for development environment configuration:
- **Neovim config** (`config/nvim/`) - Lua-based, using lazy.nvim
- **Shell config** - zsh with oh-my-zsh, tmux
- **Hammerspoon** (macOS only) - window management, hotkeys
- **Alacritty** - terminal emulator config

## Build/Lint/Test Commands

### Lua (Neovim config)

```bash
# Format Lua files
stylua config/nvim/lua/

# Format single file
stylua config/nvim/lua/plugins/lsp.lua

# Lint Lua files
luacheck config/nvim/lua/

# Lint single file
luacheck config/nvim/lua/plugins/lsp.lua
```

### Shell Scripts

```bash
# Lint shell scripts
shellcheck init.sh
shellcheck .zshrc_shared
```

### Setup/Installation

```bash
# Run setup script (creates symlinks)
./init.sh
```

## Code Style Guidelines

### Lua (Neovim Configuration)

**Formatting** (enforced by `stylua.toml`):
- Column width: 120
- Indent: 2 spaces
- Line endings: Unix
- Quote style: Auto-prefer double quotes
- Always use parentheses for function calls

**Linting** (enforced by `.luacheckrc`):
- Max line length: 140 characters
- Allowed globals: `vim`, `hs`, `spoon`, `require`

**Imports/Requires**:
```lua
-- Local requires at top of file
local M = {}

-- Lazy require pattern for plugins
dependencies = {
  "nvim-lua/plenary.nvim",
  "folke/trouble.nvim",
}
```

**Naming Conventions**:
- Variables: `snake_case`
- Functions: `snake_case`
- Constants: `SCREAMING_SNAKE_CASE` (rarely used)
- Module tables: `M` for local module
- Plugin specs: Return table directly from file

**Plugin Spec Pattern**:
```lua
-- Each plugin in its own file under lua/plugins/
return {
  "author/plugin-name",
  event = { "BufReadPre", "BufNewFile" },  -- Lazy loading
  dependencies = { ... },
  opts = { ... },  -- For simple configs
  config = function()  -- For complex configs
    require("plugin").setup({ ... })
  end,
}
```

**LSP Keybinding Pattern**:
```lua
local keygen = function(key, cmd, desc, mode)
  if desc then opts.desc = desc end
  if mode == nil then mode = "n" end
  vim.keymap.set(mode, key, cmd, opts)
end
```

### Shell Scripts (Bash/Zsh)

**Shebang**:
```bash
#! /bin/bash          # For bash scripts
#!/usr/bin/env zsh    # For zsh scripts
```

**Error Handling**:
```bash
set -xe  # Exit on error, print commands
```

**Variable Quoting**:
```bash
# Always quote variables
rm -rf "${HOME}/.config/${config}"
ln -s "${CWD}/config/${config}" "$HOME/.config/${config}"
```

**Shellcheck Directives**:
```bash
# shellcheck disable=SC2012,SC2086  # At top of file
#shellcheck shell=bash disable=2034,2206  # For zsh files
```

### Git Configuration

**Aliases** (from `gitconfig`):
- `git l` - Short log with graph
- `git s` - Short status
- `git d` - Diff with stat
- `git ca` - Add all and commit
- `git go <branch>` - Checkout or create branch
- `git amend` - Amend last commit

**Commit Style**:
- Use conventional commits when appropriate
- Keep messages concise
- Default branch: `main`

## File Organization

```
dotfiles/
├── config/
│   ├── nvim/
│   │   ├── init.lua           # Entry point, highlights, autocmds
│   │   └── lua/
│   │       ├── config/
│   │       │   └── lazy.lua   # Lazy.nvim bootstrap, vim options
│   │       ├── plugins/       # One file per plugin
│   │       └── utils/         # Utility modules
│   ├── alacritty/             # Terminal config
│   └── mcphub/                # MCP server config
├── hammerspoon/               # macOS automation
├── .tmux.conf                 # Tmux configuration
├── .zshrc_shared              # Shell config (sourced by .zshrc)
├── gitconfig                  # Git config (symlinked to ~/.gitconfig)
└── init.sh                    # Setup script
```

## Error Handling Patterns

### Lua
```lua
-- Protected calls for optional features
local ok, err = pcall(require("lint").try_lint)
if not ok then
  vim.notify("Linting failed: " .. tostring(err), vim.log.levels.ERROR)
end

-- Check file existence
local uv = require("luv")
if uv.fs_stat(path .. "/.luarc.json") then
  return
end
```

### Shell
```bash
# Check command exists before using
command -v kubectl >/dev/null 2>&1 && _evalcache kubectl completion zsh

# Directory existence checks
[ ! -d $ZPLUGINS/zsh-autosuggestions ] && git clone ...
```

## Key Neovim Settings

- Leader key: `<Space>`
- Local leader: `;`
- Tab width: 2 spaces (expandtab)
- No line numbers by default
- Clipboard: `unnamedplus` (system clipboard)
- Format on save enabled (conform.nvim)

## Formatters by Language

| Language   | Formatter           |
|------------|---------------------|
| Lua        | stylua              |
| Python     | ruff_format         |
| TypeScript | prettier            |
| JavaScript | prettier            |
| JSON/JSONC | prettier            |
| CSS        | prettier            |
| HTML       | prettier            |
| Vue        | prettier            |
| Rust       | rustfmt             |
| Java       | google_java_format  |
| Shell      | shfmt               |
| TOML       | taplo               |

## Linters by Language

| Language   | Linter    |
|------------|-----------|
| Lua        | luacheck  |
| TypeScript | eslint_d  |
| JavaScript | eslint_d  |
| Vue        | eslint_d  |
| Python     | ruff      |
| YAML       | yamllint  |
| Shell      | shellcheck (via bashls) |

## Important Notes

1. **No tests** - This is a dotfiles repo, no test suite exists
2. **Symlink-based** - Files are symlinked to home directory via `init.sh`
3. **Platform-aware** - Some configs differ between macOS and Linux
4. **Lazy loading** - Neovim plugins are lazy-loaded for performance
5. **Mason** - LSP servers installed via mason.nvim
