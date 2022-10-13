fx_version 'cerulean'
game 'gta5'

author 'gab3'
description 'qb-pizzaria'
version '1.2'

shared_scripts {
    'config.lua',
}

client_scripts {
	'@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
	'client/main.lua',
}

server_script 'server/main.lua'