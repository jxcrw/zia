-- Code Parser Config
-- Powered by treesitter (https://github.com/nvim-treesitter/nvim-treesitter)

-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ Setup
-- └─────────────────────────────────────────────────────────────────────────────
local status_ok, configs = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
   return
end


-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ Config
-- └─────────────────────────────────────────────────────────────────────────────
-- This initializes treesitter-textobjects too!
configs.setup({
   ensure_installed = { 'rust', 'python', 'lua', 'vim', 'markdown', 'help'},
   sync_install = false,
   ignore_install = { '' }, -- List of parsers to ignore installing
   autopairs = { enable = true },
   highlight = {
      enable = true, -- false will disable the whole extension
      disable = { 'kthxwtfbbq' }, -- list of language that will be disabled
      additional_vim_regex_highlighting = true,
   },
   indent = { enable = false, disable = { 'yaml', 'md' } },
   context_commentstring = {
      enable = true,
      enable_autocmd = false,
   },
})

-- Highlighting for @-prefixed treesitter contexts.
vim.api.nvim_set_hl(0, "@string.documentation", { link = "Comment" })
