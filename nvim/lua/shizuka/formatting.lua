-- Formatting Config
-- Powered by null-ls (https://github.com/jose-elias-alvarez/null-ls.nvim)

-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ Setup
-- └─────────────────────────────────────────────────────────────────────────────
local status_ok, null_ls = pcall(require, 'null-ls')
if not status_ok then
    return
end


-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ Config
-- └─────────────────────────────────────────────────────────────────────────────
null_ls.setup({
    debug = true,
    sources = {
        null_ls.builtins.formatting.yapf,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.rustfmt,
    },
})
