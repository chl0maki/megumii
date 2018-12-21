--[[
	kms
	also, if you came here for a token, move away because there aint any tokens.

	special thanks to geni#0020 or https://github.com/geniiii
]]


--functions--

local discordia = require("discordia")
local json = require("./json")

local stuff = require("./modules/stuff")

local a = "Prefix is '%s' || https://discord.gg/gVHyBAJ"

function string.starts(String, Start)
	return string.sub(String, 1, string.len(Start)) == Start
end

local client = discordia.Client()
local logger = discordia.Logger(3, "%F %T")

local file = io.open("./config.json", r)
local content = file:read("*all")
local config = json.decode(content)
file:close()

--commands--

client:on(
    "ready",
    function()
        client:setGame(a:format(config["prefix"]))
        logger:log(3, "bitch you logged in as %s", client.user.username)
    end
)

client:on(
	"messageCreate",
	function(message)
		local prefix = config["prefix"]

		if not string.starts(message.content, prefix) then
			return
		end
		local content = message.content:sub(prefix:len() + 1)
		local cmds, arg = content:match("(%S+) (.*)")

		cmds = cmds or content

		if stuff[cmds] then
			local commandoutput = stuff[cmds](arg, message)
			if commandoutput ~= nil then
				message.channel:send(commandoutput)
			end
		end
	end
)

client:run("Bot " .. config["token"])
