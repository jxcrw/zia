-- Plugin Manager Config
-- Powered by packer (https://github.com/wbthomason/packer.nvim)

-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ Setup
-- └─────────────────────────────────────────────────────────────────────────────
-- Automatically install packer
local fn = vim.fn
local packer_repo = 'https://github.com/wbthomason/packer.nvim'
local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system { 'git', 'clone', '--depth', '1', packer_repo, install_path }
    print 'Installed packer. Close and reopen Neovim.'
    vim.cmd [[packadd packer.nvim]]
end

vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugman.lua source <afile>
  augroup end
]]

local status_ok, packer = pcall(require, 'packer')
if not status_ok then
    return
end

packer.init {
    display = {
        open_fn = function()
            return require('packer.util').float { border = 'rounded' }
        end,
    },
}


-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ Config
-- └─────────────────────────────────────────────────────────────────────────────
return packer.startup(function(use)
    -- ┌─────────────────────────────────────────────────────────────────────────────
    -- │ Core
    -- └─────────────────────────────────────────────────────────────────────────────
    use 'wbthomason/packer.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'lewis6991/impatient.nvim'


    -- ┌─────────────────────────────────────────────────────────────────────────────
    -- │ UI
    -- └─────────────────────────────────────────────────────────────────────────────
    -- Core
    use 'nvim-lua/popup.nvim'
    use 'romgrk/barbar.nvim'
    use 'jxcrw/nvim-tree.lua'
    use 'petertriho/nvim-scrollbar'
    use 'nvim-lualine/lualine.nvim'
    use { 'jxcrw/telescope.nvim', branch = '0.1.x' }
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
    -- use 'lukas-reineke/indent-blankline.nvim'

    -- Colors
    use 'folke/tokyonight.nvim'
    use 'norcalli/nvim-colorizer.lua'


    -- ┌─────────────────────────────────────────────────────────────────────────────
    -- │ Editor
    -- └─────────────────────────────────────────────────────────────────────────────
    -- Advanced Text Editing
    use 'matze/vim-move'
    use 'godlygeek/tabular'
    use 'dkarter/bullets.vim'
    use 'tpope/vim-commentary'
    use 'windwp/nvim-autopairs'
    use 'salsifis/vim-transpose'
    use { 'L3MON4D3/LuaSnip', tag = 'v1.*' }

    -- Completion
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-nvim-lsp'

    -- Org
    use 'preservim/vim-markdown'
    use { 'iamcco/markdown-preview.nvim', run = function() vim.fn['mkdp#util#install']() end }
    -- use { 'nvim-neorg/neorg' }


    -- ┌─────────────────────────────────────────────────────────────────────────────
    -- │ IDE
    -- └─────────────────────────────────────────────────────────────────────────────
    -- Code Parsing
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'nvim-treesitter/playground'
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    -- use 'p00f/nvim-ts-rainbow'

    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use 'jose-elias-alvarez/null-ls.nvim'
    use 'filipdutescu/renamer.nvim'
    use 'simrat39/rust-tools.nvim'
    use 'folke/trouble.nvim'

    -- DAP
    use 'mfussenegger/nvim-dap'
    use 'rcarriga/nvim-dap-ui'
    use 'theHamsta/nvim-dap-virtual-text'

    -- Tooling
    use { 'phaazon/hop.nvim', branch = 'v2' }
    use 'tpope/vim-fugitive'
    use 'TimUntersberger/neogit'
    use 'lewis6991/gitsigns.nvim'
    use 'sindrets/diffview.nvim'
    use 'simrat39/symbols-outline.nvim'


    if PACKER_BOOTSTRAP then
        require('packer').sync()
    end
end)
