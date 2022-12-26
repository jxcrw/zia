-- Snippets Config
-- Powered by LuaSnip (https://github.com/L3MON4D3/LuaSnip)

-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ Setup
-- └─────────────────────────────────────────────────────────────────────────────
local status_okay, luasnip = pcall(require, 'luasnip')
if not status_okay then
   return
end


-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ Config
-- └─────────────────────────────────────────────────────────────────────────────
require('luasnip.loaders.from_lua').load({ paths = vim.fn.stdpath('config') .. '/snips' })
require('luasnip').config.set_config({ -- Setting LuaSnip config

   -- Enable autotriggered snippets
   enable_autosnippets = true,

   -- Use Tab (or some other key if you prefer) to trigger visual selection
   -- store_selection_keys = '<Tab>',
   update_events = 'TextChanged,TextChangedI',
})
