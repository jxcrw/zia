-- Universal Snippets

local ls = require('luasnip')
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require('luasnip.extras.fmt').fmt
local fmta = require('luasnip.extras.fmt').fmta
local r = require('luasnip.extras').rep


local function fn(
  args, -- text from i(2) in this example i.e. { { '456' } }
  parent, -- parent snippet or parent node
  user_args -- user_args from opts.user_args
)
   return '[' .. args[1][1] .. user_args .. ']'
end

-- s('trig', {
--     i(1), t '<-i(1) ',
--     f(fn,  -- callback (args, parent, user_args) -> string
--      {2}, -- node indice(s) whose text is passed to fn, i.e. i(2)
--     { user_args = { 'user_args_value' }} -- opts
--     ),
--     t ' i(2)->', i(2), t '<-i(2) i(0)->', i(0)
-- })

local M = {
   -- ┌─────────────────────────────────────────────────────────────────────────────
   -- │ Neovim Dev
   -- └─────────────────────────────────────────────────────────────────────────────
   s({ trig = 'plugin', dscr = 'Plugin init' },
      fmta([[
            local ok, <> = pcall(require, '<>')
            if not ok then
                return
            end

            <>.setup()]],
         {
            i(1, 'plugin'),
            r(1),
            r(1),
         }
      )
   ),

}

return M
