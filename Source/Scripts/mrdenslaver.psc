Scriptname mrdenslaver extends activemagiceffect  

Actor Property PlayerRef Auto
Actor Property EnslavedOne Auto
int Property key_down Auto


Event OnEffectStart(Actor a, Actor b)
		RegisterForKey(key_down)
endEvent


Event OnKeyDown(Int KeyCode)

		Actor hugee = Game.GetCurrentCrosshairRef() as Actor
		if hugee && !hugee.IsPlayerTeammate()
				if EnslavedOne
						EnslavedOne.SetPlayerTeammate(false,false)
				endif
				EnslavedOne = hugee
				hugee.stopcombat()
				hugee.setPlayerTeammate(true,true)

		endif

EndEvent
