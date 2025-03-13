Scriptname fop_baseperkscriptref   extends ReferenceAlias

Quest Property DA01 auto

GlobalVariable Property foproleplayoptions auto
GlobalVariable Property SkillAzuraLevel auto

bool gained = false
bool forbidden = false

Actor Property PlayerRef Auto

Keyword Property MagicAlchHarmful Auto
Keyword Property ActorTypeUndead auto
KeyWord Property ActorTypeAnimal Auto


Perk Property CNS_AZR_Mastery1 Auto
Perk Property CNS_MPH_Mastery1 Auto
Perk Property FOP_HIR_Base Auto
Perk Property CNS_MRD_Mastery2 Auto
Perk Property CNS_MRD_ShiningBitch2 Auto
Perk Property FOP_HIR_Cap Auto

Spell Property CNS_AZR_BaseEffect_Spell auto
Spell Property CNS_MRD_BaseEffect_Spell auto
Spell Property FOP_SHE_Reward auto
Spell Property FOP_HIR_Reward auto

Idle Property pa_HugA Auto

;import PO3_SKSEFunctions
import PO3_SKSEFunctions
import MCM

Event OnInit()
    ; RegisterForSleep() TODO VAERMINA BASE QUEST
EndEvent

Event OnSpellCast(Form akSpell)
    if PlayerRef.HasPerk(CNS_AZR_Mastery1)
        Int FirstEffectCastType = (akSpell as Spell).GetNthEffectMagicEffect(0).GetCastingType()
        Spell spellCast = akSpell as Spell

        float mult = GetModSettingFloat("FavourOfPrinces","fskillratio:AZR")
        if foproleplayoptions.GetValue() == 1

                if !gained && DA01.IsStageDone(100)
                    incrSkill(1,  20000  )
                    gained=true
        
                endif
                if !gained && DA01.IsStageDone(110)
                        SkillAzuraLevel.setvalue( -0.9)
                        gained = true
                        forbidden = true
                endif
        endif

        float Time = Utility.GetCurrentGameTime()
        Time -= Math.Floor(Time)
        Time *= 24
        if Time>3 && Time<8 || Time>18 && Time<23
                mult *= 2
        endif
        if spellCast && FirstEffectCastType == 1 && !forbidden
            incrSkill(0, 4 * mult * spellCast.GetEffectiveMagickaCost(PlayerRef))
        endif
    endif
endevent


Event OnWeaponHit(ObjectReference akTarget, Form akSource, Projectile akProjectile, Int aiHitFlagMask)
    if PlayerRef.HasPerk(CNS_MPH_Mastery1)
        int is_poison_d = 0
        Weapon w = akSource as Weapon
        Actor targ = akTarget as Actor
        if Math.LogicalAnd(aiHitFlagMask, 2048)
            is_poison_d += 2
        endif
        int valof =  is_poison_d
    endif
    if PlayerRef.HasPerk(FOP_HIR_Base)
        Weapon w = akSource as Weapon
        Actor targ = akTarget as Actor
        float bdmg = w.GetBaseDamage() 
        if w.GetWeaponType() == 0
            bdmg = 20
        endif
        if w.GetWeaponType() == 0 || akProjectile || targ.HasKeyword(ActorTypeAnimal)
            incrSkill(1,targ.GetLevel() * bdmg * 2 )
        endif
    endif
    if PlayerRef.HasPerk(CNS_MPH_Mastery1)
        float is_poison_d = 0.0
        Weapon w = akSource as Weapon
        Actor targ = akTarget as Actor
        if  targ.HasMagicEffectWithKeyword(MagicAlchHarmful)
            is_poison_d += 1.0
        endif
        if Math.LogicalAnd(aiHitFlagMask, 2048)
            is_poison_d += 24
        endif
        incrSkill(2, 0.2 * targ.GetLevel() * is_poison_d * GetModSettingFloat("FavourOfPrinces","fskillratio:MPH"))
    endif
EndEvent

Function incrSkill(int index, float val)
    fop_deityarrs arrs = (GetOwningQuest() as fop_deityarrs)
    Debug.Trace(index)
    int oldLevel =  arrs.deityLevel[index].GetValue() as int
    float newVal = arrs.deityRatios[index].Mod(val / (oldLevel * 2) / 100)
    if newVal >= 1
        int newLevel =  arrs.deityLevel[index].Mod(1) as int
        updateReward(index, newLevel)
        CustomSkills.ShowSkillIncreaseMessage(arrs.deityNames[index], newLevel)
        arrs.deityRatios[index].Mod(-1)
        incrSkill(index, 0)
    endif
EndFunction


Function updateReward(int index, int val)
    fop_deityarrs arrs = (GetOwningQuest() as fop_deityarrs)
    if index == 2 && PlayerRef.HasPerk(FOP_HIR_Cap)
        val += 2
    endif
    if arrs.DeityReward[index]
        Spell rewardSpell = arrs.DeityReward[index]
        PlayerRef.RemoveSpell(rewardSpell)
        int innerIndex = 0
        while innerIndex < rewardSpell.GetNumEffects()
                
            rewardSpell.SetNthEffectMagnitude(innerIndex, val)
            innerIndex += 1
        endwhile
    endif
EndFunction
;     if PlayerRef.HasPerk(capstone)
;             fav = fav*2
;     endif
;     PlayerRef.RemoveSpell(reward)
;     reward.SetNthEffectMagnitude(0, fav)
;     reward.SetNthEffectMagnitude(1, fav/10)
;     int quer = Game.QueryStat("Animals Killed")
;     float newval = Math.Floor( quer /10)
;     if newval > fav
;             newval = fav
;     endif		
;     reward.SetNthEffectMagnitude(2, newval)
;     PlayerRef.AddSpell(reward, false)



Event OnSkillIncrease(Int aiSkill)
    incrSkill(4, 1000 * GetModSettingFloat("FavourOfPrinces","fskillratio:SHE"))
EndEvent

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, \
    bool abBashAttack, bool abHitBlocked)
    Actor attacker = akAggressor as Actor
    float damage = 0
    if (akSource as Weapon)
    Weapon c_source = akSource as Weapon
    
    damage = c_source.GetBaseDamage() +  c_source.GetBaseDamage() * (abPowerAttack as Int) 
    endif
    int targ_unde = attacker.HasKeyWord(ActorTypeUndead ) as int
    incrSkill(3, (1 + (PlayerRef.GetLightLevel()- 50) /100 ) * 20 * damage  * (1 +  targ_unde ) * GetModSettingFloat("FavourOfPrinces","fskillratio:MRD"))
  
  
  endevent