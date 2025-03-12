Scriptname fopvaebasescript extends activemagiceffect  

Actor Property PlayerRef auto
Spell Property stealdreams auto
Spell Property magickafort auto
Perk Property sleepperk auto

Event OnEffectStart(Actor a, Actor b)
		PlayerRef.Addspell(stealdreams)
		RegisterForSleep()
EndEvent

Event OnSleepStop(bool abInterrupted)
if PlayerRef.hasperk(sleepperk)
		magickafort.Cast(PlayerRef, PlayerRef)
endif
EndEvent

