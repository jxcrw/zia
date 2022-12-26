-- Common Utils

-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ Setup
-- └─────────────────────────────────────────────────────────────────────────────
M = {}
local context = require('cmp.config.context')


-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ Utils
-- └─────────────────────────────────────────────────────────────────────────────
function M.in_comment()
   if context.in_treesitter_capture('comment') == true or context.in_syntax_group('Comment') then
      return true
   else
      return false
   end
end

return M
