Scriptname azrtwilightcheck extends activemagiceffect  

Actor Property PlayerRef Auto
Spell Property TwilightSpellEffect Auto

Event OnEffectStart(Actor TargetRef, Actor CasterRef)
   RegisterForUpdateGameTime(1.0)
endEvent

Event OnUpdateGameTime()

	float Time = Utility.GetCurrentGameTime()
	Time -= Math.Floor(Time) 
	Time *= 24
       Time = Math.Abs(Time - 12.0)
       if (Time >=4 && Time<=9)
       		PlayerRef.addSpell(TwilightSpellEffect )
		endIf
endEvent