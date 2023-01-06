-- Keymap

-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ Setup
-- └─────────────────────────────────────────────────────────────────────────────
-- Extended keymap functions
local X = require 'shizuka.keys-ext'
local H = vim.fn.stdpath('config')
local KEYS = H .. '/lua/shizuka/keys.lua'
local OPTS = H .. '/lua/shizuka/opts.lua'

-- Mode Aliases
local A = { 'n', 'v', 's', 'i', 'c', 'x', 't' } -- All
local NV = { 'n', 'v' }                         -- Normal, Visual
local N = { 'n' }                               -- Normal
local V = { 'v' }                               -- Visual
local I = { 'i' }                               -- Insert
local C = { 'c' }                               -- Command
local T = { 't' }                               -- Terminal

-- Options
local o = { noremap = true }                 -- Standard options
local oq = { noremap = true, silent = true } -- Quiet options
local of = {noremap = true, expr = true, replace_keycodes = true, silent = true} -- Functional options

-- Common fn/key aliases
local K = vim.keymap.set      -- Shortened map function
local E = '<ESC>'             -- Normal mode, safe place to start commands from
local EEE = '<ESC><ESC><ESC>' -- Really really go to normal mode
local O = '<C-o>'             -- Do one command in normal mode
local R = '<C-r>'             -- Access registers
local NOH = ':noh<CR>'        -- Clear highlighting

-- Reload keymap on save
vim.cmd [[
  augroup reload_keys
    autocmd!
    autocmd BufWritePost keys.lua source <afile>
  augroup end
]]


-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ Neovim General
-- └─────────────────────────────────────────────────────────────────────────────
-- Leader key
K(A, '<F12>', '<Nop>', oq)
K(A, '<Insert>', '<Nop>', oq)
-- vim.g.mapleader = '<Insert>'
-- vim.g.maplocalleader = '<Insert>'

-- Better escape
K(A, '<Esc>', EEE .. NOH, oq)
K(T, '<Esc>', '<C-\\><C-n>', oq)
K(C, '<Esc>', '<C-c>', oq)

-- Steno compatibility
K(NV, '<Space>', '<Nop>', oq) -- Guard against errant spaces (steno lyfe)
K(A, '<C-F12>', '<Nop>', oq)  -- Steno sticky key
K(N, '<C-F12>', 'i', oq)      -- Steno sticky key
K(V, '<C-F12>', '"_c', oq)    -- Steno sticky key
K(NV, '_', '<Nop>', oq)       -- Steno safe key


-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ App/Buffer Management
-- └─────────────────────────────────────────────────────────────────────────────
-- Basic app functions
K(A, '<F1>', E .. ':tab help ', o)        -- Help
K(V, '<F1>', 'y:<CR>:tab help <C-r>+', o) -- Help
K(A, '<C-z>', E .. 'u', oq)               -- Undo
K(A, '<C-y>', E .. '<C-r>', oq)           -- Redo
K(A, '<C-S-p>', E .. ':', o)              -- Open Command Palette
K(I, '<C-S-p>', O .. ':', o)              -- Open Command Palette
K(V, '<C-S-p>', ':', o)                   -- Open Command Palette
K(T, '<C-S-p>', '<C-\\><C-n>:', o)        -- Open Command Palette

K(A, '<C-s>', EEE .. NOH .. ':write<CR>', oq)      -- Save
K(A, '<C-S-s>', E .. ':save ', o)                  -- Save as
K(A, '<M-k>', EEE .. ':write<CR>:write<CR>:write<CR>:bdelete!<CR> ', oq) -- Confirm

K(A, '<M-C-S-D-F1>', E .. "'Z", oq) -- Open keymap
K(A, '<M-C-S-F1>', E .. "'Y", oq)   -- Open startup options
K(A, '<M-F3>', E .. "'X", oq)       -- Open snippets

K(A, '<C-M-S-D-F12>', E .. ':NvimTreeToggle<CR>', oq) -- Toggle left sidebar
K(A, '<F6>', E .. ':set wrap!<CR>', oq)               -- Toggle line wrap

K(A, '<C-S-F5>',  ':let @+ = expand("%:p")<CR>', oq)  -- Copy file path to clipboard
K(A, '<M-F5>', E .. ':NvimTreeFindFile<CR>', oq)      -- Focus current file in left sidebar

K(A, '<M-d>', E .. ":TSCaptureUnderCursor<CR>", oq) -- Inspect TS highlighting

K(NV, 'with all', ':PackerSync<CR>', oq) -- Sync Packer

-- Buffer management/navigation
K(A, '<C-F4>', E .. ':write | bdelete!<CR>', oq)         -- Close buffer
K(A, '<C-F4>', E .. ':bdelete!<CR>', oq)                 -- Close buffer
K(T, '<C-F4>', '<C-\\><C-n>:bdelete!<CR>', oq)           -- Close buffer
K(T, '<C-S-c>', '<C-\\><C-n><C-d>', oq)                  -- Close buffer
K(N, '<C-S-c>', '<C-\\><C-n><C-d>', oq)                  -- Close buffer
K(A, '<M-u>', E .. ':%bdelete!<CR>', oq)                 -- Close all buffers
K(A, '<M-F1>', E .. ':%bdelete!|edit#|bdelete#<CR>', oq) -- Close all buffers except current
K(A, '<C-Tab>', E .. ':bnext!<CR>', oq)                  -- Next buffer
K(A, '<C-S-Tab>', E .. ':bprev!<CR>', oq)                -- Previous buffer
K(A, '<C-t>', E .. ':enew!<CR>', oq)                     -- New buffer

K(A, '<C-S-F11>', E .. '<C-w>h', oq) -- Window left
K(A, '<M-4>', E .. '<C-w>l', oq)     -- Window right
K(A, '<C-S-F9>' , E .. '<C-w>k', oq) -- Window up
K(A, '<C-S-F10>', E .. '<C-w>j', oq) -- Window down

K(A, '<M-2>', ':vsplit<CR>', oq) -- Split left
K(A, '<M-3>', ':vsplit<CR>', oq) -- Split right
K(A, '<M-0>', ':new<CR>', oq)    -- Split up
K(A, '<M-1>', ':new<CR>', oq)    -- Split down

K(A, '<M-6>', EEE .. ':resize +15<CR>', oq)          -- Grow horizontally
K(I, '<M-6>', O .. ':resize +15<CR>', oq)            -- Grow horizontally
K(A, '<M-7>', EEE .. ':resize -15<CR>', oq)          -- Shrink horizontally
K(I, '<M-7>', O .. ':resize -15<CR>', oq)            -- Shrink horizontally
K(A, '<M-9>', EEE .. ':vertical resize +15<CR>', oq) -- Grow vertically
K(I, '<M-9>', O .. ':vertical resize +15<CR>', oq)   -- Grow vertically
-- K(A, '<', ':vertical resize -15<CR>', oq)            -- Shrink vertically
K(A, '<M-b>', E .. '<C-w>=', oq)                     -- Equalize window height/width

-- Send current file/directory to other apps
K(A, '<F4>', X.send('wtp'), oq)              -- CWD to Windows Terminal
K(A, '<M-C-S-D-F4>', X.send('explorer'), oq) -- CWD to Explorer
K(A, '<M-n>', X.send('sublime'), oq)         -- File to Sublime
K(A, '<C-S-n>', X.send('neovide'), oq)       -- File to Neovide


-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ Text Navigtion
-- └─────────────────────────────────────────────────────────────────────────────
-- Escape Visual Mode Sanely
K(V, '<Left>', E .. '`<', oq)
K(V, '<Right>', E .. '`>', oq)
K(V, '<Up>', E .. '`<<Up>', oq)
K(V, '<Down>', E .. '`><Down>', oq)

-- Smarter Cursor Movement
K(N, '<Up>', X.smartmove('U'), oq)
K(N, '<Down>', X.smartmove('D'), oq)
K(A, '<Home>', X.smarthome, of)
K(N, '<End>', 'g$', oq)
K(V, '<End>', '<Esc>g$', oq)
K(I, '<End>', O .. 'g$', oq)

-- General Navigation
K(N, '<C-Left>', 'B', oq)                                -- Prev word
K(V, '<C-Left>', E .. 'B', oq)                           -- Prev word
-- K(I, '<C-Left>' , E .. 'b', oq)                          -- Prev word
K(C, '<C-Left>' , '<C-f>bb<C-c>', oq)                    -- Prev word
K(N, '<C-Right>', 'E', oq)                               -- Next word
K(V, '<C-Right>', E .. 'E', oq)                          -- Next word
-- K(I, '<C-Right>' , E .. 'e<C-o>a', oq)                   -- Next word
K(C, '<C-Right>' , '<S-Right>', oq)                      -- Next word
K(A, '<C-Up>', E .. '<Up>{<Down>^', oq)                  -- Prev block
K(I, '<C-Up>', O .. '<Up><C-o>{<C-o><Down><C-o>^', oq)   -- Prev block
K(A, '<C-Down>', E .. '<Down>}<Up>^', oq)                -- Next block
K(I, '<C-Down>', O .. '<Down><C-o>}<C-o><Up><C-o>^', oq) -- Next block
K(A, '<C-Home>', E .. 'gg^', oq)                         -- BOF
K(A, '<C-End>', E .. 'G$', oq)                           -- EOF

K(A, '<M-C-F11>', E .. '<C-o>', oq) -- Jump back
K(I, '<M-C-F11>', O .. '<C-o>', oq) -- Jump back
K(A, '<M-C-F10>', E .. '<C-i>', oq) -- Jump forward (because Tab = C-i in Vimland ¯\_(ツ)_/¯)
K(I, '<M-C-F10>', O .. '<C-i>', oq) -- Jump forward (because Tab = C-i in Vimland ¯\_(ツ)_/¯)

K(NV, 'or', '%', oq) -- Jump to matching brackety thing

-- LSP Navigation
K(A, '<M-Left>', E .. ':TSTextobjectGotoPreviousStart @function.outer<CR>', oq) -- Next function
K(I, '<M-Left>', O .. ':TSTextobjectGotoPreviousStart @function.outer<CR>', oq) -- Next function
K(A, '<M-Right>', E .. ':TSTextobjectGotoNextStart @function.outer<CR>', oq)    -- Prev function
K(I, '<M-Right>', O .. ':TSTextobjectGotoNextStart @function.outer<CR>', oq)    -- Prev function

-- Hop
K(N, '<C-M-S-D-F10>', E .. ':HopWordCurrentLine<CR>', oq) -- Hop on current line
K(V, '<C-M-S-D-F10>', E .. ':HopWordCurrentLine<CR>', oq) -- Hop on current line
K(I, '<C-M-S-D-F10>', O .. ':HopWordCurrentLine<CR>', oq) -- Hop on current line

K(N, '<M-q>', E .. ':HopLineStart<CR>', oq) -- Hop to BOL
K(V, '<M-q>', E .. ':HopLineStart<CR>', oq) -- Hop to BOL
K(I, '<M-q>', O .. ':HopLineStart<CR>', oq) -- Hop to BOL

K(N, '<M-r>', E .. ':HopWordMW<CR>', oq) -- Hop anywhere
K(V, '<M-r>', E .. ':HopWordMW<CR>', oq) -- Hop anywhere
K(I, '<M-r>', O .. ':HopWordMW<CR>', oq) -- Hop anywhere

K(A, '<M-g>', E .. ':BufferPick<CR>', oq) -- Hop to buffer

-- Fancy Stuff
K(NV, 'go', X.smartfollow, of)           -- Smartfollow (link or lsp def)
K(A, '<MiddleMouse>', X.smartfollow, of) -- Smartfollow (link or lsp def)


-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ Text Selection
-- └─────────────────────────────────────────────────────────────────────────────
-- General
K(N, '<S-Left>', 'v<Left>', oq)       -- Select char left
K(V, '<S-Left>', '<Left>', oq)        -- Select char left
K(I, '<S-Left>' , E , oq)             -- Select char left
K(N, '<S-Right>', 'v<Right>', oq)     -- Select char right
K(V, '<S-Right>', '<Right>', oq)      -- Select char right
K(I, '<S-Right>' , O .. 'v', oq)      -- Select char right

K(A, '<S-Up>' , E .. 'v<Up>', oq)     -- Select line up
K(V, '<S-Up>' , '<Up>', oq)           -- Select line up
K(A, '<S-Down>' , E .. 'v<Down>', oq) -- Select line down
K(V, '<S-Down>' , '<Down>', oq)       -- Select line down
K(A, '<S-Home>', E .. 'v^', oq)       -- Select to BOL
K(V, '<S-Home>', '^', oq)             -- Select to BOL
K(A, '<S-End>' , 'v$<Left>', oq)      -- Select to EOL
K(I, '<S-End>' , '<C-o>v$<Left>', oq) -- Select to EOL
K(V, '<S-End>' , '$', oq)             -- Select to EOL

K(N, '<C-S-Left>', 'vb', oq)          -- Select word left
K(V, '<C-S-Left>', 'b', oq)           -- Select word left
K(I, '<C-S-Left>' , E .. 'vb', oq)    -- Select word left
K(N, '<C-S-Right>', 've', oq)         -- Select word right
K(V, '<C-S-Right>', 'e', oq)          -- Select word right
K(I, '<C-S-Right>' , O .. 've', oq)   -- Select word right

K(A, '<M-C-S-Up>', E .. 'V<Up>{', oq) -- Select to BOB
K(V, '<M-C-S-Up>', '<Up>{', oq)       -- Select to BOB
K(A, '<M-C-S-Down>', E .. '^v}$', oq) -- Select to EOB
K(V, '<M-C-S-Down>', '<Down>}$', oq)  -- Select to EOB

K(A, '<C-S-Home>', E .. 'vgg^', oq)   -- Select to BOF
K(A, '<C-S-End>', E .. 'vG$', oq)     -- Select to EOF
K(A, '<C-a>', E .. 'ggVG', oq)        -- Select all (TODO: Maintain cursor position)

-- Text Objects
local TOS = ':TSTextobjectSelect'
K(NV, 'in', '<Nop>', oq)                                    -- Prepare to select inside stuff
K(N,  'in ', 'vi', oq)                                      -- Select bracket pair (general)
K(N,  'in (', 'vi)', oq)                                    -- Select ()
K(N,  'in [', 'vi]', oq)                                    -- Select []
K(N,  'in {', 'vi}', oq)                                    -- Select {}
K(N,  'in <', 'vi>', oq)                                    -- Select <>
K(N,  'in "', 'vi"', oq)                                    -- Select ""
K(N,  "in '", "vi'", oq)                                    -- Select ''
K(N,  'in `', 'vi`', oq)                                    -- Select ``
K(NV, 'in in', E .. '^v$<Left>', oq)                        -- Select line
K(NV, 'in all', E .. 'vip$<Left>', oq)                      -- Select block
K(NV, 'in is', E .. TOS .. '@scopename.inner<CR>', oq)      -- Select scope
K(NV, 'in can', E .. TOS .. '@comment.outer<CR>', oq)       -- Select comment
K(NV, 'in it', E .. TOS .. '@class.outer<CR>', oq)          -- Select class
K(NV, 'in function', E .. TOS .. '@function.outer<CR>', oq) -- Select function
K(NV, 'in by', E .. TOS .. '@parameter.inner<CR>', oq)      -- Select parameter
K(NV, 'in or', E .. TOS .. '@conditional.outer<CR>', oq)    -- Select conditional
K(NV, 'in for', E .. TOS .. '@loop.outer<CR>', oq)          -- Select loop
K(NV, 'in how', E .. TOS .. '@call.outer<CR>', oq)          -- Select call
K(NV, 'in get', E .. ':Gitsigns select_hunk<CR>', oq)       -- Select git hunk
K(N,  'in it', 'vit', oq)                                   -- Select inner tag

K(NV, 'get', '<Nop>', oq)                                       -- Prepare to copy stuff
K(N,  'get ', 'vi', oq)                                         -- Copy bracket pair (general)
K(N,  'get (', 'vi)ygv', oq)                                    -- Copy ()
K(N,  'get [', 'vi]ygv', oq)                                    -- Copy []
K(N,  'get {', 'vi}ygv', oq)                                    -- Copy {}
K(N,  'get <', 'vi>ygv', oq)                                    -- Copy <>
K(N,  'get "', 'vi"ygv', oq)                                    -- Copy ""
K(N,  "get '", "vi'ygv", oq)                                    -- Copy ''
K(N,  'get `', 'vi`ygv', oq)                                    -- Copy ``
K(NV, 'get in', E .. '^v$<Left>ygv', oq)                        -- Copy line
K(NV, 'get all', E .. 'vip$<Left>ygv', oq)                      -- Copy block
K(NV, 'get is', E .. TOS .. '@scopename.inner<CR>ygv', oq)      -- Copy scope
K(NV, 'get can', E .. TOS .. '@comment.outer<CR>ygv', oq)       -- Copy comment
K(NV, 'get it', E .. TOS .. '@class.outer<CR>ygv', oq)          -- Copy class
K(NV, 'get function', E .. TOS .. '@function.outer<CR>ygv', oq) -- Copy function
K(NV, 'get by', E .. TOS .. '@parameter.inner<CR>ygv', oq)      -- Copy parameter
K(NV, 'get or', E .. TOS .. '@conditional.outer<CR>ygv', oq)    -- Copy conditional
K(NV, 'get for', E .. TOS .. '@loop.outer<CR>ygv', oq)          -- Copy loop
K(NV, 'get how', E .. TOS .. '@call.outer<CR>ygv', oq)          -- Copy call
K(NV, 'get get', E .. ':Gitsigns select_hunk<CR>ygv', oq)       -- Copy git hunk
K(N,  'get it', 'vitygv', oq)                                   -- Copy inner tag

K(NV, 'can', '<Nop>', oq)                                       -- Prepare to delete (can) stuff
K(N,  'can ', 'vi', oq)                                         -- Can bracket pair (general)
K(N,  'can (', 'vi)"zx', oq)                                    -- Can ()
K(N,  'can [', 'vi]"zx', oq)                                    -- Can []
K(N,  'can {', 'vi}"zx', oq)                                    -- Can {}
K(N,  'can <', 'vi>"zx', oq)                                    -- Can <>
K(N,  'can "', 'vi""zx', oq)                                    -- Can ""
K(N,  "can '", "vi'\"zx", oq)                                   -- Can ''
K(N,  'can `', 'vi`"zx', oq)                                    -- Can ``
K(NV, 'can in', E .. '^v$<Left>"zx', oq)                        -- Can line
K(NV, 'can all', E .. 'vip$<Left>"zx', oq)                      -- Can block
K(NV, 'can is', E .. TOS .. '@scopename.inner<CR>"zx', oq)      -- Can scope
K(NV, 'can can', E .. TOS .. '@comment.outer<CR>"zx', oq)       -- Can comment
K(NV, 'can it', E .. TOS .. '@class.outer<CR>"zx', oq)          -- Can class
K(NV, 'can function', E .. TOS .. '@function.outer<CR>"zx', oq) -- Can function
K(NV, 'can by', E .. TOS .. '@parameter.inner<CR>"zx', oq)      -- Can parameter
K(NV, 'can or', E .. TOS .. '@conditional.outer<CR>"zx', oq)    -- Can conditional
K(NV, 'can for', E .. TOS .. '@loop.outer<CR>"zx', oq)          -- Can loop
K(NV, 'can how', E .. TOS .. '@call.outer<CR>"zx', oq)          -- Can call
K(NV, 'can get', E .. ':Gitsigns select_hunk<CR>"zx', oq)       -- Can git hunk
K(N,  'can it', 'vit"zx', oq)                                   -- Can inner tag

local SWAP = '"yy<Esc>`.``gv"zP``"yP``'
K(NV, 'by', '<Nop>', oq)                                            -- Prepare to swap stuff
K(N,  'by ', 'vi', oq)                                              -- Swap bracket pair (general)
K(N,  'by (', 'vi)' .. SWAP, oq)                                    -- Swap ()
K(N,  'by [', 'vi]' .. SWAP, oq)                                    -- Swap []
K(N,  'by {', 'vi}' .. SWAP, oq)                                    -- Swap {}
K(N,  'by <', 'vi>' .. SWAP, oq)                                    -- Swap <>
K(N,  'by "', 'vi"' .. SWAP, oq)                                    -- Swap ""
K(N,  "by '", "vi'" .. SWAP, oq)                                    -- Swap ''
K(N,  'by `', 'vi`' .. SWAP, oq)                                    -- Swap ``
K(NV, 'by in', E .. '^v$<Left>' .. SWAP, oq)                        -- Swap line
K(NV, 'by all', E .. 'vip$<Left>' .. SWAP, oq)                      -- Swap block
K(NV, 'by is', E .. TOS .. '@scopename.inner<CR>' .. SWAP, oq)      -- Swap scope
K(NV, 'by can', E .. TOS .. '@comment.outer<CR>' .. SWAP, oq)       -- Swap comment
K(NV, 'by it', E .. TOS .. '@class.outer<CR>' .. SWAP, oq)          -- Swap class
K(NV, 'by function', E .. TOS .. '@function.outer<CR>' .. SWAP, oq) -- Swap function
K(NV, 'by by', E .. TOS .. '@parameter.inner<CR>' .. SWAP, oq)      -- Swap parameter
K(NV, 'by or', E .. TOS .. '@conditional.outer<CR>' .. SWAP, oq)    -- Swap conditional
K(NV, 'by for', E .. TOS .. '@loop.outer<CR>' .. SWAP, oq)          -- Swap loop
K(NV, 'by how', E .. TOS .. '@call.outer<CR>' .. SWAP, oq)          -- Swap call
K(NV, 'by get', E .. ':Gitsigns select_hunk<CR>' .. SWAP, oq)       -- Swap git hunk
K(N,  'by it', 'vit' .. SWAP, oq)                                   -- Swap inner tag

K(A, '<M-C-F9>', SWAP, oq)                                          -- Manual swap

-- Visual Block (Multicursor)
K(N, '<C-M-Up>', '<C-v><Up>',    oq)
K(V, '<C-M-Up>', '<Up>',    oq)
K(I, '<C-M-Up>', E .. '<Right><C-v><Up>',    oq)
K(N, '<C-M-Down>', '<C-v><Down>',    oq)
K(V, '<C-M-Down>', '<Down>',    oq)
K(I, '<C-M-Down>', E .. '<Right><C-v><Down>',    oq)
-- K(_a, '<C-MiddleMouse>', N .. '<Plug>(VM-Mouse-Cursor)', oq)
-- K(_a, '<C-RightMouse>', ':write!<CR>', oq)
-- K(_a, '<C-RightMouse>', N .. '<Plug>(VM-Mouse-Word)', oq)
-- K(_a, '<C-M-LeftMouse>', N .. '<Plug>(VM-Mouse-Column)', oq)


-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ Text Editing
-- └─────────────────────────────────────────────────────────────────────────────
-- Delete (to register z to protect system clipboard + support swap)
K(N, '<Del>', X.smartdelete, of)
K(V, '<Del>', '"zx', oq)
K(N, '<BS>', '"zX', oq)
K(V, '<BS>', '"zx', oq)

-- Cut/Copy/Paste
K(A, '<C-x>', E .. 'dd')
K(V, '<C-x>', 'd')
K(A, '<C-c>', '"*ygv')
K(N, '<C-c>', '^v$<Left>"+ygv')
K(A, '<C-v>', E .. '"*p')
K(I, '<C-v>', R .. O .. '+')
K(C, '<C-v>', R .. '+')
K(V, '<C-v>', 'P')

-- Newlines
K(A, '<C-M-S-D-F11>', X.smartnewline, of) -- Smart newline
K(N, '<Enter>', X.smartnewline, of)       -- Smart newline
K(C, '<Enter>', '<Enter>', oq)            -- Just Enter
K(N, '<M-CR>' , 'O', oq)                  -- Add line before
K(V, '<M-CR>' , E .. 'O', oq)             -- Add line before
K(I, '<M-CR>' , O .. 'O', oq)             -- Add line before

-- Word Operations
K(N, '<C-BS>', X.smartkill_backwards, of) -- Kill word backwards
K(I, '<C-BS>', '<C-o>vb"_c', oq )         -- Kill word backwards
K(A, '<C-Del>', E .. '"_dw', oq)          -- Kill word forwards
K(I, '<C-Del>', O .. '"_dw', oq)          -- Kill word forwards
K(N, '<C-u>', '"_S', oq)                  -- Kill word forwards

-- Line Operations
K(N, '<M-C-S-D-Del>', '"_dd', oq)          -- Delete line
K(V, '<M-C-S-D-Del>', 'V"_x', oq)          -- Delete line
K(I, '<M-C-S-D-Del>', O .. '"_dd', oq)     -- Delete line
K(N, '<C-S-F12>', ':copy.-1<CR>', oq)      -- Copy line up
K(V, '<C-S-F12>', ':copy.-1<CR>gv', oq)    -- Copy line up
K(I, '<C-S-F12>', O .. ':copy.-1<CR>', oq) -- Copy line up
K(N, '<C-S-F6>', ':copy.<CR>', oq)         -- Copy line down
K(V, '<C-S-F6>', ':copy.<CR>gv', oq)       -- Copy line down
K(I, '<C-S-F6>', O .. ':copy.<CR>', oq)    -- Copy line down

K(N, '<C-S-Up>', '<Plug>MoveLineUp', oq)          -- Move code up
K(V, '<C-S-Up>', '<Plug>MoveBlockUp', oq)         -- Move code up
K(I, '<C-S-Up>', O .. '<Plug>MoveLineUp', oq)     -- Move code up
K(N, '<C-S-Down>', '<Plug>MoveLineDown', oq)      -- Move code down
K(V, '<C-S-Down>', '<Plug>MoveBlockDown', oq)     -- Move code down
K(I, '<C-S-Down>', O .. '<Plug>MoveLineDown', oq) -- Move code down

K(N, '<Tab>', '>>^', oq)        -- Indent
K(V, '<Tab>', '>gv', oq)        -- Indent
K(I, '<Tab>', '<C-t>', oq)      -- Indent
K(N, '<M-C-D-F7>', '<<^', oq)   -- Dedent
K(V, '<M-C-D-F7>', '<gv', oq)   -- Dedent
K(I, '<M-C-D-F7>', '<C-d>', oq) -- Dedent

K(A, '<M-BS>', ':g/^$/d<CR>:%s/ //g<CR>', oq) -- Delete excess whitespace/newlines
K(NV, 'for', ':g/ <BS>', o)                   -- General-purpose line operation
K(V, '.', ":'<,'>normal.<CR>")                -- Repeat last action over range

-- Surround Stuff with Stuff
K(V, '(', '"0xi()<Esc>"0P', oq)
K(V, ' (', '"0xi()<Esc>"0P', oq)
K(V, '[', '"0xi[]<Esc>"0P', oq)
K(V, ' [', '"0xi[]<Esc>"0P', oq)
K(V, '{', '"0xi{}<Esc>"0P', oq)
K(V, ' {', '"0xi{}<Esc>"0P', oq)
K(V, '<', '"0xi<><Esc>"0P', oq)
K(V, ' <', '"0xi<><Esc>"0P', oq)
K(V, "'", "0xi''<Esc>P", oq)
K(V, " '", "\"0xi''<Esc>\"0P", oq)
K(V, '"', '"0xi""<Esc>"0P', oq)
K(V, ' "', '"0xi""<Esc>"0P', oq)
K(V, '`', '"0xi``<Esc>"0P', oq)
K(V, ' `', '"0xi``<Esc>"0P', oq)
K(V, '<C-M-F7>', '"0xi<u></u><Left><Left><Left><Esc>"0P', oq)

-- Alignment
K(NV, '=' , ':Tabularize /', o)           -- Align on specified char
K(NV, '==' , ':Tabularize /=<CR>', oq)    -- Align on =
K(NV, '=--' , ':Tabularize /--<CR> ', oq) -- Align on --

-- Indentation
K(N, '|' , '=ap', oq) -- Fix indentation of current block
K(V, '|' , '=gv', oq) -- Fix indentation of selection

-- Math
K(A, '<M-S-Up>', '<C-a>', oq)                            -- Increment number
K(A, '<M-S-Down>', '<C-x>', oq)                          -- Decrement number
K(NV, '<M-c>', '"0yyi<End> = <C-r>=<C-r>0<CR><Esc>', oq) -- Calculate current line
K(I, '<M-c>', E .. '"0yyi<End> = <C-r>=<C-r>0<CR>', oq)  -- Calculate current line

-- LSP Stuff
K(A, '<M-C-S-Left>', E .. ':TSTextobjectSwapPrevious @parameter.inner<CR>', oq) -- Swap param left
K(A, '<M-C-S-Right>', E .. ':TSTextobjectSwapNext @parameter.inner<CR>', oq)    -- Swap param right
K(A, '<M-F7>', E .. ':TSTextobjectSwapPrevious @function.outer<CR>', oq)        -- Swap function up
K(A, '<M-F8>', E .. ':TSTextobjectSwapNext @function.outer<CR>', oq)            -- Swap function down

-- Markdown Stuff
K(V, '<M-5>', '"0xi[]<Esc>"0P<Right>a(<C-r>+)', oq)                 -- Paste as Markdown link
K(N, '<M-5>', '"0ciw[]<Esc>"0P<Right>a(<C-r>+)', oq)                -- Paste as Markdown link
K(NV, '<C-LeftMouse>', 'gx', oq)                                    -- Follow link
K(I, '<C-LeftMouse>', O .. '<Plug>Markdown_OpenUrlUnderCursor', oq) -- Follow link

-- Fancy Stuff
K(A, '<M-f>', X.smartformat, oq)     -- Smartformat
K(NV, 'trans', ':Transpose<CR>', oq) -- Transpose


-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ Find/Replace
-- └─────────────────────────────────────────────────────────────────────────────
-- Find
K(N, '<C-f>', '/\\V<Space><BS>', o)       -- I-Find blank
K(I, '<C-f>', O .. '/\\V<Space><BS>', o)  -- I-Find blank
K(N, '*', '"0yiw<Left>/<C-r>0<CR>', oq)   -- Q-Find word
K(V, '<C-f>', 'y<Left>/\\V<C-r>+<CR>', o) -- Q-Find selection
K(V, '*', 'y<Left>/\\V<C-r>+<CR>', oq)    -- Q-Find selection
K(A, '<F3>', E .. 'n', oq)                -- Next matc
K(A, '<S-F3>', E .. 'N', oq)              -- Prev match

-- Replace
local LEFT = '<Left>'
local LEFT2 = LEFT:rep(2)
K(A, '<C-h>', E .. ':p<CR>:%s@\\V@g' .. LEFT2, o)    -- I-Replace blank
K(V, '<C-h>', 'y:p<CR>:%s@\\V<C-r>+@@g' .. LEFT2, o) -- I-Replace selection
K(N, '/', '"0yiw<Left>/<C-r>0<CR>cgn', oq)           -- Q-Replace word
K(V, '/', 'y<Left>/\\V<C-r>+<CR>cgn', oq)            -- Q-Replace selection
K(N, ',', '<Esc>.', oq)                              -- Repeat

local LEFT12 = LEFT:rep(12)
K(A, '<C-S-h>', E .. ':argadd **/*.* | argdedupe<CR>:argdo %s@\\V@ge | update<Space><BS>' .. LEFT12, o)    -- Replace in project files
K(V, '<C-S-h>', 'y:argadd **/*.* | argdedupe<CR>:argdo %s@\\V<C-r>+@@ge | update<Space><BS>' .. LEFT12, o) -- Replace in project files

K(A, '<F2>', '<cmd>lua require("renamer").rename( {empty = true})<cr>', oq) -- LSP rename symbol

-- Fuzzy Find
K(NV, '~', E .. ':Telescope<CR>', oq)                                          -- Find everything
K(A, '<C-p>', E .. ':Telescope find_files hidden=true no_ignore=true<CR>', oq) -- Find files
K(NV, '$', E .. ':Telescope treesitter<CR>', oq)                               -- Find symbols
K(NV, '-', E .. ':Telescope highlights<CR>', oq)                               -- Find highlights
K(NV, '^', E .. ':Telescope commands<CR>', oq)                                 -- Find commands
K(NV, 'κ', E .. ':Telescope keymaps<CR>', oq)                                  -- Find keys
K(NV, '?', E .. ':Telescope help_tags<CR>', oq)                                -- Find help

K(A, '<C-S-f>', E .. ':Telescope live_grep<CR>', oq)                           -- Find in files
K(NV, '–', E .. ':Telescope live_grep<CR>', oq)                                -- Find in files
K(A, '<M-w>', E .. ':Telescope current_buffer_fuzzy_find<CR>', oq)             -- Find in current file
K(I, '<M-w>', O .. ':Telescope current_buffer_fuzzy_find<CR>', oq)             -- Find in current file


-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ Programming
-- └─────────────────────────────────────────────────────────────────────────────
-- Semicolon
K(A, ';', X.smartsemicolon, of)

-- Comment
K(N, '<M-a>', E .. "mm<Plug>CommentaryLine | `m", oq)
K(V, '<M-a>', '<Plug>Commentary<CR>gv', oq)
K(I, '<M-a>', O .. "mm<C-o><Plug>CommentaryLine<C-o>`m", oq)

-- Run
K(A, '<F5>', X.run, oq)
K(N, 'run', X.run, oq)

-- Debug
K(A, "<S-F5>", function() require('dapui').toggle() end, oq)     -- Toggle debugging UI
K(A, "<M-C-D-F12>", E .. ':write | DapContinue<CR>', oq)         -- Run code in debug mode
K(NV, "start", E .. ':write | DapContinue<CR>', oq)              -- Run code in debug mode
K(NV, "be", E .. ':write | lua require"dap".run_last()<CR>', oq) -- Rerun code in debug mode
K(A, '<F8>', E .. ':DapToggleBreakpoint<CR>', oq)                -- Toggle breakpoint
K(A, '<M-v>', E .. ':DapToggleBreakpoint<CR>', oq)               -- Toggle breakpoint
K(A, '<M-y>', E .. ':DapStepOver<CR>', oq)                       -- Step over
K(A, '<C-S-e>', E .. ':DapStepInto<CR>', oq)                     -- Step in
K(A, '<M-x>', E .. ':DapStepOut<CR>', oq)                        -- Step out
K(NV, 'stop', E .. ':DapTerminate<CR>', oq)                      -- Stop debugging
K(NV, 'what', '<cmd>lua require("dapui").eval()<CR>', oq)        -- Balloon eval

-- LSP
K(A, '<M-C-S-D-F3>', vim.lsp.buf.references, oq)       -- Find references
K(NV, 'how', function() vim.lsp.buf.hover() end, oq)   -- Hover info
K(A, '<M-h>', E .. ':PyrightOrganizeImports<CR>', oq)  -- Organize imports

-- Diagnostics
K(A, "<M-C-D-F5>", ':TroubleToggle<CR>', oq)                                       -- Toggle diagnostics view
K(NV, "trouble", ':TroubleToggle<CR>', oq)                                         -- Toggle diagnostics view
K(A, '<M-o>', function() vim.diagnostic.goto_prev({ border = "rounded" }) end, oq) -- Next diagnostic
K(A, '<M-i>', function() vim.diagnostic.goto_next({ border = "rounded" }) end, oq) -- Prev diagnostic


-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ Version Control
-- └─────────────────────────────────────────────────────────────────────────────
-- Ascertain state
K(A, '<C-S-g>',  E .. ':Telescope git_commits<CR>', oq)         -- Log
K(A, '<M-C-S-D-F8>',  E .. ':Telescope git_status<CR>', oq)     -- Status

K(A, '<M-z>', X.DiffviewToggle, oq)                             -- Diff all
K(A, '<C-Space>', E .. ':Gitsigns preview_hunk_inline<CR>', oq) -- Diff hunk (inline)

-- Move around
K(A, "<M-,>", E .. ':Gitsigns next_hunk<CR>', oq)               -- Next hunk
K(A, "<M-ScrollWheelDown>", E .. ':Gitsigns next_hunk<CR>', oq) -- Next hunk
K(A, "<M-.>", E .. ':Gitsigns prev_hunk<CR>', oq)               -- Prev hunk
K(A, "<M-ScrollWheelUp>", E .. ':Gitsigns prev_hunk<CR>', oq)   -- Prev hunk

-- Stage
K(A, '<M-C-F8>', E .. ':Git add -A<CR>', oq)               -- Add all
K(A, '<C-S-F7>', E .. ':Gitsigns stage_buffer<CR>', oq)    -- Add buffer
K(A, '<C-S-a>', E .. ':Gitsigns stage_hunk<CR>', oq)       -- Add hunk
K(V, '<C-S-a>', E .. ":'<,'>Gitsigns stage_hunk<CR>", oq)  -- Add hunk
K(A, "<C-S-F4>", E .. ":Gitsigns reset_hunk<CR>", oq)      -- Reset hunk
K(V, "<C-S-F4>", E .. ":'<,'>Gitsigns reset_hunk<CR>", oq) -- Reset hunk

-- Commit
K(A, '<M-C-D-F3>', E .. ':tab Git commit --quiet<CR><Insert>', oq)   -- Commit
K(A, '<C-S-c>', E .. ':Gitsigns stage_hunk<CR>:Git commit<CR>', oq)  -- Commit hunk
K(A, '<M-p>',  E .. ':tab Git commit --amend --quie<CR><Insert>', o) -- Commit (amend)

-- Push/pull
K(A, '<M-s>',  E .. ':Git push<CR>', oq)       -- Push
K(A, '<M-t>',  E .. ':Git push -f<CR>', oq)    -- Push (force)
K(A, '<C-S-F2>',  E .. ':Git pull<CR>', oq)    -- Pull
K(A, '<C-S-F8>',  E .. ':Git pull -f<CR>', oq) -- Pull (force)

-- Fancy stuff
K(A, '<C-S-b>', E .. ':Gitsigns toggle_current_line_blame<CR>', oq) -- Blame line
K(A, '<M-F12>', E .. ':Git rebase -i<CR>', oq)                      -- Rebase


-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ Temp
-- └─────────────────────────────────────────────────────────────────────────────
K(N, 'dance', X.dance, of)
