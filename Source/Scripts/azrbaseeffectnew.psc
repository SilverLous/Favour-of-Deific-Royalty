Scriptname azrbaseeffectnew extends activemagiceffect  

Spell Property magickaregenspell auto
Quest Property AzuraQuest auto
GlobalVariable Property RP auto
GlobalVariable Property skill auto
bool gained = false
bool forbidden = false
Actor Property PlayerRef Auto
import PO3_SKSEFunctions
import MCM

Event OnEffectStart(Actor TargetRef, Actor CasterRef)
		float favourAzura = CustomSkills.GetSkillLevel("Azura")
		CustomSkills_ActiveMagicEffectExt.RegisterForCustomSkillIncrease(self)
		magickaregenspell.SetNthEffectMagnitude(0, favourAzura)
		magickaregenspell.SetNthEffectMagnitude(1, favourAzura*2)
		PlayerRef.AddSpell(magickaregenspell, false)
EndEvent


Event OnSpellCast(Form akSpell)
		Int FirstEffectCastType = (akSpell as Spell).GetNthEffectMagicEffect(0).GetCastingType()
  		Spell spellCast = akSpell as Spell

		float mult = GetModSettingFloat("FavourOfPrinces","fskillratio:AZR")
		if RP.GetValue() == 1

				if !gained && AzuraQuest.IsStageDone(100)
						CustomSkills.AdvanceSkill("Azura",  20000  )
						gained=true
		
				endif
				if !gained && AzuraQuest.IsStageDone(110)
						skill.setvalue( -0.9)
						gained = true
						forbidden = true
				endif
		endif

	float Time = Utility.GetCurrentGameTime()
	Time -= Math.Floor(Time) ; Remove "previous in-game days passed" bit
	Time *= 24 ; Convert from fraction of a day to number of hours
		if Time>3 && Time<8 || Time>18 && Time<23
				mult *= 2
		endif
  		if spellCast && FirstEffectCastType == 1 && !forbidden
				CustomSkills.AdvanceSkill("Azura", 4 * mult * spellCast.GetEffectiveMagickaCost(PlayerRef))
		endif
endevent

Event OnCustomSkillIncrease(string asSkillId)
float favourAzura = CustomSkills.GetSkillLevel("Azura")
		PlayerRef.RemoveSpell(magickaregenspell)
		magickaregenspell.SetNthEffectMagnitude(0, favourAzura)
		magickaregenspell.SetNthEffectMagnitude(1, favourAzura*2)
		PlayerRef.AddSpell(magickaregenspell, false)

EndEvent