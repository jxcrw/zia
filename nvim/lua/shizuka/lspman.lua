-- LSP Tooling Management
-- Powered by mason (https://github.com/williamboman/mason.nvim)

-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ Setup
-- └─────────────────────────────────────────────────────────────────────────────
local status_ok, mason = pcall(require, 'mason')
if not status_ok then
   return
end

local status_ok, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not status_ok then
   return
end

-- -- Add bins installed by mason to path
-- local is_windows = vim.loop.os_uname().sysname == 'Windows_NT'
-- vim.env.PATH = vim.env.PATH .. (is_windows and ';' or ':') .. vim.fn.stdpath('data') .. '/mason/bin'


-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ Config
-- └─────────────────────────────────────────────────────────────────────────────
mason.setup({
   ui = {
      -- Whether to automatically check for new versions when opening the :Mason window.
      check_outdated_packages_on_open = true,

      -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
      border = 'rounded',

      icons = {
         -- The list icon to use for installed packages.
         package_installed = '•',
         -- The list icon to use for packages that are installing, or queued for installation.
         package_pending = '•',
         -- The list icon to use for packages that are not installed.
         package_uninstalled = '•',
      },

      keymaps = {
         -- Keymap to expand a package
         toggle_package_expand = '<Right>',
         -- Keymap to install the package under the current cursor position
         install_package = 'i',
         -- Keymap to reinstall/update the package under the current cursor position
         update_package = 'u',
         -- Keymap to check for new version for the package under the current cursor position
         check_package_version = 'c',
         -- Keymap to update all installed packages
         update_all_packages = 'U',
         -- Keymap to check which installed packages are outdated
         check_outdated_packages = 'C',
         -- Keymap to uninstall a package
         uninstall_package = 'X',
         -- Keymap to cancel a package installation
         cancel_installation = '<C-c>',
         -- Keymap to apply language filter
         apply_language_filter = '<C-f>',
      },
   },
})

mason_lspconfig.setup()
