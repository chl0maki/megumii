local discordia = require("discordia")
local http = require("../coro-http")
local json = require("../json")
local logger = discordia.Logger(3, "%F %T")

local random = math.random

local f = string.format

local file = io.open("./config.json", r)
local content = file:read("*all")
local config = json.decode(content)
file:close()

local prefix = config["prefix"]
local owners = config["owners"]

local cmds = {}

local function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end


cmds["dog"] = function(arg, message)
local get, body = http.request("GET", "https://random.dog/woof.json")
    message.channel:send {
        embed = {
        title = "dog",
        image = { url = json.decode(body)["url"] }
        }
    }
end

cmds["cat"] = function(arg, message)
local get, body = http.request("GET", "https://aws.random.cat/meow")
    message.channel:send {
        embed = {
        title = "cat",
        image = { url = json.decode(body)["url"] }
        }
    }
end

cmds["hug"] = function(arg, message)
    message.channel:send {
        embed = {
        description = string.format("You hugged %s!", message.mentionedUsers.first.mentionString),
        image = { url = "https://media.tenor.com/images/1f667730f4380bfe2093b4e9d69883ed/tenor.png" }
        }
    }
end

cmds["hentai"] = function(arg, message)
    if message.channel.nsfw then
        local get, body = http.request("GET", "https://nekos.life/api/v2/img/lewd")
        message.channel:send {
            embed = {
                title = json.decode(body)["url"],
                image = { url = json.decode(body)["url"] }
            }
        }
    end
end

cmds["coinflip"] = function(arg, message)
    return f("You flip a coin. It lands on %s.", random(2) == 1 and "heads" or "tails")
end

cmds["sonic"] = function(arg, message)
	return "<:sonic:412304114270208011>"
end

cmds["update"] = function(arg, message)
    if has_value(owners, message.author.id) then
        message.channel:send("updating...")
        logger:log(3, "updating bot...")
        print(os.execute("git pull"))
    else
        return "only the owner can use this"
    end
end

cmds["cmds"] = function(arg, message)
    local keyset={}
    local n=0

    for k,v in pairs(cmds) do
        n=n+1
        keyset[n]=k
    end
    
    local commandslist = table.concat(keyset, ', ' .. prefix)
	return "current commands are: =" .. commandslist .. ". \n(note: check https://aws.random.cat/meow if =cat doesnt work.) if =hentai doesn't work, name your nsfw channel to nsfw"
end

return cmds
