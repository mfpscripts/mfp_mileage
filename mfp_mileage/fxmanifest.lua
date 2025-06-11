fx_version 'cerulean'
games { 'gta5' }

author 'MFPSCRIPTS'
version '1.6.1'
description 'THIS IS A HELP RESOURCE FROM MFPSCRIPTS.com'

lua54 'yes'

escrow_ignore {
  'client.lua',
  'config.lua'
}

shared_script 'config.lua'
client_script 'client.lua'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server.lua'
}

--- THIS IS A FREE RESOURCE ----
--- MFPSCRIPTS.com ---