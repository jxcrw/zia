-- Faststart Config
-- Powered by impatient (https://github.com/lewis6991/impatient.nvim)

-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ Setup
-- └─────────────────────────────────────────────────────────────────────────────
local status_ok, impatient = pcall(require, 'impatient')
if not status_ok then
   return
end


-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ Config
-- └─────────────────────────────────────────────────────────────────────────────
impatient.enable_profile()
