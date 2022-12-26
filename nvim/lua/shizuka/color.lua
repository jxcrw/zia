-- Colorscheme Config
-- Powered by  (https://github.com/folke/tokyonight.nvim)

-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ Setup
-- └─────────────────────────────────────────────────────────────────────────────
local util = require('tokyonight.util')


-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ Setup
-- └─────────────────────────────────────────────────────────────────────────────
require('tokyonight').setup({
   -- your configuration comes here
   -- or leave it empty to use the default settings
   style = 'night', -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
   light_style = 'storm', -- The theme is used when the background is set to light
   transparent = false, -- Enable this to disable setting the background color
   terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
   styles = {
      -- Style to be applied to different syntax groups
      -- Value is any valid attr-list value for `:help nvim_set_hl`
      comments = { italic = true },
      keywords = { italic = true },
      functions = {},
      variables = {},
      -- Background styles. Can be 'dark', 'transparent' or 'normal'
      sidebars = 'dark', -- style for sidebars, see below
      floats = 'transparent', -- style for floating windows
   },
   sidebars = { 'qf' }, -- Set a darker background on sidebar-like windows. For example: `['qf', 'vista_kind', 'terminal', 'packer']`
   day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
   hide_inactive_statusline = true, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
   dim_inactive = false, -- dims inactive windows
   lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold

   --- You can override specific color groups to use other groups or a hex color
   --- function will be called with a ColorScheme table
   --- colors ColorScheme
   -- on_colors = function(colors) end,

   --- You can override specific highlights to use other groups or a hex color
   --- function will be called with a Highlights and ColorScheme table
   ---  highlights Highlights
   --- colors ColorScheme
   on_highlights = function(hl, c)
      -- local prompt = '#2d3149'
      local selection = util.darken(c.green1, 0.25)
      local yelloworange = '#F7B273'

      local diffadd = util.darken(c.green, 0.50)
      local diffremove = util.darken(c.red, 0.50)
      local diffchange = util.darken(yelloworange, 0.5)

      -- Neovim Defaults
      hl.NonText = { fg = c.comment }
      hl.EndOfBuffer = { fg = c.bg }
      hl.MsgArea = { fg = c.fg, bg = c.bg_dark }
      hl.Visual = { fg = nil, bg = selection }
      hl.CursorLineNr = { fg = c.fg }
      hl.healthError = { fg = c.red }
      hl.Error = { fg = c.red }
      hl.ErrorMsg = { fg = c.red }
      hl.Search = { fg = nil, bg = selection }
      hl.IncSearch = { fg = c.bg, bg = c.green1 }

      hl.Title = { fg = c.green1 }
      hl.Boolean = { fg = yelloworange }
      hl.Constant = { fg = yelloworange }
      hl.Float = { fg = yelloworange }
      hl.Underlined = { fg = c.blue } -- TODO: Add underline
      -- hl.punctuation.special.markdown = { fg = c.comment }


      hl.DiagnosticError = { fg = c.red }
      hl.DiagnosticWarn = { fg = yelloworange }
      hl.DiagnosticInfo = { fg = c.green }
      hl.DiagnosticHint = { fg = c.green1 }

      -- Version Control
      hl.diffFile = { fg = c.green1 }
      hl.diffIndexLine = { fg = c.green1 }
      hl.diffNewFile = { fg = c.yelloworange }
      hl.diffOldFile = { fg = c.yelloworange }
      hl.diffAdded = { bg = diffadd }
      hl.DiffAdd = { bg = diffadd }
      hl.diffChanged = { bg = diffchange }
      hl.DiffChange = { bg = diffchange }
      hl.diffRemoved = { bg = diffremove }
      hl.DiffDelete = { bg = diffremove }
      hl.diffLine = { fg = yelloworange }

      -- Tabline
      hl.BufferOffset = { fg = c.bg, bg = c.bg_dark }

      hl.BufferCurrent = { fg = c.fg, bg = c.bg }
      hl.BufferCurrentSign = { fg = c.bg_dark, bg = c.bg }
      hl.BufferCurrentMod = { fg = yelloworange, bg = c.bg }
      hl.BufferCurrentTarget = { fg = c.magenta2, bg = nil }
      hl.BufferVisibleTarget = { fg = c.magenta2, bg = nil }
      hl.BufferInactiveTarget = { fg = c.magenta2, bg = nil }

      hl.BufferInactiveSign = { bg = c.bg_dark }
      hl.BufferInactive = { fg = c.comment, bg = c.bg_dark }

      hl.BufferTabpages = { fg = c.comment, bg = c.bg_dark }
      hl.BufferDefaultTabpageFill = { bg = c.bg_dark }

      -- Left Sidebar
      hl.NvimTreeRootFolder = { fg = c.blue }
      hl.NvimTreeFolderName = { fg = c.blue }
      hl.NvimTreeEmptyFolderName = { fg = c.blue }
      hl.NvimTreeOpenedFolderName = { fg = c.blue }
      hl.NvimTreeIndentMarker = { fg = c.blue }
      hl.NvimTreeCursorLine = { fg = nil, bg = nil }
      -- hl.NvimTreeWinSeparator = { fg = c.bg, bg = c.bg }

      hl.NvimTreeLiveFilter = { fg = c.green2 }
      hl.NvimTreeLivePrefix = { fg = c.green2 }
      hl.NvimTreeEndOfBuffer = { fg = c.bg_dark }
      hl.NvimTreeSpecialFile = { fg = c.fg_dark }

      hl.NvimTreeGitNew = { fg = c.green }
      hl.NvimTreeGitStaged = { fg = c.green1 }
      hl.NvimTreeGitDirty = { fg = yelloworange }
      hl.NvimTreeGitRenamed = { fg = c.magenta2 }
      hl.NvimTreeGitIgnored = { fg = c.comment }
      hl.NvimTreeGitDeleted = { fg = c.red }

      -- Gutter
      hl.GitSignsAdd = { fg = c.green }
      hl.GitSignsChange = { fg = yelloworange }
      hl.GitSignsDelete = { fg = c.red }
      hl.GitGutterDelete = { fg = c.red }

      -- Fuzzy Finder
      hl.TelescopeBorder = { fg = c.green1 }
      hl.TelescopePromptNormal = { fg = c.fg }
      hl.TelescopeResultsNormal = { fg = c.comment }
      hl.TelescopeResultsSpecialComment = { fg = c.comment }
      hl.TelescopeMatching = { fg = c.green1 }
      hl.TelescopeSelection = { fg = c.fg }
      hl.TelescopeSelectionCaret = { fg = yelloworange }
      hl.TelescopePreviewLine = { fg = nil, bg = selection }
      hl.TelescopeResultsDiffUntracked = { fg = c.green }

      hl.DapUIVariable = { fg = c.green }
      hl.DapUIValue = { fg = c.green }
      hl.DapUIFrameName = { fg = c.green }
      hl.DapUIFloatNormal = { fg = c.green }
      hl.DapBreakpoint = { fg = c.green }

      -- Diagnostics
      hl.TroubleNormal = { fg = c.fg, bg = nil }
      hl.LspFloatWinBorder = { fg = c.fg_gutter, bg = nil }
      hl.LspInfoBorder = { fg = c.fg_gutter, bg = nil }
      hl.FloatBorder = { fg = c.fg_gutter, bg = nil }

      -- Renamer
      hl.RenamerBorder = { fg = c.fg_gutter, bg = nil }

      -- Treesitter Overrides
      hl.SpellBad = { fg = nil, bg = nil }
      -- hl.PreProc = { fg = c.comment }

      -- Packer
      hl.packerStatusCommit = { fg = c.magenta }
      hl.packerProgress = { fg = c.green }
      hl.packerBreakingChange = { fg = c.red }


      hl.CmpDocumentationBorder = { fg = c.red }
      hl.htmlStrike = { fg = c.comment }

   end,
})

local colorscheme = 'tokyonight'

vim.cmd('colorscheme ' .. colorscheme)
-- local status_ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)
-- if not status_ok then
--     vim.notify('colorscheme ' .. colorscheme .. ' not found!')
--     return
-- end


vim.cmd [[
    augroup reload_file
        autocmd!
        autocmd BufWritePost colors.lua source <afile>
    augroup end
]]
