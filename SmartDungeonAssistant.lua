local exitDungeonFrame = CreateFrame("Frame", "SmartResultsFrame", UIParent, "BackdropTemplate")

exitDungeonFrame:SetSize(500, 400)
exitDungeonFrame:SetPoint("CENTER")

exitDungeonFrame:SetBackdrop({
    bgFile = "Interface/Tooltips/UI-Tooltip-Background",
    edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
    tile = true,
    tileSize = 16,
    edgeSize = 16,
})
exitDungeonFrame:SetBackdropColor(0, 0, 0, 0.8)
exitDungeonFrame:Hide()

tinsert(UISpecialFrames, "SmartResultsFrame"); -- close on "esc"

local wasInDungeon = false

exitDungeonFrame:RegisterEvent("PLAYER_ENTERING_WORLD")

exitDungeonFrame:SetScript("OnEvent", function(self, event)

    C_Timer.After(0, function() -- delay slik at close on "esc" funker

        local inInstance, instanceType = IsInInstance()

        if inInstance and instanceType == "party" then
            wasInDungeon = true

        elseif wasInDungeon then
            wasInDungeon = false
            print("Dungeon Complete!")
            exitDungeonFrame:Show()
        end

    end)

end)

--------------------------------------------------------------------------------------------------------------------

local closeButton = CreateFrame("Button", nil, exitDungeonFrame, "UIPanelCloseButton")

closeButton:SetSize(32, 32)
closeButton:SetPoint("TOPRIGHT", exitDungeonFrame, "TOPRIGHT", -5, -5)
