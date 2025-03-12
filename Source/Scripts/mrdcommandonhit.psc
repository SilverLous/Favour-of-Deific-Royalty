Scriptname mrdcommandonhit extends activemagiceffect  

Actor Property PlayerRef Auto
Spell Property ObeyPerk Auto
Faction Property CharmFaction Auto
bool Property bMakePlayerTeammate = false Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
float randomizzedint = PlayerRef.GetAV("Health") - akTarget.GetAV("Health") - Utility.RandomInt()
if randomizzedint>0
	akTarget.AddToFaction(CharmFaction)
	PlayerRef.StopCombat()
	akTarget.StopCombat()
	akTarget.SetPlayerTeammate(true, false)	
	akTarget.AddSpell(ObeyPerk)	
endif
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	akTarget.RemoveFromFaction(CharmFaction)
	if bMakePlayerTeammate
		akTarget.SetPlayerTeammate(false, false)
	endif
EndEvent