-- Markdown Editing Configs
-- Powered by markdown-preview (https://github.com/iamcco/markdown-preview.nvim)
-- Powered by vim-markdown (https://github.com/preservim/vim-markdown)

-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ Markdown Preview
-- └─────────────────────────────────────────────────────────────────────────────
vim.g.mkdp_auto_start = 0
vim.g.mkdp_auto_close = 0
vim.g.mkdp_refresh_slow = 0
vim.g.mkdp_command_for_global = 0
vim.g.mkdp_open_to_the_world = 0
vim.g.mkdp_open_ip = ''
vim.g.mkdp_browser = ''
vim.g.mkdp_echo_preview_url = 0
vim.g.mkdp_browserfunc = ''
vim.g.mkdp_port = ''
vim.g.mkdp_page_title = '${name}'
vim.g.mkdp_filetypes = { 'markdown' }
vim.g.mkdp_theme = 'dark'

local styles = vim.fn.stdpath('config') .. '/lua/shizuka/_styles.css'
vim.g.mkdp_markdown_css = styles -- like '/Users/usernme/markdown.css' or expand('~/markdown.css')
vim.g.mkdp_highlight_css = styles -- like '/Users/username/highlight.css' or expand('~/highlight.css')

vim.g.mkdp_preview_options = {
    disable_filename = 0,
    content_editable = false,
    disable_sync_scroll = 1,
    sync_scroll_type = 'middle',
    hide_yaml_meta = 1,
    toc = {},
    uml = {},
    mkit = {},
    maid = {},
    katex = {},
    sequence_diagrams = {},
    flowchart_diagrams = {},
}


-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ Vim Markdown
-- └─────────────────────────────────────────────────────────────────────────────
vim.g.vim_markdown_folding_disabled = 1
vim.g.vim_markdown_no_default_key_mappings = 1
vim.g.vim_markdown_strikethrough = 1
vim.g.vim_markdown_edit_url_in = 'tab'
vim.g.vim_markdown_follow_anchor = 1
vim.g.vim_markdown_frontmatter = 1
vim.g.vim_markdown_toml_frontmatter = 1
