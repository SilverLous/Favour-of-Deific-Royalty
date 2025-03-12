Scriptname fonpazrbaseeffect extends activemagiceffect  

Actor Property PlayerRef Auto


Event OnSpellCast(Form akSpell)
		Int FirstEffectCastType = (akSpell as Spell).GetNthEffectMagicEffect(0).GetCastingType()
  		Spell spellCast = akSpell as Spell


	float Time = Utility.GetCurrentGameTime()
	Time -= Math.Floor(Time) ; Remove "previous in-game days passed" bit
	Time *= 24 ; Convert from fraction of a day to number of hours
	float mult = 1
		if Time>3 && Time<8 || Time>18 && Time<23
				mult = 2
		endif
	int valof = Math.Floor(0.06 * mult * spellCast.GetEffectiveMagickaCost(PlayerRef) )
endevent