-- Hop Config
-- Powered by hop (https://github.com/phaazon/hop.nvim)

-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ Setup
-- └─────────────────────────────────────────────────────────────────────────────
local status_ok, hop = pcall(require, 'hop')
if not status_ok then
   return
end


-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ Config
-- └─────────────────────────────────────────────────────────────────────────────
hop.setup {
   keys = '(.,/)_@\\*-%$stnrfgwldkphbcejqvxyzaomuiSTNRFGWLDKPHBCEJQVXYZAOMUI',
}
