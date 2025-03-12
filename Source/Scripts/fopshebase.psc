Scriptname fopshebase extends activemagiceffect  

Spell Property reward auto

;import PO3_SKSEFunctions
import PO3_Events_AME
Actor Property PlayerRef Auto
import MCM


Function updateReward(float fav)
		PlayerRef.RemoveSpell(reward)
		int i = 7
		while i >= 0
				reward.SetNthEffectMagnitude(i, fav)
				i-=1
		endwhile
		PlayerRef.AddSpell(reward, false)
		
EndFunction


Event OnEffectStart(Actor TargetRef, Actor CasterRef)
 		RegisterForSkillIncrease(self)
		float favour = CustomSkills.GetSkillLevel("Sheogorath")
		CustomSkills_ActiveMagicEffectExt.RegisterForCustomSkillIncrease(self)
		updateReward(favour)
EndEvent

Event OnSkillIncrease(Int aiSkill)
		CustomSkills.AdvanceSkill("Sheogorath", 1000 * GetModSettingFloat("FavourOfPrinces","fskillratio:SHE"))
EndEvent


Event OnCustomSkillIncrease(string asSkillId)
		float favour = CustomSkills.GetSkillLevel("Sheogorath")
		updateReward(favour)
EndEvent