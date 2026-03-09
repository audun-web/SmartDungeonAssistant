## SmartDungeonAssistant Addon for World of Warcraft Classic Era

### Beskrivelse

SmartDungeonAssistant er en enkel, men nyttig dungeon-tracker skrevet i Lua for World of Warcraft Classic Era. Addonen registrerer når du går inn og ut av femmanns-dungeons, starter en timer automatisk ved inngang, og viser deg en kort oppsummering når du er ferdig.

Når du fullfører en dungeon får du:

- **Total tid brukt på runden** (automatisk formatert som `MM:SS`, f.eks. `15:32`)
- **Antall ganger spilleren har dødd i løpet av runden**
- **Navn på dungeon**

Et lite resultatvindu dukker opp på skjermen når du forlater dungeonen, med samme informasjon, og kan lukkes med `Esc` eller med lukkeknappen i hjørnet. Alle rundene dine lagres i en egen SavedVariables-tabell (`SmartDungeonAssistantDB`), slik at du kan se tilbake på historikken senere.

Addonen er bygget opp i flere faser (se også `docs/TODO.md`), der kjernefunksjonaliteten allerede er på plass:

- **Ferdig implementert nå**
  - Oppdager når spilleren går inn i en dungeon og når spilleren forlater den
  - Starter og stopper løpetid automatisk
  - Viser en enkel oppsummering etter hver dungeon
  - Teller dødsfall for spilleren i løpet av runden
  - Lagrer hver runde med navn, varighet, dødsfall og dato i en historikk
  - Egen chat-kommando for å vise historikk
- **Planlagte utvidelser (ikke ferdig ennå)**
  - Telle samlede dødsfall for hele gruppen
  - Oppdage fullstendige wipes (alle dør)
  - Spore XP ved start og beregne total XP opptjent i dungeon
  - Quest-tracking for å se hvem i gruppen som mangler dungeon-relaterte quests
  - Mer avansert UI: tittel med dungeon-navn, flere statistikker, historikk-liste, sletting av runder, minimap-knapp, m.m.

### Hvordan bruke addonen i spillet

Når addonen er aktiv og du går inn i en instans-dungeon (5-manns), vil den:

- Starte en intern timer idet du kommer inn
- Nulle ut tidligere dødsfall for en ny runde
- Registrere navnet på dungeonen automatisk

Når du forlater dungeonen (uten at du akkurat har dødd), vil den:

- Stoppe timeren og regne ut varigheten
- Skrive en oppsummering i chat:
  - Dungeon-navn
  - Tidsbruk
  - Totalt antall deaths for spilleren
- Vise et lite resultatvindu midt på skjermen med samme informasjon
- Lagre runden i `SmartDungeonAssistantDB.runs` med dato

Du kan når som helst skrive `/sdahistory` i chat for å få printet ut en liste med tidligere runs i konsollen, inkludert:

- Løpenummer
- Dungeon-navn
- Tidsbruk
- Antall deaths
- Dato (hvis tilgjengelig)

### Hvordan installere og kjøre programmet

1. **Installer World of Warcraft Classic Era**  
   Du må ha World of Warcraft Classic Era installert via Battle.net-launcheren til Blizzard.

2. **Legg inn addonen i AddOns-mappen**  
   Last ned/zip prosjektet, og pakk det ut slik at mappen `SmartDungeonAssistant` ligger i:

   `/Applications/World of Warcraft/_classic_era_/Interface/AddOns`

   (På Windows vil tilsvarende sti ligge under `World of Warcraft\_classic_era_\Interface\AddOns`.)

3. **Start spillet på nytt eller reload UI**  
   - Lukk spillet og start det på nytt, **eller**
   - Skriv `/reload` eller `/rl` i chat for å laste inn nye filer.

4. **Aktiver addonen i karaktervalget**  
   På addons-menyen i karaktervelgeren, sjekk at `SmartDungeonAssistant` er huket av.

Når alt er korrekt installert og lastet, vil du se meldingen `SmartDungeonAssistant has loaded!` i chat når UI-et starter.

### Videre planer (fra TODO-listen)

Prosjektet har en tydelig roadmap delt inn i faser (se `docs/TODO.md`):

- **Phase 1 – Core Dungeon Detection**  
  Grunnsystemet for å oppdage dungeon-inn/ut og tidtaking er ferdig.

- **Phase 2 – Run Tracking System**  
  Utvidet døds-tracking (gruppe, wipes) og XP-beregning per run er planlagt.

- **Phase 3 – Quest Tracking**  
  Det er planlagt å skanne aktive quests for deg og gruppen, finne dungeon-relaterte quests, og skrive i chat hvem som mangler hva.

- **Phase 4 – Saved Variables**  
  Grunnleggende lagring av runs er implementert, men flere felter (som XP, wipes, gull osv.) vil bli lagt til etter hvert.

- **Phase 5 – UI System**  
  Resultatvinduet eksisterer allerede, men vil utvides med tittel, mer statistikk, historikkliste, sletting av data og mulighet til å dra vinduet.

- **Phase 6 – Advanced Polish**  
  Kosmetiske forbedringer og mer avansert statistikk, f.eks. gjennomsnittstid, raskeste run, fargekoding og en egen minimap-knapp for lett tilgang.

Mye av kjernelogikken er altså allerede på plass, og resten bygges gradvis ut basert på denne TODO-listen.

### Teknologi

- **Språk**: Lua  
- **Målplattform**: World of Warcraft Classic Era (UI/AddOn-systemet)  
- **Lagring**: SavedVariables-tabell (`SmartDungeonAssistantDB`) som lagrer hver dungeon-run lokalt for kontoen/figuren.

### Kildeliste

- **World of Warcraft API-dokumentasjon** for informasjon om events som `PLAYER_ENTERING_WORLD`, `COMBAT_LOG_EVENT_UNFILTERED`, `PLAYER_DEAD`, samt funksjoner som `GetInstanceInfo()`, `CombatLogGetCurrentEventInfo()` og `IsInInstance()`.  
- **Egen utforsking og testing in-game** for å finne riktig flyt for når runs skal starte og stoppe, og hvordan resultatvinduet bør oppføre seg.  
- **ChatGPT (OpenAI)** er brukt som veileder for å lære Lua og WoW-addon-API, men selve strukturen og funksjonaliteten er bygget for å forstå og kontrollere koden selv, ikke for å autogenerere hele addonen.

# SmartDungeonAssistant - Addon for WoW Classic Era

Spillversjon - 1.15.8