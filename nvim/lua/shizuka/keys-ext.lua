-- Keymap Helper Functions

-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ Setup
-- └─────────────────────────────────────────────────────────────────────────────
local M = {}
local U = require 'shizuka._util'

vim.cmd [[
  augroup reload_keys_ext
    autocmd!
    autocmd BufWritePost keys-ext.lua source <afile>
  augroup end
]]

-- Common key aliases
local E = '<ESC>'             -- Normal mode, safe place to start commands from
local EEE = '<ESC><ESC><ESC>' -- TODO: Fix this hack
local O = '<C-o>'             -- Do one command in normal mode
local R = '<C-r>'             -- Access registers


-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ App/Buffer Management
-- └─────────────────────────────────────────────────────────────────────────────
function M.send(app)
   -- Send current file/directory to other apps
   return function()
      local f = vim.fn.expand('%:p')
      local dir = vim.fn.expand('%:p:h')
      local row = vim.fn.line('.')
      local col = vim.fn.col('.')

      local apps = {
         ['sublime'] = ('subl.exe "%s:%s:%s"'):format(f, row, col),
         ['neovide'] = ('neovide.exe --multigrid "%s"'):format(f),
         ['explorer'] = ('explorer.exe /select, "%s"'):format(f),
         ['wtp'] = ('wtp.exe -d "%s"'):format(dir),
      }

      local command = apps[app]
      os.execute(command)
   end
end

-- function M.get_buffers() -- TODO: Improve buffer closing behavior
--     local buffers = {}
--     local string = 0

--     for buffer = 1, vim.fn.bufnr('$') - 1 do
--         table.insert(buffers, buffer)
--         string = string + buffer
--     end

--     print(vim.fn.bufnr('.'))
--     -- return buffers
-- end


-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ Text Navigtion
-- └─────────────────────────────────────────────────────────────────────────────
-- Smarter cursor movement
function M.smartmove(direction)
   -- Cross the chasms of time and space between the lines.
   -- TODO: Start keeping this type of code in another file.
   -- TODO: Fix jumps from middle of long lines to end of short lines (get stuck at EOL).
   return function()
      local line = vim.fn.line('.')
      local col = vim.fn.col('.')
      local code = vim.fn.getline('.')
      local up = vim.api.nvim_replace_termcodes('gk', true, false, true)
      local down = vim.api.nvim_replace_termcodes('gj', true, false, true)

      local bol = vim.fn.match(code, '\\S') + 1
      if bol == 0 then bol = 1 end
      local eol = string.len(code)

      local line_nb = 0
      if direction == 'U' then
         line_nb = vim.fn.prevnonblank(line - 1)
      else
         line_nb = vim.fn.nextnonblank(line + 1)
      end

      local code_nb = vim.fn.getline(line_nb)
      local col_nb = 0
      if col == 1 or col == bol then
         col_nb = vim.fn.match(code_nb, '\\S')
      elseif col == eol then
         col_nb = string.len(code_nb)
         if col_nb == 0 then col_nb = 1 end
      else
         col_nb = col - 1
      end

      if line_nb == 0 then
         if direction == 'U' then vim.api.nvim_feedkeys(up, 'n', false) end
         if direction == 'D' then vim.api.nvim_feedkeys(down, 'n', false) end
      else
         vim.api.nvim_win_set_cursor(0, { line_nb, col_nb })
      end
      -- print(l_nb, col_nb)
   end
end

function M.smarthome()
   local mode = vim.api.nvim_get_mode()["mode"]
   local col = vim.fn.col('.')
   local code = vim.fn.getline('.')
   local bol = vim.fn.match(code, '\\S') + 1
   if mode == 'n' then
      if col == bol then return 'g0'
      else return 'g^'
      end
   elseif mode == 'i' then
      if col == bol then return '<C-o>g0'
      else return '<C-o>g^'
      end
   elseif mode == 'v' then
      if col == bol then return '<Esc>g0'
      else return '<Esc>g^'
      end
   end
end


-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ Text Editing
-- └─────────────────────────────────────────────────────────────────────────────
function M.smartdelete()
   -- Guard system clipboard when deleting text.
   local col = vim.fn.col('.')
   local code = vim.fn.getline('.')
   local eol = string.len(code)
   if col == eol then
      return 'gJ'
   else
      return '"zx'
   end
end

function M.smartnewline()
   local mode = vim.api.nvim_get_mode()["mode"]
   local code = vim.fn.getline('.')
   local col = vim.fn.col('.')
   local bol = vim.fn.match(code, '\\S') + 1
   local eol = string.len(code)
   local filetype = vim.bo.filetype
   local command = ''

   if filetype == 'markdown' then
      if mode == 'n' and col == bol then
         command = ':call append(line(".")-1, "")<CR>'
         print(command)
         return command
      elseif mode == 'i' and col == eol + 1 then
         command = O .. ':InsertNewBullet<CR>'
         print(command)
         return command
      elseif mode == 'i' then
         command = O .. ':InsertNewBullet<CR>'
         print(command)
         return command
      elseif mode == 'c' or mode == 't' then
         command = '<CR>'
         print(command)
         return command
      else
         command = E .. ':InsertNewBullet<CR>'
         print(command)
         return command
      end
   else
      if mode == 'n' and col == bol then
         return ':call append(line(".")-1, "")<CR>'
      elseif mode == 'i' and col == eol + 1 then
         return '<CR>'
      elseif mode == 'i' then
         return O .. 'o'
      elseif mode == 'c' or mode == 't' then
         return '<CR>'
      else
         return E .. 'o'
      end
   end
end

function M.smartkill_backwards()
   local col = vim.fn.col('.')
   local code = vim.fn.getline('.')
   local eol = string.len(code)
   if col == eol then
      return '"_daw'
   else
      return '"_dawge'
   end
end

function M.smartsemicolon()
   local m = vim.api.nvim_get_mode()['mode']
   local ft = vim.bo.filetype
   local comment = U.in_comment()

   if not comment and ft == 'rust' then
      if m == 'n' or m == 'v' then
         return E .. 'A;' .. E
      elseif m == 'i' then
         return O .. 'A;'
      end
   else
      return ';'
   end
end

function M.smartformat()
   local ft = vim.bo.filetype

   if ft == 'markdown' then
      return vim.cmd(':TableFormat')
   else
      return vim.lsp.buf.format()
   end

end


-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ Programming
-- └─────────────────────────────────────────────────────────────────────────────
function M.run()
   local cwd = vim.fn.getcwd()
   local twd = vim.fn.expand('%:p:h')
   local f = vim.fn.expand('%:p')
   local sf = vim.fn.expand('%:t')
   local ft = vim.bo.filetype
   local bin = nil
   local trash = 'C:\\~\\.sel\\.trash\\'
   local command = ':write | 13split | terminal %s "%s"'

   if ft == 'python' then
      bin = 'python'
   elseif ft == 'lua' then
      bin = 'lua'
   elseif ft == 'pandoc' or ft == 'markdown' then
      command = ':MarkdownPreview'
   elseif ft == 'rust' then
      bin = 'rustc'
      local out = trash .. sf:gsub('.rs', '.exe')
      command = (':write | 13split | terminal %s "%s" -o "%s" && "%s"'):format(bin, f, out, out)
   else
      command = ''
   end
   command = command:format(bin, f)

   vim.api.nvim_set_current_dir(twd)
   vim.cmd(command)
   vim.api.nvim_set_current_dir(cwd)
   -- print(ft, f, command)
end

function M.smartfollow()
   local m = vim.api.nvim_get_mode()['mode']
   local ft = vim.bo.filetype
   local command = ''

   if ft == 'markdown' then
      command = '<Plug>Markdown_OpenUrlUnderCursor'
   else
      command = ':lua vim.lsp.buf.definition()<CR>'
   end

   if m == 'i' then command = O .. command end
   return command
end


-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ Version Control
-- └─────────────────────────────────────────────────────────────────────────────
local last_tabpage = vim.api.nvim_get_current_tabpage()
function M.DiffviewToggle()
   local lib = require 'diffview.lib'
   local view = lib.get_current_view()
   if view then
      -- Current tabpage is a Diffview: go to previous tabpage
      vim.api.nvim_set_current_tabpage(last_tabpage)
   else
      -- We are not in a Diffview: save current tabpagenr and go to a Diffview.
      last_tabpage = vim.api.nvim_get_current_tabpage()
      if #lib.views > 0 then
         -- An open Diffview exists: go to that one.
         vim.api.nvim_set_current_tabpage(lib.views[1].tabpage)
      else
         -- No open Diffview exists: Open a new one
         vim.cmd(":DiffviewOpen")
      end
   end
end


-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ Temp
-- └─────────────────────────────────────────────────────────────────────────────
function M.dance()
   for i = 1, 3 do
      -- vim.fn.sleep(2000)
      print(i)
      return ':echo "hey" <CR>'
   end
end

return M
