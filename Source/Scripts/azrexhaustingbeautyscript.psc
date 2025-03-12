Scriptname azrexhaustingbeautyscript extends activemagiceffect  

Actor Property PlayerRef Auto
Perk Property Level2 Auto

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, \
bool abBashAttack, bool abHitBlocked)
if (!(abBashAttack && akProjectile && abSneakAttack && abHitBlocked))
  Actor attacker = akAggressor as Actor
float damage = 0
if (akSource as Weapon)
Weapon c_source = akSource as Weapon

damage = c_source.GetBaseDamage() +  c_source.GetBaseDamage() * (abPowerAttack as Int) 
endif
damage *= (PlayerRef.GetAV("Magicka") * (1.1 - attacker.GetActorValuePercentage("Stamina")))
attacker.DamageAV("Stamina", damage)
attacker.DamageAV("Magicka", damage)
if PlayerRef.hasPerk(Level2)
attacker.DamageAV("Health", damage)
endif
Else
Endif
EndEvent