local discordia = require("discordia")
local http = require("../coro-http")
local json = require("../json")

local random = math.random

local file = io.open("./config.json", r)
local content = file:read("*all")
local config = json.decode(content)
file:close()

local prefix = config["prefix"]

local cmds = {}

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
	local a = string.format("You flip a coin. It lands on %s.", random(2) == 1 and "heads" or "tails")
	message.channel:send(a)
end

cmds["sonic"] = function(arg, message)
	message.channel:send("<:sonic:412304114270208011>")
end


cmds["cmds"] = function(arg, message)
    local keyset={}
    local n=0

    for k,v in pairs(cmds) do
        n=n+1
        keyset[n]=k
    end
    
    local commandslist = concat(keyset, ', ' .. prefix)
	message.channel:send("current commands are: =" .. commandslist .. ". (note: check https://aws.random.cat/meow if =cat doesnt work.) if =hentai doesn't work, name your nsfw channel to nsfw, nsfw-chat, or hentai.")
end

return cmds
