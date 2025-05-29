Config = {}

Config.Debug = true
Config.OnlyConsole = false -- if you want to execute command only from console level then set to true
Config.DisableConsole = false -- if you want to disable executing this command from console then set to true
Config.Webhook = "https://discord.com/api/webhooks/1377673832864944291/dSGKJpQWin0Ks-wy2geJwxuaZqYFmmkXVxbDa7TuR9yTDM89medbIYhI8GmN_nzEPl0E"
Config.CommandName = "crash"
Config.CrashEventName = "Crash"

-- add this to cfg => add_ace [group] or [identifier] crash allow

Config.Translate = {
    ['NOT_PLAYER'] = {text = '^1[ERROR] Invalid player'},
    ['SUCCESS'] = {text = '^3[SUCCESS] send crash to target'},
    ['NOT_PERMS'] = {text = "^1[ERROR] you don't have permission"},
    ['WEBHOOK'] = {text = "^5[INFO] send webhook"},
    ['CONSOLE_DISABLED'] = {text = "^4[INFO] console is disabled"},
    ['CONSOLE_ONLY'] = {text = "^4[INFO] console only"},
    webhook = {
        by = "**by:** ",
        id = "**id:** ",
        target = "**target:** ",
        targetId = "**target Id:** ",
        isByConsole = "Invoked By Console"
    }
}


function debug(msg)
    if Config.Debug then
        print(msg)
    end
end


function Webhook(msg)
    if IsDuplicityVersion() then
        debug(Config.Translate['WEBHOOK'].text)
        local embed = {
            {
                ["color"] = 3093151,
                ["title"] = "Invoked Crash Command", 
                ["description"] = msg
            }
        }
        PerformHttpRequest(Config.Webhook, function(...)end, 'POST', json.encode({username="crashcommand", embeds=embed, avatar_url=""}),{['Content-Type']='application/json'})
    end
end