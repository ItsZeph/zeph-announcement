local function getAllowedTypes(src)
    local list = {}
    if type(Config) ~= 'table' or type(Config.Types) ~= 'table' then return list end
    for key, t in pairs(Config.Types) do
        if type(t) == 'table' and type(t.perm) == 'string' and t.perm ~= '' then
            if IsPlayerAceAllowed(src, t.perm) then
                local label = t.label or t.title or key
                list[#list+1] = { label = label, value = key }
            end
        end
    end
    table.sort(list, function(a, b) return a.label < b.label end)
    return list
end

CreateThread(function()
    if lib and type(lib.callback) == 'table' and type(lib.callback.register) == 'function' then
        lib.callback.register('zeph_announce:getAllowedTypes', function(src)
            return getAllowedTypes(src)
        end)
    end
end)

RegisterCommand('announce', function(source, args, raw)
    local src = source
    if src == 0 then
        print('[zeph-announcement] /announce cannot be used from console')
        return
    end
    local opts = getAllowedTypes(src)
    if #opts == 0 then
        TriggerClientEvent('zeph_announce:notypes', src)
        return
    end
    TriggerClientEvent('zeph_announce:open', src)
end, false)

RegisterNetEvent('zeph_announce:broadcast', function(typeKey, message)
    local src = source
    if type(typeKey) ~= 'string' or type(message) ~= 'string' then return end
    if not Config or not Config.Types or not Config.Types[typeKey] then return end
    local perm = Config.Types[typeKey].perm
    if type(perm) ~= 'string' or perm == '' then return end
    if not IsPlayerAceAllowed(src, perm) then
        TriggerClientEvent('zeph_announce:notypes', src)
        return
    end
    message = message:gsub('\r', ' '):gsub('\n', ' ')
    message = message:gsub('%s+', ' ')
    local maxLen = (Config and Config.MaxLength) or 300
    message = message:sub(1, maxLen)
    if not message:match('%S') then return end
    local author = GetPlayerName(src) or 'Staff'
    TriggerClientEvent('zeph_announce:show', -1, typeKey, message, author)
end)