Scriptname mephalabasescript extends activemagiceffect  
import PO3_SKSEFunctions
import PO3_Events_AME
Idle Property pa_HugA Auto
Actor Property PlayerREF Auto
Spell Property magickaregenspell auto
Keyword Property al_key Auto
Perk Property basePerk Auto
import MCM

Event OnEffectStart(Actor a, Actor b)
RegisterForWeaponHit(self)
float favourAzura = CustomSkills.GetSkillLevel("Mephala")
		CustomSkills_ActiveMagicEffectExt.RegisterForCustomSkillIncrease(self)
		magickaregenspell.SetNthEffectMagnitude(0, Math.Floor(favourAzura / 10 * 3 ) )
		magickaregenspell.SetNthEffectMagnitude(1, favourAzura*2)
		PlayerRef.AddSpell(magickaregenspell, false)
EndEvent


Event OnWeaponHit(ObjectReference akTarget, Form akSource, Projectile akProjectile, Int aiHitFlagMask)
float is_poison_d = 0.0
Weapon w = akSource as Weapon
Actor targ = akTarget as Actor
if  targ.HasMagicEffectWithKeyword(al_key)
is_poison_d += 1.0
endif
if Math.LogicalAnd(aiHitFlagMask, 2048)
is_poison_d += 24
endif
CustomSkills.AdvanceSkill("Mephala", 0.2 * targ.GetLevel() * is_poison_d * GetModSettingFloat("FavourOfPrinces","fskillratio:MPH"))
EndEvent

Event OnCustomSkillIncrease(string asSkillId)
float favourAzura = CustomSkills.GetSkillLevel("Mephala")
		PlayerRef.RemoveSpell(magickaregenspell)
		magickaregenspell.SetNthEffectMagnitude(0, Math.Floor(favourAzura/10 * 3))
		magickaregenspell.SetNthEffectMagnitude(1, favourAzura * 2)
		PlayerRef.AddSpell(magickaregenspell, false)

EndEvent