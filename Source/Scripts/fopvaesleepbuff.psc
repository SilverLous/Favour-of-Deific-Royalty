Scriptname fopvaesleepbuff extends activemagiceffect  

Spell Property SleepReward Auto
Actor Property PlayerRef Auto


Event OnSleepStop(bool abInterrupted)

SleepReward.cast(PlayerRef)

EndEvent