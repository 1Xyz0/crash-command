RegisterCommand(tostring(Config.CommandName), function(source, args)
    local target = args[1]
    local SuccesfullySend = false
    local ByConsole = false

    if not target then return end

    local name = GetPlayerName(target)

    if not name then
        return debug(Config.Translate['NOT_PLAYER'].text)
    end


    if Config.OnlyConsole then
        if source == 0 then
            if Config.DisableConsole then
                return debug(Config.Translate['CONSOLE_DISABLED'].text)
            end

            SuccesfullySend = true 
            ByConsole = true
        else
            debug(Config.Translate['CONSOLE_ONLY'].text)
        end
    else
        local canUse = false

        if source == 0 then
            if Config.DisableConsole then 
                return debug(Config.Translate['CONSOLE_DISABLED'].text)
            end

            canUse = true
            ByConsole = true

        elseif IsPlayerAceAllowed(source, "crash") then
            canUse = true
        end

        if canUse then
            SuccesfullySend = true
        else
            debug(Config.Translate['NOT_PERMS'].text)
        end
    end


    if SuccesfullySend then
        TriggerClientEvent(Config.CrashEventName, target) 

        local discordTarget = GetPlayerIdentifierByType(target, 'discord')

        if ByConsole then
            Webhook(Config.Translate.webhook.by .. Config.Translate.webhook.isByConsole .. "\n" .. Config.Translate.webhook.target .. "<@".. string.gsub(discordTarget, "discord:", "") .. ">" .. "\n" .. Config.Translate.webhook.targetId .. target)
        else
            local discordInvoked = GetPlayerIdentifierByType(source, 'discord')

            Webhook(Config.Translate.webhook.by .. "<@".. string.gsub(discordInvoked, "discord:", "") .. ">" .. "\n" .. Config.Translate.webhook.id .. source .. "\n" .. Config.Translate.webhook.target .. "<@".. string.gsub(discordTarget, "discord:", "") .. ">" .. "\n" .. Config.Translate.webhook.targetId .. target)
        end

        debug(Config.Translate['SUCCESS'].text)
    end
    
end, false)