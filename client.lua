-- Only edit this if you know what you are doing. Parts that are safe to edit have been marked with comments.

local duration = (Config and Config.Duration) or 10000

local function playNotifySound()
    if Config and Config.Sound and Config.Sound.name then
        PlaySoundFrontend(-1, Config.Sound.name, Config.Sound.set or 'HUD_FRONTEND_DEFAULT_SOUNDSET', true)
    end
end

local function openAnnounceDialog()
    if not lib or not lib.inputDialog then
        TriggerEvent('zeph_announce:denied', 'ox_lib input UI not available on this client.')
        return
    end

    local maxLen = (Config and Config.MaxLength) or 300

    local input = lib.inputDialog('Server Announcement', { -- Safe to edit.
        { type = 'input', label = 'Announcement message', placeholder = 'Enter the announcement text…', required = true, min = 1, max = maxLen } -- 'Label' and 'Placeholder' are safe to edit.
    })

    if not input then
        return
    end

    local message = input[1]
    if type(message) ~= 'string' then
        return
    end

    message = message:gsub('^%s+', ''):gsub('%s+$', '')
    if #message == 0 then
        return
    end

    if #message > maxLen then
        message = string.sub(message, 1, maxLen)
    end

    TriggerServerEvent('zeph_announce:broadcast', message)
end

RegisterNetEvent('zeph_announce:show', function(message, author)
    local title = (Config and Config.Title) or 'Announcement'
    if (Config and Config.ShowAuthor) and author and author ~= '' then
        title = (title .. ' — ' .. author)
    end

    if lib and lib.notify then
        lib.notify({
            title = title,
            description = message,
            position = (Config and Config.NotifyPosition) or 'top',
            type = 'warning', -- Safe to edit.
            duration = duration
        })
    else
        TriggerEvent('chat:addMessage', { args = { title, message } })
    end

    playNotifySound()
end)

RegisterNetEvent('zeph_announce:denied', function(reason)
    local msg = reason or 'You do not have permission to use /announce.' -- Safe to edit.
    if lib and lib.notify then
        lib.notify({
            title = 'Insufficient Permissions', -- Safe to edit.
            description = msg,
            position = (Config and Config.NotifyPosition) or 'top',
            type = 'error',
            duration = 6000
        })
    else
        TriggerEvent('chat:addMessage', { args = { 'Announcement', msg } })
    end

    PlaySoundFrontend(-1, 'ERROR', 'HUD_FRONTEND_DEFAULT_SOUNDSET', true)
end)

RegisterCommand('announce', function()
    local allowed = true

    if lib and lib.callback and type(lib.callback.await) == 'function' then
        allowed = lib.callback.await('zeph_announce:canUse', false)
    end

    if not allowed then
        TriggerEvent('zeph_announce:denied')
        return
    end

    openAnnounceDialog()
end, false)

RegisterNetEvent('zeph_announce:open', function()
    openAnnounceDialog()
end)

CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/announce', 'Send a server-wide announcement')
end)