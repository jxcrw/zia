-- LSP Config
-- Powered by nvim-lspconfig (https://github.com/neovim/nvim-lspconfig)

-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ Setup
-- └─────────────────────────────────────────────────────────────────────────────
local status_ok, lspconfig = pcall(require, 'lspconfig')
if not status_ok then
   return
end


-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ Config
-- └─────────────────────────────────────────────────────────────────────────────
local function lspsetup()
   local signs = {
      { name = 'DiagnosticSignError', text = ' •' },
      { name = 'DiagnosticSignWarn', text = ' •' },
      { name = 'DiagnosticSignHint', text = ' •' },
      { name = 'DiagnosticSignInfo', text = ' •' },
   }

   for _, sign in ipairs(signs) do
      vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
   end

   local config = {
      virtual_text = false,
      signs = false,
      update_in_insert = false,
      underline = true,
      severity_sort = true,
      float = {
         focusable = false,
         style = 'minimal',
         border = 'rounded',
         source = 'if_many',
         header = '',
         prefix = '',
         scope = 'buffer'
      },
   }

   vim.diagnostic.config(config)

   vim.cmd [[
  highlight! DiagnosticLineNrError guibg=#1a1b26 guifg=#f7768e gui=bold
  highlight! DiagnosticLineNrWarn  guibg=#1a1b26 guifg=#ffc777 gui=bold
  highlight! DiagnosticLineNrInfo  guibg=#1a1b26 guifg=#9ece6a gui=bold
  highlight! DiagnosticLineNrHint  guibg=#1a1b26 guifg=#73daca gui=bold

  highlight! DiagnosticUnderlineError gui=undercurl
  highlight! DiagnosticUnderlineWarn gui=undercurl
  highlight! DiagnosticUnderlineInfo gui=undercurl
  highlight! DiagnosticUnderlineHint gui=undercurl

  highlight! DiagnosticVirtualTextError gui=italic guibg=#1a1b26 guifg=#f7768e
  highlight! DiagnosticVirtualTextWarn gui=italic guibg=#1a1b26 guifg=#ffc777
  highlight! DiagnosticVirtualTextInfo gui=italic guibg=#1a1b26 guifg=#9ece6a
  highlight! DiagnosticVirtualTextHint gui=italic guibg=#1a1b26 guifg=#73daca

  sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=DiagnosticLineNrError
  sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=DiagnosticLineNrWarn
  sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=DiagnosticLineNrInfo
  sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=DiagnosticLineNrHint
]]

   vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = 'rounded',
   })

   vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = 'rounded',
   })
end

lspsetup()

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', 'Xe', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', 'Xq', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
   -- Enable completion triggered by <c-x><c-o>
   vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

   -- Mappings.
   -- See `:help vim.lsp.*` for documentation on any of the below functions
   local bufopts = { noremap = true, silent = true, buffer = bufnr }
   vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
   vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
   vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
   vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
   vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
   vim.keymap.set('n', 'Xwa', vim.lsp.buf.add_workspace_folder, bufopts)
   vim.keymap.set('n', 'Xwr', vim.lsp.buf.remove_workspace_folder, bufopts)
   vim.keymap.set('n', 'Xwl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
   end, bufopts)
   vim.keymap.set('n', 'XD', vim.lsp.buf.type_definition, bufopts)
   vim.keymap.set('n', 'Xrn', vim.lsp.buf.rename, bufopts)
   vim.keymap.set('n', 'Xca', vim.lsp.buf.code_action, bufopts)
   vim.keymap.set('n', 'Xgr', vim.lsp.buf.references, bufopts)
   vim.keymap.set('n', 'Xf', function() vim.lsp.buf.format { async = true } end, bufopts)
   vim.keymap.set('v', 'Xf', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lsp_flags = {
   -- This is the default in Nvim 0.7+
   debounce_text_changes = 150,
}


lspconfig.pyright.setup {
   on_attach = on_attach,
   flags = lsp_flags,
   settings = {
      python = {
         analysis = {
            typeCheckingMode = 'off'
         }
      }
   }
}

lspconfig.lua_ls.setup {
   on_attach = on_attach,
   flags = lsp_flags,
   settings = {
      Lua = {
         diagnostics = {
            globals = { 'vim' },
         },
         workspace = {
            library = {
               [vim.fn.expand('$VIMRUNTIME/lua')] = true,
               [vim.fn.stdpath('config') .. '/lua'] = true,
            },
         },
      },
   },
}

local rt = require('rust-tools')

rt.setup({
   server = {
      on_attach = function(_, bufnr)
         -- Hover actions
         vim.keymap.set('n', '<C-space>', rt.hover_actions.hover_actions, { buffer = bufnr })
         -- Code action groups
         vim.keymap.set('n', '<Leader>a', rt.code_action_group.code_action_group, { buffer = bufnr })
      end,
   },
   dap = {
      adapter = {
         type = "executable",
         command = "lldb-vscode",
         name = "rt_lldb",
      },
   },
})

-- lspconfig.['tsserver'].setup{
--     on_attach = on_attach,
--     flags = lsp_flags,
-- }

-- lspconfig.['rust_analyzer'].setup{
--     on_attach = on_attach,
--     flags = lsp_flags,
--     -- Server-specific settings...
--     settings = {
--       ['rust-analyzer'] = {}
--     }
-- }
