fx_version 'adamant'
games { 'gta5' };

shared_scripts {
    'shared/*.lua',
    'config/*.lua'
}

server_scripts {
    'server/*.lua'
}

client_scripts {
    'client/*.lua',

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