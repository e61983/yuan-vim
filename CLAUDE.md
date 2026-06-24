# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository purpose

Personal dotfiles repo. `install.sh` symlinks `gitconfig` to `~/.gitconfig` and `nvim/` to `~/.config/nvim`, and appends `source` lines to `~/.zprofile` for every `helper/*.helper` file (each helper defines zsh functions, not commands to execute at shell-startup time).

There is no build, lint, or test step. Changes are validated by reloading Neovim.

## Neovim config architecture

Entry: `nvim/init.lua` does only `require("yuan.core")` then `require("yuan.lazy")`. Read those two to understand load order.

- `lua/yuan/core/init.lua` — pulls in `core.options` (vim.opt settings) and `core.keymaps` (leader = `,`, window/tab bindings).
- `lua/yuan/lazy.lua` — bootstraps `folke/lazy.nvim` into `stdpath("data")/lazy/`, then `lazy.setup` imports the two plugin directories:
  - `lua/yuan/plugins/` — one file per plugin, each returns a lazy.nvim spec table.
  - `lua/yuan/plugins/lsp/` — LSP/completion specs, imported as a separate group.

To add a plugin: drop a new file in `lua/yuan/plugins/` (or `…/lsp/`) that `return`s a spec table. `lua/yuan/plugins/init.lua` only contributes `plenary.nvim`; it is not a manifest — directory import is automatic.

Plugin versions are pinned in `nvim/lazy-lock.json`. Commit lockfile changes when intentionally updating.

## Language focus

The config is Go-centric:
- `plugins/lsp/nvim-lspconfig.lua` configures `gopls` only (loaded on `ft = "go"`), and registers a `BufWritePre *.go` autocmd that runs gopls organize-imports + format on save.
- `plugins/nvim-dap.lua` wires `nvim-dap` + `nvim-dap-go` (adapter via `dlv dap`) and binds `<F5>` (continue) / `<leader>b` (toggle breakpoint), loaded on `ft = "go"`.

Adding support for another language means a new lspconfig setup block (or a new file) plus matching `ft` lazy-load triggers.

## Editing notes for plugin files

- Each plugin file must `return { … }` (a lazy.nvim spec). Don't call `require("lazy").setup` from within plugin files.
- Use `event`, `ft`, `cmd`, or `keys` for lazy-loading; the existing files demonstrate the pattern (e.g., `ft = "go"`, `event = "VeryLazy"`).
- `lazy.setup` is called with `change_detection.notify = false` and `checker.enabled = true` — saving a plugin file triggers a silent re-resolve.

## Git config

`gitconfig` defines aliases used in commit/PR workflows here:
- Short forms: `co`, `ci`, `st`, `sts`, `br`, `di`, `lo`, `ll`, `lg`, `cp`.
- git-flow wrappers: `start-feature` / `start-bugfix` / `start-hotfix` / `start-release` and matching `finish-*` aliases (each derives the branch name from `HEAD`).
- `publish` pushes the current branch to `origin`.
- `cleanup` prunes remote refs and deletes local branches already merged into `master`/`develop`.
- `diff.external = difft` — `difftastic` is expected on PATH.

## Repository state quirks

- `nvim.bk/` is a backup snapshot, untracked. Do not edit it as part of normal changes.
- Copilot plugins (`plugins/copilot.lua`, `plugins/lsp/copilot-cmp.lua`) were removed; do not reintroduce them unless asked.
