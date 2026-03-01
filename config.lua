Config = {}

-- Where the ox_lib notification should appear. Values: 'top', 'top-right', 'top-left', 'center', 'bottom'
-- Default is 'top'
Config.NotifyPosition = 'top'

-- Notification Settings
Config.Title = 'Announcement'
Config.ShowAuthor = true

-- Max characters allowed in the announcement text
Config.MaxLength = 300

-- How long the notification stays on screen (milliseconds)
Config.Duration = 10000

-- Sound Settings (ERROR is the only sound known to work currently.)
Config.Sound = {
    name = 'ERROR',
    set = 'HUD_FRONTEND_DEFAULT_SOUNDSET',
    volume = 1.0 -- volume is managed by the game; kept for clarity
}