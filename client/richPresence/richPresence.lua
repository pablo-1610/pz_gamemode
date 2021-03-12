---@class PZRichPresence
---@field public appId number
---@field public bigLogo string
---@field public bigLogoText string
---@field public smallLogo string
---@field public smallLogoText string
---@field public buttons table
---@field public requiredUpdate boolean
---@field public text string
---@field public task number
PZRichPresence = {}
PZRichPresence.__index = PZRichPresence

setmetatable(PZRichPresence, {
    __call = function(_, appId, bigLogo, bigLogoText, smallLogo, smallLogoText, buttons, text)
        local self = setmetatable({}, PZRichPresence)
        self.appId = appId
        self.bigLogo = bigLogo
        self.bigLogoText = bigLogoText
        self.smallLogo = smallLogo
        self.smallLogoText = smallLogoText
        self.buttons = buttons
        self.requiredUpdate = true
        self.text = text or "Playing on this awesome server"
        return self
    end
})

---invoke
---Invoke the Rich Presence
---@public
---@return void
function PZRichPresence:invoke()
    if self.alive then
        return
    end
    self.alive = true
    PZShared.debug("Rich Presence invoked")
    self.task = PZShared.newRepeatingTask(function()
        if self.requiredUpdate then
            PZShared.debug("Updating Rich Presence")
            SetDiscordAppId(self.appId)
            SetRichPresence(self.text)
            SetDiscordRichPresenceAsset(self.bigLogo)
            SetDiscordRichPresenceAssetText(self.bigLogoText)
            SetDiscordRichPresenceAssetSmall(self.smallLogo)
            SetDiscordRichPresenceAssetSmallText(self.smallLogoText)
            for i = 0, (#self.buttons-1) do
                PZShared.debug("Button "..i.." found (^3"..self.buttons[i+1].title.."^7) & Redirect: ^4"..self.buttons[i+1].redirect.."^7")
                SetDiscordRichPresenceAction(tonumber(i),tostring(self.buttons[i+1].title), tostring(self.buttons[i+1].redirect))
            end
            self.requiredUpdate = false
        else
            PZShared.debug("Rich Presence ^1doesn't ^7require update")
        end
    end, function()
        if self.alive then
            self.alive = false
        end
    end, 0, 10000)
end

---destroy
---Destroy the RP
---@public
---@return void
function PZRichPresence:destroy()
    if self.alive then
        self.alive = false
        PZShared.cancelTaskNow(self.task)
        PZShared.debug("Rich Presence destroyed")
    end
end

---updateMessage
---Change the RP current message
---@param message string
---@public
---@return void
function PZRichPresence:updateMessage(message)
    if self.alive then
        PZShared.debug("Rich Presence message changed to: "..message)
        self.text = message
        self.requiredUpdate = true
    end
end