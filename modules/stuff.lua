local discordia = require("discordia")
local http = require("../coro-http")
local json = require("../json")

local random = math.random

local cmds = {}

cmds["dog"] = function(arg, message)
	local get, body = http.request("GET", "https://random.dog/woof.json")
	message.channel:send(json.decode(body)["url"])
end

cmds["cat"] = function(arg, message)
	local get, body = http.request("GET", "http://aws.random.cat/meow")
	message.channel:send(json.decode(body)["file"])
end

cmds["hentai"] = function(arg, message)
    if message.channel.nsfw then
        local get, body = http.request("GET", "https://nekos.life/api/v2/img/lewd")
        message.channel:send {
            embed = {
                title = "hentai",
                image = { url = json.decode(body)["url"] }
            }
        }
    end
end

cmds["coinflip"] = function(arg, message)
	local a = string.format("You flip a coin. It lands on %s.", random(2) == 1 and "heads" or "tails")
	message.channel:send(a)
end

cmds["cmds"] = function(arg, message)
	message.channel:send("current commands are: =sonic, =cat, =dog, =hentai (nsfw channel), =coinflip and =cmds.")
end

cmds["sonic"] = function(arg, message)
	message.channel:send("<:sonic:412304114270208011>")
end

return cmds
