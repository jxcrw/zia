-- Tabline Config
-- Powered by barbar (https://github.com/romgrk/barbar.nvim)

-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ Setup
-- └─────────────────────────────────────────────────────────────────────────────
local status_ok, bufferline = pcall(require, 'bufferline')
if not status_ok then
   return
end

vim.cmd [[
  augroup reload_tabline
    autocmd!
    autocmd BufWritePost tabline.lua source <afile>
  augroup end
]]

-- Adjust offset for nvim-tree
local nvim_tree_events = require('nvim-tree.events')
local bufferline_api = require('bufferline.api')

local function get_tree_size()
   local width = require 'nvim-tree.view'.View.width
   return width + 1
end

nvim_tree_events.subscribe('TreeOpen', function()
   bufferline_api.set_offset(get_tree_size())
end)

nvim_tree_events.subscribe('Resize', function()
   bufferline_api.set_offset(get_tree_size())
end)

nvim_tree_events.subscribe('TreeClose', function()
   bufferline_api.set_offset(0)
end)


-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ Config
-- └─────────────────────────────────────────────────────────────────────────────
bufferline.setup {
   -- Enable/disable animations
   animation = false,

   -- Enable/disable auto-hiding the tab bar when there is a single buffer
   auto_hide = false,

   -- Enable/disable current/total tabpages indicator (top right corner)
   tabpages = true,

   -- Enable/disable close button
   closable = false,

   -- Enable/disable clickable tabs
   --  - left-click: go to buffer
   --  - middle-click: delete buffer
   clickable = true,

   -- Enable/disable diagnostic symbols
   diagnostics = {
      { enabled = false, icon = '' }, -- ERROR
      { enabled = false, icon = '' }, -- WARN
      { enabled = false }, -- INFO
      { enabled = false }, -- HINT
   },

   -- Exclude buffers from the tabline
   exclude_ft = { 'javascript', '' },
   -- exclude_name = {'package.json'},

   -- Hide inactive buffers and file extensions. Other options are `current` and `visible`
   hide = { extensions = true, inactive = false },


   -- Enable/disable icons
   -- if set to 'numbers', will show buffer index in the tabline
   -- if set to 'both', will show buffer index and icons in the tabline
   icons = false,

   -- If set, the icon color will follow its corresponding buffer
   -- highlight group. By default, the Buffer*Icon group is linked to the
   -- Buffer* group (see Highlighting below). Otherwise, it will take its
   -- default value as defined by devicons.
   icon_custom_colors = false,

   -- Configure icons on the bufferline.
   icon_separator_active = '',
   icon_separator_inactive = '',
   icon_close_tab = '',
   icon_close_tab_modified = '●',
   icon_pinned = '車',

   -- If true, new buffers will be inserted at the start/end of the list.
   -- Default is to insert after current buffer.
   insert_at_end = true,
   insert_at_start = false,

   -- Sets the maximum padding width with which to surround each tab
   maximum_padding = 1,

   -- Sets the minimum padding width with which to surround each tab
   minimum_padding = 1,

   -- Sets the maximum buffer name length.
   maximum_length = 30,

   -- If set, the letters for each buffer in buffer-pick mode will be
   -- assigned based on their name. Otherwise or in case all letters are
   -- already assigned, the behavior is to assign letters in order of
   -- usability (see order below)
   semantic_letters = true,

   -- New buffer letters are assigned in this order. This order is
   -- optimal for the qwerty keyboard layout but might need adjustement
   -- for other layouts.
   letters = '(.,/)_@\\*-%$stnrfgwldkphbcejqvxyzaomuiSTNRFGWLDKPHBCEJQVXYZAOMUI',

   -- Sets the name of unnamed buffers. By default format is '[Buffer X]'
   -- where X is the buffer number. But only a static string is accepted here.
   no_name_title = nil,
}
