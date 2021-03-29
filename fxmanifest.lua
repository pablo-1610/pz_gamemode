fx_version 'adamant'
games { 'gta5' };

resource_type 'gametype' { name = 'RolePlay' }

files {
    'web/index.html',
    'web/overlay.png',
    'web/styles.css'
}

ui_page('web/index.html')

shared_scripts {
    'shared/*.lua',
    'config/*.lua',
    'locales/main.lua',
    'locales/lang/*.lua',

    'addons/**/shared/*.lua'
}

server_scripts {
    'server/mysql/mysql-async.js',

    'server/*.lua',

    'server/mysql/*.lua',

    'server/utils/*.lua',

    'server/players/*.lua',

    'server/rank/*.lua',

    'server/sync/*.lua',

    'server/listeners/*.lua',

    'addons/**/server/*.lua'
}

client_scripts {
    'client/*.lua',

    'client/utils/*.lua',

    'client/spawn/*.lua',

    'client/sync/*.lua',

    'client/listeners/*.lua',

    'client/richPresence/*.lua',

    'client/manager/*.lua',

    -- Implemting RageUI 1.0
    "services/RageUI/client/RMenu.lua",
    "services/RageUI/client/menu/RageUI.lua",
    "services/RageUI/client/menu/Menu.lua",
    "services/RageUI/client/menu/MenuController.lua",
    "services/RageUI/client/components/*.lua",
    "services/RageUI/client/menu/elements/*.lua",
    "services/RageUI/client/menu/items/*.lua",
    "services/RageUI/client/menu/panels/*.lua",
    "services/RageUI/client/menu/windows/*.lua",

    'addons/**/client/*.lua'
}