;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 7
Scriptname QF_FOP_BasePerkQuest_03000094 Extends Quest Hidden

;BEGIN ALIAS PROPERTY PlayerRefLel
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PlayerRefLel Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN AUTOCAST TYPE fop_deityarrs
Quest __temp = self as Quest
fop_deityarrs kmyQuest = __temp as fop_deityarrs
;END AUTOCAST
;BEGIN CODE
RegisterForWeaponHit(Alias_PlayerRefLel)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
RegisterForHitEventEx(Alias_PlayerRefLel)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
PlayerRef.Addspell(FOP_VAE_BasePower)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
RegisterForSkillIncrease(Alias_PlayerRefLel)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
; float favourAzura = CustomSkills.GetSkillLevel("Azura")
; CNS_AZR_BaseEffect_Spell.SetNthEffectMagnitude(0, favourAzura)
; CNS_AZR_BaseEffect_Spell.SetNthEffectMagnitude(1, favourAzura*2)
; PlayerRef.AddSpell(CNS_AZR_BaseEffect_Spell, false)

Spell Property FOP_VAE_BasePower auto
Spell Property CNS_AZR_BaseEffect_Spell auto
Quest Property DA01 auto
GlobalVariable Property foproleplayoptions auto
GlobalVariable Property SkillAzuraLevel auto
bool gained = false
bool forbidden = false
Actor Property PlayerRef Auto
import PO3_SKSEFunctions
import MCM
import PO3_Events_Alias
