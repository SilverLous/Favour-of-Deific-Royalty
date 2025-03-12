Scriptname mrdcombatonhit extends activemagiceffect

Actor Property PlayerRef Auto
Perk Property Level2 Auto
Spell Property RallySpell Auto

Actor Property target auto
Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, \
  bool abBashAttack, bool abHitBlocked)
Actor aggr = akAggressor as Actor
if aggr == PlayerRef
aggr=target
endif
	aggr.SetPlayerTeammate(false, false)
	target.SetPlayerTeammate(false, false)
		if PlayerRef.hasPerk(Level2)
				RallySpell.Cast(PlayerRef, target)
		endif

EndEvent

Event OnEffectStart(Actor TargetRef, Actor CasterRef)
target = TargetRef
EndEvent