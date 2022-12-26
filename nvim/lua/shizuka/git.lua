-- Git Config
-- Powered by neogit (https://github.com/TimUntersberger/neogit)
-- Powered by gitsigns (https://github.com/lewis6991/gitsigns.nvim)

-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ Git Workflow UI
-- └─────────────────────────────────────────────────────────────────────────────
local status_ok, neogit = pcall(require, 'neogit')
if not status_ok then
   return
end

neogit.setup {}


-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ Git Gutter
-- └─────────────────────────────────────────────────────────────────────────────
local status_ok, gitsigns = pcall(require, 'gitsigns')
if not status_ok then
   return
end

gitsigns.setup {
   signs = {
      add = { hl = 'GitSignsAdd', text = '│', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
      change = { hl = 'GitSignsChange', text = '│', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
      delete = { hl = 'GitSignsDelete', text = '⯈', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
      topdelete = { hl = 'GitSignsDelete', text = '⯈', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
      changedelete = { hl = 'GitSignsChange', text = '│', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
   },
   signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
   numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
   linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
   word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
   watch_gitdir = {
      interval = 1000,
      follow_files = true,
   },
   attach_to_untracked = true,
   current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
   current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
      delay = 0,
      ignore_whitespace = false,
   },
   current_line_blame_formatter_opts = {
      relative_time = false,
   },
   sign_priority = 6,
   update_debounce = 100,
   status_formatter = nil, -- Use default
   max_file_length = 40000,
   preview_config = {
      -- Options passed to nvim_open_win
      border = 'rounded',
      style = 'minimal',
      relative = 'cursor',
      row = 0,
      col = 1,
   },
   yadm = { enable = false },
}
