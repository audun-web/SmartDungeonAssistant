local runStartTime = nil -- variables for timer
local runActive = false

local exitDungeonFrame = CreateFrame("Frame", "SmartResultsFrame", UIParent, "BackdropTemplate") -- resultet frame etter dungeon exit

exitDungeonFrame:SetSize(500, 400)
exitDungeonFrame:SetPoint("CENTER")

exitDungeonFrame:SetBackdrop({ -- design til framen
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

exitDungeonFrame:RegisterEvent("PLAYER_ENTERING_WORLD") -- event når spiller logger inn eller endrer instance

exitDungeonFrame:SetScript("OnEvent", function(self, event)

    C_Timer.After(0, function() -- delay slik at man kan trykke "esc" for å lukke fame

        local inInstance, instanceType = IsInInstance() -- lagrer informasjonen til dungeon spiller er i

        -- ENTER DUNGEON
        if inInstance and instanceType == "party" then
            
            if not runActive then -- starter dungeon timer når spiller går inn i dungeon
                runStartTime = GetTime()
                runActive = true
                wasInDungeon = true
                print("Run has started!")
            end

        -- EXIT DUNGEON
        elseif wasInDungeon then
            
            wasInDungeon = false
            runActive = false

            local runEndTime = GetTime() -- lagrer tiden
            local duration = runEndTime - runStartTime -- lagrer tiden i dungeon

            print("Dungeon Complete!")
            print("Run duration:", duration) -- printer timer resultat

            exitDungeonFrame:Show() -- viser vinduet etter dungeon
        end

    end)

end)

--------------------------------------------------------------------------------------------------------------------

local closeButton = CreateFrame("Button", nil, exitDungeonFrame, "UIPanelCloseButton") -- lukke knapp til resultat vinduet

closeButton:SetSize(32, 32)
closeButton:SetPoint("TOPRIGHT", exitDungeonFrame, "TOPRIGHT", -5, -5) -- topp høyre hjornet
