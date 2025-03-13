Scriptname meridiabaseeffectnew extends activemagiceffect  

Actor Property PlayerRef Auto
Perk Property Mastery2 Auto
Perk Property ShiningB Auto
Spell Property magickaregenspell auto
Keyword Property is_undead auto
import MCM

Event OnEffectStart(Actor a, Actor b)
		CustomSkills_ActiveMagicEffectExt.RegisterForCustomSkillIncrease(self)
		float favourAzura = CustomSkills.GetSkillLevel("Meridia")
		magickaregenspell.SetNthEffectMagnitude(0, favourAzura)
		magickaregenspell.SetNthEffectMagnitude(1, favourAzura)
		PlayerRef.AddSpell(magickaregenspell, false)
EndEvent

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, \
  bool abBashAttack, bool abHitBlocked)

  Actor attacker = akAggressor as Actor
float damage = 0
if (akSource as Weapon)
Weapon c_source = akSource as Weapon

damage = c_source.GetBaseDamage() +  c_source.GetBaseDamage() * (abPowerAttack as Int) 
endif
int targ_unde = attacker.HasKeyWord(is_undead ) as int
CustomSkills.AdvanceSkill("Meridia", (1 + (PlayerRef.GetLightLevel()- 50) /100 ) * 20 * damage  * (1 +  targ_unde ) * GetModSettingFloat("FavourOfPrinces","fskillratio:MRD"))


endevent


Event OnCustomSkillIncrease(string asSkillId)
float favourAzura = CustomSkills.GetSkillLevel("Meridia")
		PlayerRef.RemoveSpell(magickaregenspell)
		magickaregenspell.SetNthEffectMagnitude(0, favourAzura)
		magickaregenspell.SetNthEffectMagnitude(1, favourAzura)
		PlayerRef.AddSpell(magickaregenspell, false)

EndEvent

