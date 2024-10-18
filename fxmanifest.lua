fx_version 'cerulean'
game 'gta5'

author 'YourName'
description 'Ghost Bridge - Modular Framework Handler for FiveM'
version '1.0.0'

shared_scripts {
    'modules/require.lua',
    'init.lua'
}

client_scripts {
    'src/cl_main.lua',
}

server_scripts {
    'src/sv_main.lua',
}

files {
    'modules/require.lua',
    'modules/Player/*.lua',
    'modules/Money/*.lua',
    'modules/Notification/*.lua'
}

lua54 'yes'
