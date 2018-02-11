-- kms
-- also, if you came here for a token, move away because there aint any tokens.

-- functions

local discordia = require('discordia')
local client = discordia.Client()
local json = require('json')

local date, time = os.date, os.time

-- commands

client:on('ready', function()
	print('bitch you logged in as '.. client.user.username)
end)

client:on('messageCreate', function(message)
	if message.content == '=sonic' then
		message.channel:send('<:sonic:412304114270208011>')
	end
end)

client:on('messageCreate', function(message)
if message.content == 'prefix' then
		message.channel:send('the prefix for me is =')
	end
end)

client:on('messageCreate', function(message)
if message.content == '=cmds' then
		message.channel:send('current commands are: =sonic (must require sonic emoji), prefix and =cmds.')
	end
end)

client:run('Bot insert_token_here')