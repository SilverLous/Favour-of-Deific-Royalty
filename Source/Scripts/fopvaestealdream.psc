Scriptname fopvaestealdream extends activemagiceffect  

Spell Property para auto

Actor tar
import MCM

Event OnEffectStart(Actor a, Actor b)
		int i = 6
		Actorvalueinfo highest_skill_name
		int highest_del = 0
		tar = a
		string out = ""
		while i <24
				Actorvalueinfo varname =  ActorValueInfo.GetActorValueInfobyID(i)
				int temp_num = varname.GetCurrentValue(a) as int
				int p_temp_num = varname.GetCurrentValue(b) as int
				int delt = temp_num - p_temp_num 
				out += varname.GetName()+ temp_num + "\n"
				if highest_del < delt
						highest_del = delt
						highest_skill_name = varname
				endif
				i += 1
		endwhile
		if highest_del > 0
				float multi = highest_skill_name.GetSkillUseMult()
				float adv = highest_del / multi * 100 -  highest_skill_name.GetSkillOffsetMult()
				highest_skill_name.AddSkillExperience(adv)
				Debug.Notification(highest_skill_name.GetName() + " was stolen")
				CustomSkills.AdvanceSkill("Vaermina", highest_del * 10 * GetModSettingFloat("FavourOfPrinces","fskillratio:VAE")  )
				para.Cast(b,a)
		endif
				
EndEvent

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
		tar.DispelSpell(para)
EndEvent