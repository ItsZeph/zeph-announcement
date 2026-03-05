Config = {}

-- Where the ox_lib notification should appear. For top-middle, use 'top'.
Config.NotifyPosition = 'top'

-- Show the author's name (the player who sent it) in the title
Config.ShowAuthor = false

-- Max characters allowed in the announcement text
Config.MaxLength = 300

-- How long the notification stays on screen (milliseconds)
Config.Duration = 10000

-- Announcement types:
-- Each type:
--   label:    shown in the dropdown
--   title:    used in the notification title
--   icon:     use https://fontawesome.com/icons
--   color:    hex color for the icon (e.g., '#4b8bf4')
--   perm:     ACE permission required to use this type. You must give this permissions to a group for it to appear. Do this in your server.cfg or your preferred cfg file.
-- Types will only appear in the dropdown if the player has the required ACE permission. Make sure to set up your permissions correctly for this to work.
Config.Types = {
    -- EXAMPLE TYPE
    -- server = {
        -- label = 'Server',
        -- title = 'Server Announcement',
        -- icon = 'fa-solid fa-bullhorn',
        -- color = '#4b8bf4',
        -- perm = 'announce.server'
    -- },
    server = {
        label = 'Server',
        title = 'Server Announcement',
        icon = 'fa-solid fa-bullhorn',
        color = '#4b8bf4',
        perm = 'announce.server'
    },
    staff = {
        label = 'Staff',
        title = 'Staff Announcement',
        icon = 'fa-solid fa-user-shield',
        color = '#f59e0b',
        perm = 'announce.staff'
    },
    lspd = {
        label = 'LSPD',
        title = 'LSPD Announcement',
        icon = 'fa-solid fa-shield-halved',
        color = '#2563eb',
        perm = 'announce.lspd'
    },
    safr = {
        label = 'SAFR',
        title = 'SAFR Announcement',
        icon = 'fa-solid fa-kit-medical',
        color = '#ef4444',
        perm = 'announce.safr'
    },
}