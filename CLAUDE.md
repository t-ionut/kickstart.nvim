# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal Neovim (0.12+) configuration, originally forked from [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) but no longer tracking upstream (upstream moved to `vim.pack`; this config stays on lazy.nvim).

```
init.lua                 -- leader, global flags (have_nerd_font, enable_copilot), requires config.*
lua/config/
  options.lua            -- vim.o options, diagnostics, providers disabled, Mason bin on PATH
  filetypes.lua          -- vim.filetype.add: docker compose, Helm charts
  keymaps.lua            -- plugin-independent keymaps
  autocmds.lua
  lazy.lua               -- lazy.nvim bootstrap + setup { spec = { import = 'plugins' } }
lua/plugins/<area>.lua   -- one lazy.nvim spec file per area, auto-imported
after/lsp/<server>.lua   -- per-server LSP settings, merged over nvim-lspconfig defaults
```

## Lua Formatting

All Lua must be formatted with **stylua** (`.stylua.toml`: 160 cols, 2 spaces, single quotes, no call parens, `collapse_simple_statement = "Always"`). CI (`.github/workflows/stylua.yml`) enforces it. Mason installs stylua at `~/.local/share/nvim/mason/bin/stylua`.

```sh
stylua --check .
stylua .
```

## Plugin System

- **lazy.nvim**; every file in `lua/plugins/` returns a spec and is imported automatically. Add new plugins as a new file or to the matching area file.
- `lazy-lock.json` is tracked — commit it when plugins are updated.
- Keep plugins lazy-loaded (`event`/`keys`/`cmd`/`ft`). Note: a `dependencies` entry always loads with its parent, so plugins that should load on their own event need their own top-level spec.
- luarocks support is disabled (`rocks = { enabled = false }`).

## Architecture

| File | Contents |
|---|---|
| `lsp.lua` | `servers` list (enabled via `vim.lsp.enable`), Mason `tools` list, `LspAttach` keymaps, lazydev, venv-selector, fidget, opt-in Copilot |
| `format.lua` | conform.nvim, format on save. Python: ruff organize imports + ruff format; JS/TS/JSON/YAML/CSS/MD/HTML: prettierd; Django templates: djlint; sh: shfmt; terraform: terraform_fmt |
| `lint.lua` | nvim-lint: hadolint, tflint, djlint, actionlint (only for `.github/workflows/*`) |
| `completion.lua` | blink.cmp + LuaSnip (+ lazydev source for Lua) |
| `treesitter.lua` | nvim-treesitter `main` branch; parsers auto-install on first FileType; treesitter-context |
| `snacks.lua` | snacks.nvim: picker (all `<leader>s*`), explorer, lazygit, git pickers, terminal, notifier, `vim.ui.*`, LSP pickers on `LspAttach` |
| `git.lua` | gitsigns (hunk keymaps) + diffview.nvim |
| `dap.lua` | nvim-dap + dap-view; debugpy (incl. Django runserver config) and js-debug (Node + Chrome) |
| `test.lua` | neotest: pytest, vitest, jest |
| `ai.lua` | claudecode.nvim |
| `editor.lua` | which-key groups, flash, todo-comments, mini (icons, ai, surround, statusline), guess-indent |

**LSP servers:** basedpyright, ruff, vtsls, eslint, tailwindcss (only in Tailwind projects), jsonls/yamlls (SchemaStore), taplo, dockerls, docker_compose_language_service, helm_ls, terraformls, bashls, nginx_language_server, lua_ls. To add one: append its lspconfig name to `servers` in `lua/plugins/lsp.lua` and put settings in `after/lsp/<name>.lua` (not `lsp/`, which would be overridden by nvim-lspconfig's own defaults).

**Performance notes:** remote-plugin providers are disabled (pyenv python3 probing cost ~2.5s per Python file). Mason and mason-tool-installer load on `VeryLazy`; the install check runs at most once per day (`:MasonToolsInstall` forces it).

## Key Keymaps

`cheatsheet.md` (opened with `<leader>?`) is the full, user-facing keymap reference — update it whenever a keymap is added, changed or removed.

| Key | Action |
|-----|--------|
| `<Space>` | Leader |
| `<leader>sf` / `<leader>st` / `<leader>sw` | Find files / grep / grep word |
| `<leader><leader>` / `<leader>/` | Buffers / search in buffer |
| `<leader>tn` / `<leader>e` | Toggle explorer / reveal file |
| `grd` `grr` `gri` `grt` `grn` `gra` `gO` `gW` | LSP definition, references, impl, type, rename, action, symbols |
| `<leader>f` | Format buffer |
| `]c` / `[c`, `<leader>h*` | Git hunks: navigate, stage/reset/preview/blame |
| `<leader>bl` / `<leader>tb` | Toggle inline git blame |
| `<leader>gg` `<leader>gd` `<leader>gD` `<leader>gh` | Lazygit, diffview toggle, branch vs default, file history |
| `<leader>d*`, `<F5>` `<F10>` `<F11>` `<F12>` | Debugging |
| `<leader>r*`, `]t` / `[t` | Tests (run nearest/file/debug, summary, output), failed-test jumps |
| `<leader>a*` | Claude Code (toggle, send selection, accept/deny diff) |
| `gs` / `gS` | Flash jump / treesitter select (mini.surround keeps `sa`/`sd`/`sr`) |
| `[b` / `]b` | Previous/next buffer (built-in) |
| `<leader>jq` | Format JSON with jq |
| `<leader>?` | Open the cheat sheet |

## External Requirements

`git`, `rg`, `fd`, `make`, a C compiler, `node`/`npm`, `lazygit`. LSP servers, formatters, linters and debug adapters are managed by Mason (`:Mason`).
