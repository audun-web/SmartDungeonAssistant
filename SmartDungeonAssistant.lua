local wasInDungeon = false
local runActive = false
local runStartTime = nil
local runEndTime = nil
local dungeonName = ""
local playerDeaths = 0
local playerJustDied = false


print("SmartDungeonAssistant has loaded!")


local exitDungeonFrame = CreateFrame("Frame", "SmartResultsFrame", UIParent, "BackdropTemplate") -- resultat vinduet som vises når spiller forlater dungeon

exitDungeonFrame:SetSize(200, 150)
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

-- tekst i vinduet
local myText = exitDungeonFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
myText:SetPoint("CENTER", exitDungeonFrame, "CENTER", 0, 0)


-- events som blir registrert
exitDungeonFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
exitDungeonFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
exitDungeonFrame:RegisterEvent("PLAYER_DEAD")

--------------------------------------------------------------------------------------------------------------------

-- lager database hvis database ikke finnes
if not SmartDungeonAssistantDB then
    SmartDungeonAssistantDB = {}
end
-- lager sub database i databse hvis den ikke finnes
if not SmartDungeonAssistantDB.runs then
    SmartDungeonAssistantDB.runs = {}
end

--------------------------------------------------------------------------------------------------------------------


-- hva som skjer når events blir fanget opp
exitDungeonFrame:SetScript("OnEvent", function(self, event)

    if event == "PLAYER_ENTERING_WORLD" then

        C_Timer.After(1, function()

            local inInstance, instanceType = IsInInstance()

            if inInstance and instanceType == "party" then

                playerJustDied = false

                if not runActive then
                    wasInDungeon = true
                    runActive = true

                    playerDeaths = 0

                    runStartTime = GetTime()
                    print("Entered dungeon!")

                    local name = GetInstanceInfo()
                    dungeonName = name
                end

            elseif wasInDungeon and not inInstance and not playerJustDied then

                exitDungeonFrame:Show()

                runEndTime = GetTime()

                local duration = runEndTime - runStartTime
                local formatted = FormatTime(duration)

                wasInDungeon = false

                -- summary
                print("==== Dungeon Complete ====")
                print("- Dungeon:", dungeonName)
                print("- Time used:", formatted)
                print("- Total Deaths:", playerDeaths)
                print("==========================")

                myText:SetText(
                    "Dungeon Complete!\nTime: " .. formatted .. "\nDeaths: " .. playerDeaths
                )

                local runData = {
                    name = dungeonName,
                    duration = duration,    -- tiden i sekunder
                    deaths = playerDeaths,
                    date = date("%Y-%m-%d") -- dagens dato
                }
                
                table.insert(SmartDungeonAssistantDB.runs, runData) -- setter inn informasjonen i sub databasen



                runActive = false

            end

        end)

    elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then

        local _, subevent, _, _, _, _, _, destGUID = CombatLogGetCurrentEventInfo()

        if subevent == "UNIT_DIED" then
            if destGUID == UnitGUID("player") then
                if runActive then
                    playerDeaths = playerDeaths + 1
                    print("You died! Total deaths:", playerDeaths)
                end
            end
        end

    elseif event == "PLAYER_DEAD" then

        playerJustDied = true

    end

end)

--------------------------------------------------------------------------------------------------------------------
-- lukke knapp for vinduet vårt
local closeButton = CreateFrame("Button", nil, exitDungeonFrame, "UIPanelCloseButton")

closeButton:SetSize(32, 32)
closeButton:SetPoint("TOPRIGHT", exitDungeonFrame, "TOPRIGHT", -5, -5)

