Scriptname fophircinebase extends activemagiceffect  

Spell Property reward auto
Perk Property capstone auto
;import PO3_SKSEFunctions
import PO3_Events_AME
Actor Property PlayerRef Auto
KeyWord Property animal Auto
import MCM


Function updateReward()
		float fav = CustomSkills.GetSkillLevel("Hircine")
		if PlayerRef.HasPerk(capstone)
				fav = fav*2
		endif
		PlayerRef.RemoveSpell(reward)
		reward.SetNthEffectMagnitude(0, fav)
		reward.SetNthEffectMagnitude(1, fav/10)
		int quer = Game.QueryStat("Animals Killed")
		float newval = Math.Floor( quer /10)
		if newval > fav
				newval = fav
		endif		
		reward.SetNthEffectMagnitude(2, newval)
		PlayerRef.AddSpell(reward, false)
		
EndFunction

Event OnWeaponHit(ObjectReference akTarget, Form akSource, Projectile akProjectile, Int aiHitFlagMask)
Weapon w = akSource as Weapon
Actor targ = akTarget as Actor
float bdmg = w.GetBaseDamage() 
if w.GetWeaponType() == 0
bdmg = 20
endif
if w.GetWeaponType() == 0 || akProjectile || targ.HasKeyword(animal)
incrSkill(targ.GetLevel() * bdmg * 2 )
endif
EndEvent

Function incrSkill(float amount)
		CustomSkills.AdvanceSkill("Hircine", amount * GetModSettingFloat("FavourOfPrinces","fskillratio:HIR"))
		updateReward()
EndFunction

Event OnEffectStart(Actor TargetRef, Actor CasterRef)
		updateReward()
		RegisterForWeaponHit(self)
EndEvent

