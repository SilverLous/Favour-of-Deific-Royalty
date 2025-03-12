Scriptname mephalasleepingacross extends activemagiceffect  

Actor Property PlayerRef Auto
Spell Property MPRested Auto
Keyword Property LocTypeInn Auto

Event OnEffectStart(Actor a, Actor b)
RegisterForSleep()
EndEvent

Event OnSleepStop(bool abInterrupted)
		If Game.GetPlayer().GetCurrentLocation().HasKeyword(LocTypeInn) == True
			MPRested.Cast(PlayerRef, PlayerRef)

	EndIf
	
EndEvent


Message Property MarriageRestedMessage  Auto  

