local wasInDungeon = false
local runActive = false
local runStartTime = nil




local exitDungeonFrame = CreateFrame("Frame", "SmartResultsFrame", UIParent, "BackdropTemplate") -- resultat vinduet som vises når spiller forlater dungeon

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

tinsert(UISpecialFrames, "SmartResultsFrame") -- "esc" lukker vinduet

-- events som blir registrert
exitDungeonFrame:RegisterEvent("PLAYER_ENTERING_WORLD")


-- hva som skjer når events blir fanget opp
exitDungeonFrame:SetScript("OnEvent", function(self, event)

    C_Timer.After(0, function() -- delay

        local inInstance, instanceType = IsInInstance()

        -- ENTER DUNGEON
        if inInstance and instanceType == "party" then
            
            if not runActive then
                wasInDungeon = true
                runActive = true

                runStartTime = GetTime()
                print("Entered dungeon!")
            end

        -- EXIT DUNGEON
        elseif wasInDungeon then

            exitDungeonFrame:Show()

            local runEndTime = GetTime()

            local duration = runEndTime - runStartTime
            
            wasInDungeon = false

            print("Dungeon Complete!")
            print("Time:", duration)

        end

    end)

end)

--------------------------------------------------------------------------------------------------------------------
-- lukke knapp for vinduet vårt
local closeButton = CreateFrame("Button", nil, exitDungeonFrame, "UIPanelCloseButton")

closeButton:SetSize(32, 32)
closeButton:SetPoint("TOPRIGHT", exitDungeonFrame, "TOPRIGHT", -5, -5)