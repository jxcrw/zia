-- Sidebar Config
-- Powered by nvim-tree (https://github.com/nvim-tree/nvim-tree.lua)

-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ Setup
-- └─────────────────────────────────────────────────────────────────────────────
local status_ok, nvim_tree = pcall(require, 'nvim-tree')
if not status_ok then
   return
end

vim.cmd [[
  augroup reload_sidebar
    autocmd!
    autocmd BufWritePost sidebarL.lua source <afile>
  augroup end
]]

local function echo_path(node)
   print(node.name)
end

local function hard_delete(node)
   local trash = 'C:\\~\\.zia\\.trash\\'
   local datetime = os.time()
   local destination = trash .. datetime .. '_' .. node.name
   os.rename(node.absolute_path, destination)
end

local excludes = {
   -- Files
   '\\.pyc', '\\.pyo', '\\.exe', '\\.dll', '\\.obj', '\\.o', '\\.a$', '\\.lib', '\\.so', '\\.dylib', '\\.ncb',
   '\\.sdf', '\\.suo', '\\.pdb', '\\.idb', '\\.DS_Store', '\\.directory', 'desktop\\.ini', '\\.class', '\\.psd',
   '\\.db', '\\.sublime-workspace', '\\.dropbox', '\\.ynabSettings\\.yroot', '\\.iml',
   -- Folders
   '^\\.git$', '\\.svn', '\\.hg', 'CVS', '\\.Trash', '\\.Trash-*', '\\.cache', 'build', 'dist',
   '\\.dropbox\\.cache', '__pycache__', '\\.pytest_cache', '\\.workspaces',
}


-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ Config
-- └─────────────────────────────────────────────────────────────────────────────
nvim_tree.setup {
   sync_root_with_cwd = false,
   respect_buf_cwd = false,
   update_focused_file = {
      enable = false,
      update_root = false,
      update_cwd = false,
      ignore_list = {},
   },
   hijack_cursor = true,

   disable_netrw = false,
   hijack_netrw = true,
   open_on_tab = false,
   update_cwd = true,
   hijack_directories = {
      enable = true,
      auto_open = true,
   },
   diagnostics = {
      enable = true,
      icons = {
         hint = '',
         info = '',
         warning = '•',
         error = '•',
      },
   },
   filters = {
      dotfiles = false,
      custom = excludes
   },
   git = {
      enable = true,
      ignore = false,
      timeout = 500,
   },

   view = {
      width = 0,
      side = 'left',
      adaptive_size = true,
      hide_root_folder = false,

      number = false,
      relativenumber = false,

      mappings = {
         custom_only = false,
         list = {
            { key = '<C-F12>', action = 'nop', action_cb = echo_path, mode = '' },
            { key = { '<Right>', '<2-LeftMouse>' }, action = 'edit' },
            { key = { '<2-RightMouse>', '<CR>' }, action = 'cd' },
            { key = '<M-h>', action = 'vsplit' },
            { key = '<M-v>', action = 'split' },
            { key = '<C-t>', action = 'tabnew' },
            { key = 'P', action = 'parent_node' },
            { key = '<Left>', action = 'close_node' },
            { key = '<M-/>', action = 'preview' },
            { key = '<C-Up>', action = 'first_sibling' },
            { key = '<C-Down>', action = 'last_sibling' },
            { key = 'I', action = 'toggle_git_ignored' },
            { key = 'H', action = 'toggle_dotfiles' },
            { key = 'U', action = 'toggle_custom' },
            { key = 'R', action = 'refresh' },
            { key = { '<C-M-S-D-F11>', 'a' }, action = 'create' },
            { key = '<Del>', action = 'hard_delete', action_cb = hard_delete, mode = '' },
            { key = '<F2>', action = 'full_rename' },
            { key = '<C-x>', action = 'cut', mode = '' },
            { key = '<C-c>', action = 'copy' },
            { key = '<C-v>', action = 'paste' },
            { key = 'y', action = 'copy_name' },
            { key = 'Y', action = 'copy_path' },
            { key = '<C-S-F5>', action = 'copy_absolute_path' },
            { key = '<M-o>', action = 'prev_diag_item' },
            { key = '<M-i>', action = 'next_diag_item' },
            { key = '<M-.>', action = 'prev_git_item' },
            { key = '<M-,>', action = 'next_git_item' },
            { key = '<BS>', action = 'dir_up' },
            { key = '<F5>', action = 'system_open' },
            { key = 'f', action = 'live_filter' },
            { key = 'F', action = 'clear_live_filter' },
            { key = '<M-c>', action = 'collapse_all' },
            { key = '<M-x>', action = 'expand_all' },
            { key = 'S', action = 'search_node' },
            { key = '.', action = 'run_file_command' },
            { key = 'how', action = 'toggle_file_info' },
            { key = 'g?', action = 'toggle_help' },
            { key = 'm', action = 'toggle_mark' },
            { key = 'bmv', action = 'bulk_move' },
            -- { key = 'q',                       action = 'close' },
            -- { key = 'd',                       action = 'remove' },
            -- { key = 'D',                       action = 'trash' },
            -- { key = '<',                       action = 'prev_sibling' },
            -- { key = '>',                       action = 'next_sibling' },
            -- { key = 'O',                       action = 'edit_no_picker' },
            -- { key = 'r',                       action = 'rename' },
            -- { key = '<C-e>',                   action = 'edit_in_place' },
         },
      },
   },

   renderer = {
      highlight_git = true,
      root_folder_modifier = ':t',
      icons = {
         show = {
            file = false,
            folder = false,
            folder_arrow = true,
            git = false,
         },
         glyphs = {
            default = '',
            symlink = '',
            git = {
               unstaged = '',
               staged = '',
               unmerged = '',
               renamed = '',
               deleted = '',
               untracked = '',
               ignored = '',
            },
            folder = {
               default = '',
               open = '',
               empty = '',
               empty_open = '',
               symlink = '',
            },
         }
      }
   }
}
