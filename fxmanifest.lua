fx_version 'adamant'
games { 'gta5' };

resource_type 'gametype' { name = 'RolePlay' }

shared_scripts {
    'shared/*.lua',
    'config/*.lua',
    'locales/main.lua',
    'locales/lang/*.lua'
}

server_scripts {
    'server/mysql/mysql-async.js',

    'server/*.lua',

    'server/utils/*.lua',

    'server/players/*.lua',

    'server/permissions/*.lua',

    'server/listeners/*.lua',

    'server/mysql/*.lua'
}

client_scripts {
    'client/*.lua',

    'client/utils/*.lua',

    'client/spawn/*.lua',

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
}