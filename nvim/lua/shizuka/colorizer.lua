-- Colorizer Config
-- Powered by nvim-colorizer (https://github.com/norcalli/nvim-colorizer.lua)

-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ Setup
-- └─────────────────────────────────────────────────────────────────────────────
local status_ok, colorizer = pcall(require, 'colorizer')
if not status_ok then
   return
end


-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ Config
-- └─────────────────────────────────────────────────────────────────────────────
colorizer.setup()
