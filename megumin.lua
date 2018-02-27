-- kms
-- also, if you came here for a token, move away because there aint any tokens.

-- functions

local discordia = require("discordia")
local json = require("./json")

local stuff = require("./modules/stuff")

function string.starts(String, Start)
	return string.sub(String, 1, string.len(Start)) == Start
end

local client = discordia.Client()
local logger = discordia.Logger(3, '%F %T')

local file = io.open("./config.json", r)
local content = file:read("*all")
local json_file = json.decode(content)
file:close()

client:on(
	"ready",
	function()
		logger:log(3, "bitch you logged in as %s", client.user.username)
	end
)

client:on(
	"messageCreate",
	function(message)
		local prefix = json_file["prefix"]

		if not string.starts(message.content, prefix) then
			return
		end
		local content = message.content:sub(prefix:len() + 1)
		local cmds, arg = content:match("(%S+) (.*)")

		cmds = cmds or content

		if stuff[cmds] then
			stuff[cmds](arg, message)
		end
	end
)

client:run("Bot " .. json_file["token"])
