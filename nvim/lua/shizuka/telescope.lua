-- Fuzzyfinder Config
-- Powered by telescope (https://github.com/nvim-telescope/telescope.nvim)

-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ Setup
-- └─────────────────────────────────────────────────────────────────────────────
local status_ok, telescope = pcall(require, 'telescope')
if not status_ok then
   return
end

local actions = require 'telescope.actions'


-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ Config
-- └─────────────────────────────────────────────────────────────────────────────
telescope.setup {
   defaults = {

      prompt_prefix = '',
      selection_caret = '> ',
      path_display = { 'smart' },
      sorting_strategy = 'descending',
      layout_strategy = 'vertical',
      layout_config = { height = 0.99, mirror = true },

      mappings = {
         i = {
            ['<C-n>'] = actions.cycle_history_next,
            ['<C-p>'] = actions.cycle_history_prev,

            ['<C-j>'] = actions.move_selection_next,
            ['<C-k>'] = actions.move_selection_previous,

            ['<C-c>'] = actions.close,

            ['<Down>'] = actions.move_selection_next,
            ['<Up>'] = actions.move_selection_previous,

            ['<CR>'] = actions.select_default,
            ['<C-x>'] = actions.select_horizontal,
            ['<C-v>'] = actions.select_vertical,
            ['<C-t>'] = false,

            ['<C-Up>'] = actions.preview_scrolling_up,
            ['<C-M-Up>'] = actions.preview_scrolling_up,
            ['<C-Down>'] = actions.preview_scrolling_down,
            ['<C-M-Down>'] = actions.preview_scrolling_down,

            ['<PageUp>'] = actions.results_scrolling_up,
            ['<PageDown>'] = actions.results_scrolling_down,

            ['<Tab>'] = actions.toggle_selection + actions.move_selection_worse,
            ['<S-Tab>'] = actions.toggle_selection + actions.move_selection_better,
            ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
            ['<M-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
            ['<C-l>'] = actions.complete_tag,
            ['<C-_>'] = actions.which_key, -- keys from pressing <C-/>
            ['<Esc>'] = actions.close,
            ['<C-u>'] = false,
         },

         n = {
            ['<esc>'] = actions.close,
            ['<CR>'] = actions.select_default,
            ['<C-x>'] = actions.select_horizontal,
            ['<C-v>'] = actions.select_vertical,
            ['<C-t>'] = false,
            ['<Esc>'] = actions.close,

            ['<Tab>'] = actions.toggle_selection + actions.move_selection_worse,
            ['<S-Tab>'] = actions.toggle_selection + actions.move_selection_better,
            ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
            ['<M-q>'] = actions.send_selected_to_qflist + actions.open_qflist,

            ['j'] = actions.move_selection_next,
            ['k'] = actions.move_selection_previous,
            ['H'] = actions.move_to_top,
            ['M'] = actions.move_to_middle,
            ['L'] = actions.move_to_bottom,

            ['<Down>'] = actions.move_selection_next,
            ['<Up>'] = actions.move_selection_previous,
            ['gg'] = actions.move_to_top,
            ['G'] = actions.move_to_bottom,

            ['<C-u>'] = actions.preview_scrolling_up,
            ['<C-d>'] = actions.preview_scrolling_down,

            ['<PageUp>'] = actions.results_scrolling_up,
            ['<PageDown>'] = actions.results_scrolling_down,

            ['?'] = actions.which_key,
         },
      },
   },
   pickers = {
      -- Default configuration for builtin pickers goes here:
      git_commits = {
         git_command = { 'git', 'log', '--pretty=%h %ad %C(green)<%aN> %Creset%s', '--date=format:%Y-%m-%d',
            '--abbrev=7' },
      }

   },
   extensions = {
      fzf = {
         fuzzy = false, -- false will only do exact matching
         override_generic_sorter = true, -- override the generic sorter
         override_file_sorter = true, -- override the file sorter
         case_mode = 'smart_case', -- or 'ignore_case' or 'respect_case'
         -- the default case_mode is 'smart_case'
      }
   },
}

require('telescope').load_extension('fzf')
