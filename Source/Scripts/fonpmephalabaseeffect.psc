Scriptname fonpmephalabaseeffect extends activemagiceffect  
import PO3_SKSEFunctions
import PO3_Events_AME

Actor Property PlayerREF Auto

Event OnEffectStart(Actor a, Actor b)
    RegisterForWeaponHit(self)
EndEvent

Event OnWeaponHit(ObjectReference akTarget, Form akSource, Projectile akProjectile, Int aiHitFlagMask)
    int is_poison_d = 0
    Weapon w = akSource as Weapon
    Actor targ = akTarget as Actor
    if Math.LogicalAnd(aiHitFlagMask, 2048)
        is_poison_d += 2
    endif
    int valof =  is_poison_d
EndEvent