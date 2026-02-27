# Phase 1 - Core Dungeon Detection

- [x] Detects player entering dungeon
- [x] Detects Player leaving dungeon
- [ ] Starts run timer upon entering dungeon
- [ ] Stops timer when leaving dungeon
- [ ] Basic run summary after dungeon
- [ ] Stores dungeon name `getInstanceInfo()`
  
# Phase 2 - Run Tracking System

- [ ] Track total deaths during dungeon `party-wide`
- [ ] Track player deaths during dungeon `separatly`
- [ ] Detect dungeon wipes `all-players-dead`
- [ ] Track player XP at dungeon start
- [ ] Calculate total XP earned when dungeon ends
- [ ] Format time as `MM:SS - 15:32`

# Phase 3 - Quest Tracking

- [ ] Detects active quest when entering dungeon
- [ ] Filter dungeon related quests
- [ ] Scan party members
- [ ] Detects who does NOT have each quest
- [ ] prints missings quests in chat
- [ ] Stores quest completion per run

# Phase 4 - Saved Variables

- [ ] Create SavedVariables table
- [ ] Save each dungeon run to history
- [ ] Store `Dungeon name, time, deaths, wipes, xp gains, date`
- [ ] Load history on login
- [ ] Add `/sda history` custom command in chat

# Phase 5 - UI system

- [ ] Show results window on dungeon exit
- [ ] Add title `dungeon name`
- [ ] Display `time, deaths, wipes, xp gains`
- [ ] Add close button `esc`
- [ ] Make window draggable
- [ ] Add scrollable history list
- [ ] Add `delete history` button

# Phase 6 - Advanced Polish

- [ ] Add colored text formatting
- [ ] Add average run time calculation
- [ ] Add fastest run highlight
- [ ] Add gold earned tracking
- [ ] Add toggle in interface options
- [ ] Add minimap button