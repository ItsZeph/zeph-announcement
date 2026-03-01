-- Only edit if you know what you are doing.

local PERM = 'announce.command'

CreateThread(function()
    if lib and type(lib.callback) == 'table' and type(lib.callback.register) == 'function' then
        lib.callback.register('zeph_announce:canUse', function(src)
            return IsPlayerAceAllowed(src, PERM)
        end)
    else
        print('[zeph-announcement] lib.callback.register not available; client pre-check will be skipped.')
    end
end)

RegisterNetEvent('zeph_announce:broadcast', function(message)
    local src = source

    if not IsPlayerAceAllowed(src, PERM) then
        TriggerClientEvent('zeph_announce:denied', src)
        return
    end

    if type(message) ~= 'string' then return end
    message = message:gsub('\r', ' '):gsub('\n', ' ')
    message = message:gsub('%s+', ' ')

    local maxLen = 300
    if type(Config) == 'table' and type(Config.MaxLength) == 'number' then
        maxLen = Config.MaxLength
    end
    message = message:sub(1, maxLen)

    if not message:match('%S') then return end

    local author = GetPlayerName(src) or 'Staff'
    TriggerClientEvent('zeph_announce:show', -1, message, author)
end)

RegisterCommand('announce', function(source, args, raw)
    local src = source

    if src == 0 then
        print('^3[zeph-announcement]^7 The /announce command cannot be used from server console.')
        return
    end

    if not IsPlayerAceAllowed(src, PERM) then
        TriggerClientEvent('zeph_announce:denied', src)
        return
    end

    TriggerClientEvent('zeph_announce:open', src)
end, false)