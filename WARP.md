# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Quick Start

This is a modern Neovim configuration using lazy.nvim for plugin management. Leader key is `<Space>`. Essential external tools: `git`, `ripgrep`, `make`, `node`, `lazygit`. AI features require API keys in `lua/config/env.lua`.

## Essential Commands

### Plugin Management
```
:Lazy                    # Open lazy.nvim dashboard
:Lazy install           # Install missing plugins
:Lazy update            # Update all plugins
:Lazy sync              # Clean, install, and update
:Lazy health            # Check plugin health
```

### LSP & Tool Management  
```
:Mason                  # Open Mason dashboard
:MasonInstall <tool>    # Install LSP server/formatter
:MasonUpdate            # Update all tools
:LspInfo               # Show LSP client info
:NullLsInfo            # Show none-ls sources
```

### Health Checks
```
:checkhealth           # Complete system health check  
:checkhealth mason     # Check Mason tools
:checkhealth lazy      # Check lazy.nvim
:checkhealth nvim-treesitter  # Check treesitter parsers
```

### Formatting & Diagnostics
```
<Alt-F>                # Format current buffer
<leader>ud             # Toggle diagnostics
<leader>ca             # Show code actions
```

Run `:Lazy sync` after config changes. Use `:Mason` to install language servers for new filetypes.

## Architecture Overview

```
init.lua
├── Bootstrap lazy.nvim
├── Load config/vim-options.lua (vim settings, leader key)
├── Load all plugins/ files (lazy.nvim auto-discovery)
└── Load config/custom-keymaps.lua (additional keymaps)

Plugin Stack:
┌─────────────────┐    ┌──────────────┐    ┌─────────────┐
│   lazy.nvim     │───▶│  plugins/    │───▶│  Runtime    │
│   (manager)     │    │  *.lua files │    │  Features   │
└─────────────────┘    └──────────────┘    └─────────────┘
```

### Core Subsystems

- **Plugin Management**: lazy.nvim with per-plugin files in `plugins/`
- **LSP Stack**: mason → mason-lspconfig → nvim-lspconfig
  - Pre-configured: lua_ls, pyright, ruff, vtsls, vue_ls, html
  - Custom vtsls+vue_ls integration for Vue.js TypeScript support
- **Treesitter**: Syntax highlighting, folding (foldmethod=expr, foldlevel=99)
- **Completion**: nvim-cmp + LuaSnip + friendly-snippets + custom Python snippets
- **UI/UX**: Dual picker system (telescope + snacks), catppuccin theme, lualine
- **AI Integration**: neoai.nvim with OpenAI/Groq support

## Keybindings & Workflow

Leader key: `<Space>`

### Navigation & Windows
| Key | Action |
|-----|--------|
| `<Ctrl-Left/Right/Up/Down>` | Resize splits |
| `<Ctrl-h/l>` | Previous/next tab |
| `<leader>tc` | Close tab |

### LSP Navigation (Snacks)
| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `grr` | Find references |
| `gI` | Go to implementation |
| `gy` | Go to type definition |
| `K` | Hover documentation |
| `gv` | Definition in vertical split |
| `gs` | Definition in horizontal split |

### File & Text Search
| Key | Action |
|-----|--------|
| `<leader>fz` | Find files (telescope) |
| `<leader>fZ` | Find files including hidden |
| `<leader>fg` | Multi live grep (telescope) |
| `<leader>fG` | Multi live grep with hidden |
| `<leader>/` | Grep (snacks) |
| `<leader>ff` | Buffer lines (snacks) |
| `<leader>fo` | LSP document symbols |
| `<leader>fk` | Find keymaps |
| `<leader>fh` | Find help tags |
| `<leader>fp` | Find plugin source files |

### Toggle Commands (Snacks)
| Key | Action |
|-----|--------|
| `<leader>us` | Toggle spelling |
| `<leader>uw` | Toggle word wrap |
| `<leader>uL` | Toggle relative numbers |
| `<leader>ul` | Toggle line numbers |
| `<leader>ud` | Toggle diagnostics |
| `<leader>uh` | Toggle inlay hints |

### Tools & Utilities
| Key | Action |
|-----|--------|
| `<leader>e` | File explorer (snacks) |
| `<leader>tt` | Toggle terminal |
| `<leader>gl` | Open lazygit |
| `<leader>gB` | Git browse in browser |
| `<leader>fd` | Pick two files and diff |
| `<leader>fx` | Exit diff mode |

## Custom Extensions & Integrations

### Telescope Multi-Grep
Advanced search syntax in `<leader>fg`:
```
search_term --include=[*.lua,*.js] --exclude=[node_modules/*,*.min.js]
```
Use `<leader>fG` to include hidden files.

### File Diff Workflow
1. `<leader>fd` - Opens file picker
2. Select first file, press Enter
3. Select second file, press Enter  
4. Files open in diff mode in new tab
5. `<leader>fx` to exit diff mode

### Snacks vs Telescope
- **Telescope**: File finding, project-wide grep, LSP symbols
- **Snacks**: Buffer lines, diagnostics, command history, workspace symbols
- Both integrated seamlessly with consistent keybinds

### NeoAI Configuration
Requires `lua/config/env.lua` (git-ignored):
```lua
local M = {}
M.OPENAI_API_KEY = "your-openai-key"
M.GROQ_API_KEY = "your-groq-key"  
return M
```
- Default: OpenAI o4-mini model
- Alternative: Groq deepseek-r1-distill-llama-70b
- Database: `~/.local/share/nvim/neoai.db`

### Vue.js + TypeScript Integration
Special vtsls+vue_ls bridge handles TypeScript in Vue SFCs:
- Vue Language Server forwards TypeScript requests to vtsls
- Enables proper IntelliSense in `<script setup lang="ts">`
- Auto-configured with Mason-installed servers

## Environment & Prerequisites

### Required External Tools
```bash
# Core tools (usually pre-installed)
git, ripgrep, make, curl

# Language runtimes  
node, npm/pnpm, python3, pip

# Optional but recommended
lazygit                 # Git TUI integration
```

### Mason Tool Directory
Language servers install to: `~/.local/share/nvim/mason/packages/`

### Setup Steps
1. Clone/symlink this config to `~/.config/nvim/`
2. Install external prerequisites
3. Create `lua/config/env.lua` with API keys (optional)
4. Launch nvim - lazy.nvim auto-bootstraps on first run
5. Run `:checkhealth` to verify setup

### Custom Snippets
Python DRF snippets in `lua/config/snippets/python.lua`:
- `drfser` - ModelSerializer template
- `drfview` - ModelViewSet template  
- `cls_init` - Class with __init__ template

## Troubleshooting

### Common Issues
- **LSP not working**: Check `:LspInfo`, run `:Mason` to install servers
- **Formatting fails**: Verify `:NullLsInfo`, install formatters via Mason
- **Plugins not loading**: Run `:Lazy health`, check plugin specs
- **Vue TypeScript issues**: Ensure both vtsls and vue_ls are installed

### Performance
- Treesitter folding enabled (level 99 = most expanded by default)
- Lazy loading for most plugins 
- Snacks bigfile handling for large files

### Debug Commands
```
:Lazy profile            # Plugin load timing
:LspLog                 # LSP server logs  
_G.dd(vim.lsp.get_clients())  # Debug LSP clients (snacks debug)
```

Run `:checkhealth` first for systematic diagnosis of issues.
