PZShared.netRegisterAndHandle("playerSpawned", function()
    if PZConfig.richPresence.enabled then
        PZClient.richPresence = PZRichPresence(
                PZConfig.richPresence.discord_appId,
                PZConfig.richPresence.discord_bigLogo,
                PZConfig.richPresence.discord_bigLogoText,
                PZConfig.richPresence.discord_smallLogo,
                PZConfig.richPresence.discord_smallLogoText,
                PZConfig.richPresence.discord_buttons,
                PZConfig.richPresence.discord_defaultText
        )
        PZClient.richPresence:invoke()
    end
end)