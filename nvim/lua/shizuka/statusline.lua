-- Statusline Config
-- Powered by lualine (https://github.com/nvim-lualine/lualine.nvim)

-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ Setup
-- └─────────────────────────────────────────────────────────────────────────────
local status_ok, lualine = pcall(require, 'lualine')
if not status_ok then
   return
end

local function loc()
   return vim.api.nvim_buf_line_count(0) .. 'L'
end


-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ Config
-- └─────────────────────────────────────────────────────────────────────────────
lualine.setup {
   options = {
      icons_enabled = false,
      theme = 'auto',
      component_separators = { left = '  ', right = '  ' },
      section_separators = { left = '', right = '' },
      disabled_filetypes = {
         statusline = {},
         winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      globalstatus = true,
      refresh = {
         statusline = 100,
         tabline = 100,
         winbar = 100,
      }
   },
   sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {
         'mode',
         'branch',
         { 'diff', symbols = { added = '', modified = '', removed = '' } },
         { 'diagnostics', symbols = { error = 'E', warn = 'W', info = 'I', hint = 'H' } },
      },
      lualine_x = { 'searchcount', 'location', loc, 'encoding', 'fileformat', 'filetype' },
      lualine_y = {},
      lualine_z = {},
   },
   inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {}
   },
   tabline = {},
   winbar = {},
   inactive_winbar = {},
   extensions = {}
}

-- vim.cmd [[
--         augroup reload_file
--                 autocmd!
--                 autocmd BufWritePost lualine.lua source <afile>
--         augroup end
-- ]]
