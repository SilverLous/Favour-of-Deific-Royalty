Scriptname fopactions extends Quest

import PO3_SKSEFunctions
import PO3_Events_AME
Idle Property pa_HugA Auto
Actor Property PlayerREF Auto
Spell Property magickaregenspell auto
Perk Property basePerk Auto
Perk Property MeridiaCap Auto
Quest Property FOP_BasePerkQuest Auto
fop_baseperkscriptref Property baseP Auto

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


Event OnInit()
	Debug.MessageBox((FOP_BasePerkQuest as fop_baseperkscriptref))
endevent


Actor EnslavedOne

Function StartEnslaving()
		Actor hugee = Game.GetCurrentCrosshairRef() as Actor
		if hugee && !hugee.IsPlayerTeammate() && SafeProcess() && PlayerRef.hasperk(MeridiaCap)
			if EnslavedOne
				EnslavedOne.SetPlayerTeammate(false,false)
			endif
			EnslavedOne = hugee
			hugee.stopcombat()
			hugee.setPlayerTeammate(true,true)
		endif
EndFunction



Function StartSnakeBiting()
	baseP.incrSkill(2,  100)
	if PlayerRef.hasPerk(basePerk) && SafeProcess()
		Actor hugee = Game.GetCurrentCrosshairRef() as Actor
		bool is_playing = false
		hugee.EnableAI(false)
		hugee.EnableAI()			
		int hand = 1
		while hand > -1
			Potion left_p = WornObject.GetPoison(PlayerRef, hand, 0)
			MagicEffect[] marr = left_p.GetMagicEffects()
			Int[] dur = left_p.GetEffectDurations()
			float[] mag = left_p.GetEffectMagnitudes()
			Int iElement = marr.length
			While iElement
				iElement -= 1
				String arche = GetEffectArchetypeAsString(marr[iElement])
				if arche == "DualValueMod" || arche == "PeakValueMod" || arche == "ValueMod"
					string primary = GetPrimaryActorValue(marr[iElement]) 
					if primary  == "Health" || primary == "Stamina"
						int duration = dur[iElement]
						if duration == 0
							duration = 1
						endif
						int doses = (GetEquippedWeaponPoisonCount(PlayerRef, 1 - hand))
						if hugee
							if !is_playing
								is_playing = true
								PlayerREF.playidlewithtarget(pa_HugA, hugee)
								Hugee.SendAssaultAlarm()
								Utility.Wait(1.7)		
							endif
							hugee.damageav(primary, mag[iElement] * duration * doses)
							baseP.incrSkill(2,  hugee.GetLevel() * mag[iElement] * duration * doses / 10)
						endif
					endif
				endif
			endwhile
			SetEquippedWeaponPoison (PlayerRef, none, 1 - hand)
			hand -= 1
		endwhile
	endif
EndFunction
