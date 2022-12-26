-- Org Config
-- Powered by neorg (https://github.com/nvim-neorg/neorg)

-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ Setup
-- └─────────────────────────────────────────────────────────────────────────────
local status_ok, neorg = pcall(require, 'neorg')
if not status_ok then
   return
end


-- ┌─────────────────────────────────────────────────────────────────────────────
-- │ Config
-- └─────────────────────────────────────────────────────────────────────────────
neorg.setup {
   load = {
      ['core.defaults'] = {},
      ['core.norg.dirman'] = {
         config = {
            workspaces = {
               all = '~/Dropbox/norg',
               tutorial = '~/Dropbox/norg/tutorial/gtd',
            }
         }
      },
      ['core.gtd.base'] = {
         config = {
            workspace = 'tutorial',
         },
      },
      ['core.norg.concealer'] = {
         config = { -- Note that this table is optional and doesn't need to be provided
            -- Configuration here
         }
      }
   }
}
