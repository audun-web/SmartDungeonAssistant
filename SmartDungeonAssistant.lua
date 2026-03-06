local wasInDungeon = false
local runActive = false
local runStartTime = nil
local runEndTime = nil


print("SmartDungeonAssistant has loaded!")


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

-- funksjon som endrer tiden til riktig format - mm:ss (uvanlig å bruke flere timer)
local function FormatTime(seconds)
    local mintutes = math.floor(seconds / 60)
    local secs = math.floor(seconds % 60)
    return string.format("%02d:%02d", mintutes, secs)
end

-- events som blir registrert
exitDungeonFrame:RegisterEvent("PLAYER_ENTERING_WORLD")


-- hva som skjer når events blir fanget opp
exitDungeonFrame:SetScript("OnEvent", function(self, event)

    C_Timer.After(1, function() -- delay

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

            runEndTime = GetTime()

            local duration = runEndTime - runStartTime
            local formatted = FormatTime(duration)
            
            wasInDungeon = false

            print("Dungeon Complete!")
            print("Time:", formatted)

        end

    end)

end)

--------------------------------------------------------------------------------------------------------------------
-- lukke knapp for vinduet vårt
local closeButton = CreateFrame("Button", nil, exitDungeonFrame, "UIPanelCloseButton")

closeButton:SetSize(32, 32)
closeButton:SetPoint("TOPRIGHT", exitDungeonFrame, "TOPRIGHT", -5, -5)