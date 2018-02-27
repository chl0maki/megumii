-- kms
-- also, if you came here for a token, move away because there aint any tokens.

-- functions

local discordia = require("discordia")
local client = discordia.Client()
local json = require("json")
local http = require("./coro-http")

local random = math.random

local date, time = os.date, os.time
client:on(
	"messageCreate",
	function(message)
		if message.content == "=sonic" then
			message.channel:send("<:sonic:412304114270208011>")
		end
	end
)

client:on(
	"messageCreate",
	function(message)
		if message.content == "prefix" then
			message.channel:send("the prefix for me is =")
		end
	end
)

client:on(
	"messageCreate",
	function(message)
		if message.content == "=cmds" then
			message.channel:send("current commands are: =sonic (must require sonic emoji), prefix and =cmds.")
		end
	end
)

client:on(
	"ready",
	function()
		print("bitch you logged in as " .. client.user.username)
	end
)

client:on(
	"messageCreate",
	function(message)
		if message.content == "=coinflip" then
			local a = string.format("You flip a coin. It lands on %s.", random(2) == 1 and "heads" or "tails")
			message.channel:send(a)
		end
	end
)

client:on(
	"messageCreate",
	function(message)
		if message.content == "=cat" then
			local get, body = http.request("GET", "http://random.cat/meow")
			message.channel:send(json.decode(body)["file"])
		end
	end
)

client:on(
	"messageCreate",
	function(message)
		if message.content == "=dog" then
			local get, body = http.request("GET", "https://random.dog/woof.json")
			message.channel:send(json.decode(body)["url"])
		end
	end
)

client:run("Bot token")