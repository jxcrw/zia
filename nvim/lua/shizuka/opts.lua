-- Startup Options

-- stylua: ignore start
vim.opt.backup = false                          -- creates a backup file
vim.opt.clipboard = 'unnamedplus'               -- allows neovim to access the system clipboard
vim.opt.cmdheight = 1                           -- more space in the neovim command line for displaying messages
vim.opt.completeopt = { 'menuone', 'noselect' } -- mostly just for cmp
-- vim.opt.conceallevel = 0                        -- so that `` is visible in markdown files
vim.opt.fileencoding = 'utf-8'                  -- the encoding written to a file
vim.opt.hlsearch = true                         -- highlight all matches on previous search pattern
vim.opt.ignorecase = true                       -- ignore case in search patterns
vim.opt.mouse = 'a'                             -- allow the mouse to be used in neovim
vim.opt.pumheight = 10                          -- pop up menu height
vim.opt.showmode = false                        -- we don't need to see things like -- INSERT -- anymore
vim.opt.showtabline = 1                         -- always show tabs
vim.opt.smartcase = false                        -- smart case
vim.opt.smartindent = true                      -- make indenting smarter again
vim.opt.autoindent = false                      -- make indenting smarter again
vim.opt.splitbelow = true                       -- force all horizontal splits to go below current window
vim.opt.splitright = true                       -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false                        -- creates a swapfile
vim.opt.termguicolors = true                    -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 2500                       -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.undofile = true                         -- enable persistent undo
vim.opt.updatetime = 100                        -- faster completion (4000ms default)
vim.opt.writebackup = false                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edite
vim.opt.expandtab = true                        -- convert tabs to spaces
vim.opt.shiftwidth = 4                          -- the number of spaces inserted for each indentation
vim.opt.tabstop = 4                             -- insert x spaces for a tab
vim.opt.cursorline = true                       -- highlight the current line
vim.opt.cursorlineopt = 'number'                -- but only highlight the line number
vim.opt.number = true                           -- set numbered lines
vim.opt.relativenumber = false                  -- set relative numbered lines
vim.opt.numberwidth = 2                         -- set number column width to 2 {default 4}
vim.opt.signcolumn = 'yes:1'                    -- always show the sign column, otherwise it would shift the text each time
vim.opt.wrap = true                             -- display lines as one long line
vim.opt.scrolloff = 4                           -- show this many lines of context at bottom of screen
vim.opt.mousescroll = 'ver:10,hor:10'           -- lines to scroll per mousewheel click
vim.opt.sidescrolloff = 8
vim.opt.guifont = 'consolas:h11.25'             -- the font used in graphical neovim applications
vim.opt.spell = false             -- enable spell checking
vim.opt.fileformat = 'unix'
vim.opt.fileformats = 'unix,dos'
vim.opt.autowriteall = true
vim.opt.autowrite = true

-- vim.opt.hiden = true

-- vim.opt.shortmess:append 'c'

-- vim.cmd 'behave mswin'
vim.cmd 'set linebreak'
-- vim.cmd 'set fillchars+=diff:╱'
vim.cmd 'set shm+=I'
vim.cmd [[set iskeyword+=_]]
vim.cmd 'set whichwrap+=<,>,[,],h,l'
vim.cmd [[set formatoptions-=cro]]
vim.cmd [[ autocmd FileType * set formatoptions-=cro]]  -- Don't continue comments on next line

-- vim.cmd [[ autocmd BufRead,BufNewFile * start]]     -- Open files in insert mode
vim.cmd [[ autocmd BufWritePre * %s/\s\+$//e]]      -- Trim trailing whitespace at end of lines
vim.cmd [[ autocmd FileType help  setlocal number]] -- Show line numbers in help files
vim.cmd [[ helptags ALL]]                           -- Update helptags

vim.opt.autoread = true
vim.cmd 'set autoread'
vim.cmd 'au CursorHold * silent! checktime'

-- Neovide
vim.g.neovide_refresh_rate = 120 -- 🔥
vim.g.neovide_confirm_quit = false
-- vim.g.neovide_profiler = false
vim.g.neovide_input_use_logo = true
vim.g.neovide_cursor_animation_length = 0.025
vim.g.neovide_scroll_animation_length = 0.2


-- Reload on save
vim.cmd [[
  augroup reload_keys
    autocmd!
    autocmd BufWritePost opts.lua source <afile>"
  augroup end
]]


vim.opt.conceallevel = 2
vim.opt.concealcursor = 'nc'
vim.opt.foldlevelstart = 99
vim.g.markdown_fenced_languages = {'python', 'cpp'}

-- Tweak Right-Click Menu
vim.cmd.aunmenu{'PopUp.Delete'}
vim.cmd.aunmenu{'PopUp.Select\\ All'}
vim.cmd.aunmenu{'PopUp.-1-'}
vim.cmd.aunmenu{'PopUp.How-to\\ disable\\ mouse'}


vim.g.VM_Mono_hl   = 'diffRemoved'
vim.g.VM_Extend_hl = '@character'
vim.g.VM_Cursor_hl = 'Visual'
vim.g.VM_Insert_hl = '@character'




vim.g.python3_host_prog = 'C:\\scoop\\apps\\python\\current\\python.exe'
vim.opt.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- -- https://github.com/mfussenegger/nvim-dap/discussions/355
-- vim.highlight.create('DapBreakpoint', { ctermbg=0, guifg='#993939', guibg='#31353f' }, false)
-- vim.highlight.create('DapLogPoint', { ctermbg=0, guifg='#61afef', guibg='#31353f' }, false)
-- vim.highlight.create('DapStopped', { ctermbg=0, guifg='#98c379', guibg='#31353f' }, false)

-- vim.fn.sign_define('DapBreakpoint', { text='', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint' })
-- vim.fn.sign_define('DapBreakpointCondition', { text='ﳁ', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint' })
-- vim.fn.sign_define('DapBreakpointRejected', { text='', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl= 'DapBreakpoint' })
-- vim.fn.sign_define('DapLogPoint', { text='', texthl='DapLogPoint', linehl='DapLogPoint', numhl= 'DapLogPoint' })
-- vim.fn.sign_define('DapStopped', { text='', texthl='DapStopped', linehl='DapStopped', numhl= 'DapStopped' })

-- TODO: Get hiding of dap-repl buffer working


vim.opt.hidden = true
vim.cmd [[ autocmd FocusLost * :wa ]] -- Save buffer when window focus lost

-- Improve word separator chars
-- vim.opt.iskeyword = ''

-- List help files as buffers so you can see where the heck you are
vim.cmd [[
  augroup help_as_buffer
    autocmd!
    autocmd FileType help set buflisted
  augroup END
]]



vim.cmd [[ autocmd FileType dap-repl set nobuflisted ]]


-- Clear command line after a few seconds
vim.cmd [[
" Clear cmd line message
function! s:empty_message(timer)
  if mode() ==# 'n'
    echon ''
  endif
endfunction

augroup cmd_msg_cls
    autocmd!
    autocmd CmdlineLeave :  call timer_start(5000, funcref('s:empty_message'))
augroup END
]]


-- Unlist scratch terminals + start in insert mode
vim.cmd [[
  augroup scratch_terminal
    autocmd!
    autocmd TermOpen * setlocal nobuflisted nonumber
    autocmd TermOpen * startinsert " to auto insert on terminal open
    " autocmd TermClose * if &ft!="fzf" | :q | endif " close on shell exit, no "process exited with 0"
  augroup END
]]

-- Disable continuation of comments
vim.api.nvim_create_autocmd("BufEnter", { callback = function() vim.opt.formatoptions = vim.opt.formatoptions - { "c","r","o" } end, })
