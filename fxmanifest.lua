fx_version 'cerulean'
game 'gta5'

author 'Zeph'
description 'Simple Announcement Script using ox_lib.'
version '1.0.0'

lua54 'yes'

shared_script '@ox_lib/init.lua'
shared_script 'config.lua'

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua'
}

dependency 'ox_lib'