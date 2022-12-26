-- shizukaIDE
-- Jak Crow 2022 – ∞

-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ Core
-- └─────────────────────────────────────────────────────────────────────────────
require 'shizuka.opts'
require 'shizuka.keys'
require 'shizuka.plugman'
require 'shizuka.faststart'


-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ UI
-- └─────────────────────────────────────────────────────────────────────────────
-- Core
require 'shizuka.tabline'
require 'shizuka.sidebarL'
require 'shizuka.scrollbar'
require 'shizuka.statusline'
require 'shizuka.telescope'
-- require 'shizuka.indentline'

-- Colors
require 'shizuka.color'
require 'shizuka.colorizer'


-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ Editor
-- └─────────────────────────────────────────────────────────────────────────────
-- Advanced Text Editing
require 'shizuka.autopair'
require 'shizuka.snippets'
require 'shizuka.completion'
-- require 'shizuka.autocommands'

-- Org
require 'shizuka.markdown'
-- require 'shizuka.neorg'


-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ IDE
-- └─────────────────────────────────────────────────────────────────────────────
-- Code Parser
require 'shizuka.treesitter'

-- Tooling
require 'shizuka.hop'
require 'shizuka.git'
require 'shizuka.git-diff'

-- LSP
require 'shizuka.lsp'
require 'shizuka.lspman'
require 'shizuka.rename'
require 'shizuka.trouble'
require 'shizuka.structure'
require 'shizuka.formatting'

-- DAP
require 'shizuka.dap'
require 'shizuka.dap-ui'
require 'shizuka.dap-vt'
