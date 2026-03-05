fx_version 'cerulean'
game 'gta5'

author 'Zeph'
description 'Simple Announcement Script using ox_lib.'
version '1.1.0'

lua54 'yes'

shared_script '@ox_lib/init.lua'
shared_script 'config.lua'

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua'
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/script.js',
    'html/audio.mp3'
}

dependency 'ox_lib'