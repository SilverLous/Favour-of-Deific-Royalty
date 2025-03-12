Scriptname fopmcmc extends MCM_ConfigBase

Actor Property PlayerRef Auto
Spell Property openMenu Auto
 int Property debugPerkAmount Auto
GlobalVariable Property foproleplayoptions auto

Bool Function SafeProcess()
If (!Utility.IsInMenuMode()) \
&& (!UI.IsMenuOpen("Dialogue Menu")) \
&& (!UI.IsMenuOpen("Console")) \
&& (!UI.IsMenuOpen("Crafting Menu")) \
&& (!UI.IsMenuOpen("MessageBoxMenu")) \
&& (!UI.IsMenuOpen("ContainerMenu")) \
&& (!UI.IsMenuOpen("InventoryMenu")) \
&& (!UI.IsMenuOpen("BarterMenu")) \
&& (!UI.IsTextInputEnabled())
;IsInMenuMode to block when game is paused with menus open
;Dialogue Menu check to block when dialog is open
;Console check to block when console is open - console does not trigger IsInMenuMode and thus needs its own check
;Crafting Menu check to block when crafting menus are open - game is not paused so IsInMenuMode does not work
;MessageBoxMenu check to block when message boxes are open - while they pause the game, they do not trigger IsInMenuMode
;ContainerMenu check to block when containers are accessed - while they pause the game, they do not trigger IsInMenuMode
;InventoryMenu check to block when inventory is open - when used with Skyrim Souls
;BarterMenu check to block when buy items in shop - when used with Skyrim Souls
;IsTextInputEnabled check to block when editable text fields are open
Return True
Else
Return False
EndIf
EndFunction

Event OnConfigInit()
ToggleSpell(GetModSettingBool("baddspell:Main"))
toggleGlobal(GetModSettingBool("brpstuff:Main"))
int addp = GetModSettingInt("iaddperk:Main")
if addp>0
Game.AddPerkPoints(addp)
endif
EndEvent

Function openM()
if SafeProcess()
CustomSkills.OpenCustomSkillMenu("Azura")
endif
EndFunction

Function ToggleSpell(bool is_toggled_on)
if is_toggled_on 
PlayerRef.addspell(openMenu)
else
PlayerRef.removeSpell(openMenu)
endif

EndFunction

Function toggleGlobal(bool on)
		foproleplayoptions.SetValue(on as int)
EndFunction