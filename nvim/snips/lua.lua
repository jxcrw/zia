-- Lua Snippets

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

local M = {
   -- ┌─────────────────────────────────────────────────────────────────────────────
   -- │ General Programming
   -- └─────────────────────────────────────────────────────────────────────────────
   s({ trig = 'pt', dscr = 'print' },
      fmta([[print(<>)]],
         {
            i(0),
         }
      )
   ),

   s({ trig = 'printf', dscr = 'EZ print' },
      fmta([[print(f'<>: {<>}')]],
         {
            i(1, 'var'),
            r(1),
         }
      )
   ),

   s({ trig = 'fn', dscr = 'Function' },
      fmta([[
        local function <>(<>)
           <>
        end]],
         {
            i(1, 'fn'),
            i(2, ''),
            i(0),
         }
      )
   ),

   s({ trig = 'fori', dscr = 'for i' },
      fmta([[
        for i in range(<>):
            <>]],
         {
            i(1, ''),
            i(2, 'pass'),
         }
      )
   ),

   s({ trig = 'forilen', dscr = 'for i len' },
      fmta([[
        for i in range(len(<>)):
            <>]],
         {
            i(1, ''),
            i(2, 'pass'),
         }
      )
   ),

   s({ trig = 'forirev', dscr = 'for i rev' },
      fmta([[
        for i in reversed(range(<>)):
            <>]],
         {
            i(1, ''),
            i(2, 'pass'),
         }
      )
   ),

   s({ trig = 'fornur', dscr = 'for enumerate' },
      fmta([[
        for i, <> in enumerate(<>):
            <>]],
         {
            i(1, 'item'),
            i(2, 'items'),
            i(3, 'pass'),
         }
      )
   ),

   -- ┌─────────────────────────────────────────────────────────────────────────────
   -- │ OOP
   -- └─────────────────────────────────────────────────────────────────────────────
   s({ trig = 'class', dscr = 'Class' },
      fmta([[
        class <>:
            <>]],
         {
            i(1, 'Class'),
            i(2, 'pass'),
         }
      )
   ),

   s({ trig = 'init', dscr = 'Constructor' },
      fmta([[
        def __init__(self, <>):
            self.<> = <>]],
         {
            i(1),
            r(1),
            r(1),
         }
      )
   ),

   s({ trig = 'mtd', dscr = 'Method' },
      fmta([[
        def <>(self<>)<>:
            <>]],
         {
            i(1, 'method'),
            i(2, ''),
            i(3, ''),
            i(4, 'pass')
         }
      )
   ),

   -- ┌─────────────────────────────────────────────────────────────────────────────
   -- │ File IO
   -- └─────────────────────────────────────────────────────────────────────────────
   s({ trig = 'read', dscr = 'Read file' },
      fmta([[
        with open(<>, 'r', encoding='utf-8') as f:
            <> = <>]],
         {
            i(1),
            i(2, 'data'),
            i(3, '[line.strip() for line in f]')
         }
      )
   ),

   s({ trig = 'readj', dscr = 'Read JSON' },
      fmta([[
        with open(<>, 'r', encoding='utf-8') as f:
            <> = json.load(f)]],
         {
            i(1),
            i(2, 'data'),
         }
      )
   ),

   s({ trig = 'write', dscr = 'Write file' },
      fmta([[
        with open(<>, 'w+', newline='\n', encoding='utf-8') as f:
            f.write(<>)]],
         {
            i(1),
            i(2, 'data'),
         }
      )
   ),

   s({ trig = 'writej', dscr = 'Write JSON' },
      fmta([[
        with open(<>, 'w+', newline='\n', encoding='utf-8') as f:
            json.dump(<>), f, indent=2, ensure_ascii=False)]],
         {
            i(1),
            i(2, 'data'),
         }
      )
   ),

   s({ trig = 'walk', dscr = 'os.walk' },
      fmta([[
        entry = r'<>'
        for root, dirs, files in os.walk(<>):
            <>]],
         {
            i(1, '.'),
            r(1),
            i(2, 'pass')
         }
      )
   ),

}

return M
