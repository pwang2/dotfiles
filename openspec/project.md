# Project Context

## Purpose
Personal dotfiles repository for managing development environment configurations across macOS and Linux systems. Provides consistent shell, editor, terminal, and tooling setup with automated installation via `init.sh`.

## Tech Stack
- **Shell**: Zsh with Oh-My-Zsh framework
- **Editor**: Neovim (Lua-based config with lazy.nvim plugin manager)
- **Terminal**: Alacritty + tmux
- **macOS Automation**: Hammerspoon (Lua)
- **Package Management**: Homebrew (Linuxbrew on Linux), fnm (Node), pyenv (Python), uv (Python)
- **Version Control**: Git with GitHub CLI (`gh`) for authentication

## Project Conventions

### Code Style
- **Lua (Neovim/Hammerspoon)**: 
  - Format with StyLua: 2-space indent, 120 column width, double quotes preferred
  - Lint with luacheck
  - Globals: `vim`, `hs`, `spoon`, `require`
- **Shell Scripts**: 
  - ShellCheck for linting
  - `set -xe` for debugging
  - Use `$HOME` or environment variables for paths
- **Git Config**: 
  - Descriptive aliases (e.g., `l`, `s`, `d`, `ca`, `go`)
  - Default branch: `main`
  - Pull with rebase
  - Auto-setup remote on push

### Architecture Patterns
- **Symlink-based**: `init.sh` symlinks configs from repo to `$HOME` and `$HOME/.config`
- **Modular Neovim**: Plugins organized in `lua/plugins/*.lua`, loaded via lazy.nvim's `import`
- **Cross-platform**: Conditional logic for macOS vs Linux (Homebrew prefix, clipboard commands, terminal features)
- **Shared configs**: `.zshrc_shared` sourced by machine-specific `.zshrc`

### Testing Strategy
- Manual verification after running `init.sh`
- Visual confirmation of terminal colors, fonts, and Neovim UI
- No automated tests (configuration files)

### Git Workflow
- Single `main` branch
- Direct commits for personal use
- Descriptive commit messages
- Use `difftastic` for semantic diffs

## Domain Context
- **Primary user**: Single developer (Peng Wang)
- **Environments**: WSL2 (Linux), macOS
- **Key tools integrated**: kubectl, argo, gh, direnv, fnm, pyenv, zoxide
- **Editor plugins**: LSP, Telescope, Treesitter, CodeCompanion (AI), nvim-cmp, trouble.nvim, lazygit

## Important Constraints
- Configs must work on both macOS and Linux
- Neovim config requires Neovim 0.10+ (uses `vim.uv`, `winborder`)
- Homebrew assumed available (installed by `init.sh` if missing)
- JetBrainsMono Nerd Font required for proper terminal rendering

## External Dependencies
- **GitHub**: Authentication via `gh auth`, credential helper
- **Oh-My-Zsh**: Shell framework with custom plugins (zsh-vi-mode, zsh-autosuggestions, etc.)
- **tmux Plugin Manager (tpm)**: Auto-installed, manages tmux plugins
- **Language servers**: Managed via Mason in Neovim
