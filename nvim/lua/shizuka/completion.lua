-- Completion Config
-- Powered by nvim-cmp (https://github.com/hrsh7th/nvim-cmp)

-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ Setup
-- └─────────────────────────────────────────────────────────────────────────────
local U = require 'shizuka._util'
local cmp_status_ok, cmp = pcall(require, 'cmp')
if not cmp_status_ok then
   return
end


-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local lspconfig = require('lspconfig')
local servers = { 'pyright', 'sumneko_lua' }
for _, lsp in ipairs(servers) do
   lspconfig[lsp].setup {
      -- on_attach = my_custom_on_attach,
      capabilities = capabilities,
   }
end

-- luasnip setup
local luasnip = require('luasnip')

-- Icons
local kind_icons = {
   Text = '',
   Method = '',
   Function = '',
   Constructor = '',
   Field = '',
   Variable = '',
   Class = 'ﴯ',
   Interface = '',
   Module = '',
   Property = 'ﰠ',
   Unit = '',
   Value = '',
   Enum = '',
   Keyword = '',
   Snippet = '',
   Color = '',
   File = '',
   Reference = '',
   Folder = '',
   EnumMember = '',
   Constant = '',
   Struct = '',
   Event = '',
   Operator = '',
   TypeParameter = ''
}

-- Context awareness
local function not_in_comment()
   return not U.in_comment()
end


-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ Config
-- └─────────────────────────────────────────────────────────────────────────────
cmp.setup {
   enabled = not_in_comment,
   snippet = {
      expand = function(args)
         require('luasnip').lsp_expand(args.body)
      end,
   },

   window = {
      completion = cmp.config.window.bordered({
         winhighlight = 'Normal:Normal,FloatBorder:BorderBG,CursorLine:PmenuSel,Search:None',
         -- col_offset = -3,
         -- side_padding = 0
      }),
      documentation = cmp.config.window.bordered({
         winhighlight = 'Normal:Normal,FloatBorder:BorderBG,CursorLine:PmenuSel,Search:None',
      }),
   },
   completion = { keyword_length = 3 },
   view = { entries = { name = 'custom', selection_order = 'near_cursor' } },
   formatting = {
      fields = { 'kind', 'abbr', 'menu' },
      format = function(entry, vim_item)
         vim_item.kind = kind_icons[vim_item.kind]
         return vim_item
      end,
   },
   -- formatting = {
   --     format = function(entry, vim_item)
   --       -- Kind icons
   --       vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
   --       -- Source
   --       vim_item.menu = ({
   --         buffer = '[Buffer]',
   --         nvim_lsp = '[LSP]',
   --         luasnip = '[LuaSnip]',
   --         nvim_lua = '[Lua]',
   --         latex_symbols = '[LaTeX]',
   --       })[entry.source.name]
   --       return vim_item
   --     end
   --   },
   mapping = cmp.mapping.preset.insert({
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<Tab>'] = cmp.mapping(function(fallback)
         if luasnip.expandable() then
            luasnip.expand()
         elseif cmp.visible() then
            cmp.confirm { select = true }
         elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
         else
            fallback()
         end
      end, { 'i', 's' }),
      ['<C-M-S-D-F11>'] = cmp.mapping(function(fallback)
         if luasnip.expandable() then
            luasnip.expand()
         elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
         else
            fallback()
         end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
         if luasnip.jumpable(-1) then
            luasnip.jump(-1)
         else
            fallback()
         end
      end, { 'i', 's' }),
      ['<C-Up>'] = cmp.mapping(function(fallback)
         if cmp.visible() then
            cmp.select_prev_item()
         else
            fallback()
         end
      end, { 'i', 's' }),
      ['<C-Down>'] = cmp.mapping(function(fallback)
         if cmp.visible() then
            cmp.select_next_item()
         else
            fallback()
         end
      end, { 'i', 's' }),
      ['<M-C-Up>'] = cmp.mapping(function(fallback)
         if cmp.visible() then
            cmp.scroll_docs(-10)
         else
            fallback()
         end
      end, { 'i', 's' }),
      ['<M-C-Down>'] = cmp.mapping(function(fallback)
         if cmp.visible() then
            cmp.scroll_docs(10)
         else
            fallback()
         end
      end, { 'i', 's' }),
   }),


   sources = {
      { name = 'nvim_lsp' },
      { name = 'nvim_lua' },
      { name = 'path' },
   },
}


cmp.setup.cmdline(':', {
   mapping = cmp.mapping.preset.cmdline(),
   sources = cmp.config.sources({
      { name = 'path' }
   }, {
      {
         name = 'cmdline',
         option = {
            ignore_cmds = { 'Man', '!' }
         }
      }
   })
})

-- vim.cmd 'highlight! BorderBG guibg=NONE guifg=#73daca'
vim.cmd 'highlight! BorderBG guibg=NONE guifg=#3b4261'
