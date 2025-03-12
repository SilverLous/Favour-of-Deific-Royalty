Scriptname fopsheocheese extends activemagiceffect  

import PO3_SKSEFunctions

import PO3_Events_AME
Keyword Property LocTypeInn Auto
Spell Property CheeseEaten Auto

Actor Property PlayerRef Auto

Event oneffectstart(Actor a, Actor b)
;RegisterOnMagicEffectApply()
EndEvent

Event OnSpellCast(Form akSpell)
Debug.Messagebox(PlayerRef.GetCurrentLocation().HasKeyword(LocTypeInn) +" "+ StringUtil.Find(akSpell.GetName(), "heese" ) )
if PlayerRef.GetCurrentLocation().HasKeyword(LocTypeInn) == True && StringUtil.Find(akSpell.GetName(), "heese" )>-1
CheeseEaten.Cast(PlayerRef, PlayerRef)
endif
EndEvent