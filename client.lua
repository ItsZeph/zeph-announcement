
local durationDefault = (Config and Config.Duration) or 10000
local currentId = nil

local function notifyNoTypes()
    if lib and lib.notify then
        lib.notify({
            title = 'Announcement',
            description = 'You do not have access to any announcement types.',
            position = (Config and Config.NotifyPosition) or 'top',
            type = 'error',
            duration = 6000
        })
    else
        TriggerEvent('chat:addMessage', { args = { 'Announcement', 'You do not have access to any announcement types.' } })
    end
end

local function notifyDenied(msg)
    if lib and lib.notify then
        lib.notify({
            title = 'Announcement',
            description = msg or 'You do not have permission to perform this action.',
            position = (Config and Config.NotifyPosition) or 'top',
            type = 'error',
            duration = 6000
        })
    else
        TriggerEvent('chat:addMessage', { args = { 'Announcement', msg or 'You do not have permission to perform this action.' } })
    end
end

local function openWithTypes(options)
    if not lib or not lib.inputDialog then
        notifyNoTypes()
        return
    end
    if type(options) ~= 'table' or #options == 0 then
        notifyNoTypes()
        return
    end
    local maxLen = (Config and Config.MaxLength) or 300
    local input = lib.inputDialog('Server Announcement', {
        { type = 'select', label = 'Announcement type', options = options, required = true },
        { type = 'number', label = 'Duration (ms)', default = durationDefault, placeholder = '10000 = 10 seconds' },
        { type = 'input', label = 'Announcement message', placeholder = 'Enter the announcement textâ€¦', required = true, min = 1, max = maxLen }
    })
    if not input then return end
    local typeKey = input[1]
    local durationMs = input[2]
    local message = input[3]
    if type(typeKey) ~= 'string' or type(message) ~= 'string' then return end
    message = message:gsub('^%s+',''):gsub('%s+$','')
    if #message == 0 then return end
    if #message > maxLen then message = string.sub(message, 1, maxLen) end
    if type(durationMs) ~= 'number' or durationMs <= 0 then durationMs = nil end
    TriggerServerEvent('zeph_announce:broadcast', typeKey, message, nil, nil, durationMs)
end

local function openAnnounceDialog()
    local options = {}
    if lib and lib.callback and type(lib.callback.await) == 'function' then
        options = lib.callback.await('zeph_announce:getAllowedTypes', false) or {}
    end
    openWithTypes(options)
end

RegisterNetEvent('zeph_announce:open', function()
    openAnnounceDialog()
end)

RegisterNetEvent('zeph_announce:notypes', function()
    notifyNoTypes()
end)

RegisterNetEvent('zeph_announce:denied', function(reason)
    notifyDenied(reason)
end)

RegisterNetEvent('zeph_announce:show', function(typeKey, message, author, titleOverride, showAuthorSel, durationMs)
    local tcfg = (Config and Config.Types and Config.Types[typeKey]) or {}
    local title = tcfg.title or 'Announcement'
    local showA = (type(showAuthorSel) == 'boolean') and showAuthorSel or ((Config and Config.ShowAuthor) and true or false)
    if showA and author and author ~= '' then
        title = title .. ' â€” ' .. author
    end
    local dur = (type(durationMs) == 'number' and durationMs > 0) and durationMs or durationDefault
    if lib and lib.notify then
        if currentId then
            lib.notify({
                id = currentId,
                title = ' ',
                description = ' ',
                position = (Config and Config.NotifyPosition) or 'top',
                type = 'inform',
                duration = 1
            })
        end
        currentId = ('zeph_announce_' .. tostring(GetGameTimer()))
        lib.notify({
            id = currentId,
            title = title,
            description = message,
            position = (Config and Config.NotifyPosition) or 'top',
            type = 'inform',
            duration = dur,
            icon = tcfg.icon,
            iconColor = tcfg.color
        })
    else
        TriggerEvent('chat:addMessage', { args = { title, message } })
    end
    SendNUIMessage({ action = 'play' })
end)

RegisterNetEvent('zeph_announce:cancel', function()
    if lib and lib.notify and currentId then
        lib.notify({
            id = currentId,
            title = ' ',
            description = ' ',
            position = (Config and Config.NotifyPosition) or 'top',
            type = 'inform',
            duration = 1
        })
    end
    currentId = nil
    SendNUIMessage({ action = 'stop' })
end)

RegisterCommand('announce', function()
    openAnnounceDialog()
end, false)

CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/announce', 'Send a server-wide announcement')
end)