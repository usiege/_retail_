﻿---------------------------------------------------------------------------
--[[                       图标更新循环                                  ]]--
---------------------------------------------------------------------------
local addon, ns = ...

local Aura_time = ns.Aura_time 
local Aura_count = ns.Aura_count 
local Aura_Stack = ns.Aura_Stack 
local IsBloodlust = ns.IsBloodlust 

local Combat = ns.Combat
local time_x = ns.time_x
local time_d = ns.time_d

local Group = ns.Group
local GroupNeedHealth = ns.GroupNeedHealth

local IsEquipped = ns.IsEquipped 
local ItemCooldown = ns.ItemCooldown 
local Itemuseable = ns.Itemuseable  
local AzltE = ns.AzltE  
local Tier = ns.Tier  

local Summon_Pet = ns.Summon_Pet  

local PlayerClass = ns.PlayerClass 
local Specialization = ns.Specialization 
local IsTalent = ns.IsTalent 

local Power = ns.Power 
local PowerMax = ns.PowerMax 
local PowerDft = ns.PowerDft 

local Rang_enemies_Aura = ns.Rang_enemies_Aura 
local InCombat_enemies = ns.InCombat_enemies 
local active_enemies = ns.active_enemies 
local TTD = ns.TTD 
local Teshuchuli = ns.Teshuchuli

local Time_fmod = ns.Time_fmod 
--local Authorization = ns.Authorization 

local HealthCurrent = ns.HealthCurrent 
local HealthMax = ns.HealthMax 
local HealthPercent = ns.HealthPercent 
local UnitSpeed = ns.UnitSpeed 
local UnitRange = ns.UnitRange 
local IsBoss = ns.IsBoss 
local HaveUnit = ns.HaveUnit
local IsEnemy = ns.IsEnemy

local GetSpellID = ns.GetSpellID
local useable = ns.useable 
local Isuseable = ns.Isuseable 
local GCD_MAX = ns.GCD_MAX 
local GCD_REMAINS = ns.GCD_REMAINS 
local SpellCooldown = ns.SpellCooldown 
local SpellCharges = ns.SpellCharges 
local SpellallCharges = ns.SpellallCharges
local SpellFullCharges = ns.SpellFullCharges 
local SpellConut = ns.SpellConut 
local cast_time = ns.cast_time 
local casting_time = ns.casting_time 
local channel_time = ns.channel_time
local Useing_spell = ns.Useing_spell
local Useingtime = ns.Useingtime
local Last_Spell = ns.Last_Spell 
local cast_In = ns.cast_In 
local cast_later = ns.cast_later 
local Prev_Spell = ns.Prev_Spell 
local Spell_Later = ns.Spell_Later 


local ShowColor = ns.ShowColor 
local ShowSpell = ns.ShowSpell 

---------------------------------------------------------------------------
--[[                   变量                          ]]--
---------------------------------------------------------------------------  
--兽王集中值恢复速度
local function Hunter_focus_regen()
    
    local R=GetPowerRegen()
    local C1=Aura_count("player","倒刺射击")
    local C2=Aura_count("player","野性守护")
    local C3=Aura_count("player","喷毒眼镜蛇")
    
    if IsTalent("血之气息") then 
        a=8  
    else a=0 
    end
    
    if C1>0 then 
        d=((28+a)/8)*C1
    else d=0
    end
    
    if C2>0 then  b=5  else b=0 end
    if C3>0 then  c=2  else c=0 end
    
    return R+b+c+d
    
end
--射击多重射击
local function DCSJ()
local A = Aura_time("PLAYER","技巧射击") 
local B = Useing_spell("PLAYER")
if A == 0 or  B == 19434 or B == 257044 then return true else return false end
end


local function Hunter_Marksmanship()  --更新主图标及技能提示图标

local mainbutton = PDUI.mainbutton
local debutton = PDUI.debutton

if PlayerClass()=="HUNTER" and Specialization()=="射击"  then
--if Authorization() then

--开始循环
--自动拾取器


---------------------------------------------------------------------------
--[[                       编辑区                       ]]--
---------------------------------------------------------------------------


--打球/图腾
if Teshuchuli() then
if PandaDB.SJ_C1 ~= false  and Isuseable("奥术射击",185358) then ShowColor(mainbutton.icon, 6603,C_1);ShowSpell(debutton.icon, 185358) return end
end

--战斗前
if not InCombatLockdown() then

if PandaDB.SJ_A3 ~= false  and Isuseable("猎人印记",257284)  then
if Aura_time("target","猎人印记","PLAYER|HARMFUL") == 0  then  ShowColor(mainbutton.icon, 6603,A_3);ShowSpell(debutton.icon, 257284) return end
end

if PandaDB.SJ_A5 ~= false  and Isuseable("二连发",260402)  then  ShowColor(mainbutton.icon, 6603,A_5);ShowSpell(debutton.icon, 260402) return end

if PandaDB.CcdSwitch ~= false  then
if PandaDB.SJ_A1 ~= false  and Isuseable("百发百中",288613) then
if active_enemies()>=3 then  ShowColor(mainbutton.icon, 6603,A_1);ShowSpell(debutton.icon, 288613) return end
end
end

if UnitSpeed("PLAYER")<=1 then
if PandaDB.SJ_A2 ~= false  and Isuseable("瞄准射击",19434) then
if active_enemies()<3 then  ShowColor(mainbutton.icon, 6603,A_2);ShowSpell(debutton.icon, 19434) return end
end
end

end

--cds
if PandaDB.SJ_A3 ~= false  and Isuseable("猎人印记",257284) then
if ( Aura_time("target","猎人印记","PLAYER|HARMFUL") == 0 and Aura_time("PLAYER","百发百中") == 0) then  ShowColor(mainbutton.icon, 6603,A_3);ShowSpell(debutton.icon, 257284) return end
end

if PandaDB.SJ_A5 ~= false  and Isuseable("二连发",260402)  then
if (SpellCooldown(257044)<GCD_MAX() or SpellCooldown(257044)<SpellCooldown(19434)) then  ShowColor(mainbutton.icon, 6603,A_5);ShowSpell(debutton.icon, 260402) return end
end

if PandaDB.CcdSwitch ~= false  then
--艾泽拉斯之心精华
--essences
if PandaDB.SJ_C8 then
if Isuseable("仇敌之血","仇敌之血") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.SJ_C8 then
if Isuseable("艾泽拉斯守护者","艾泽拉斯守护者") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.SJ_C8 then
if Isuseable("不羁之力","不羁之力") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.SJ_C8 then
if Isuseable("聚能艾泽里特射线","聚能艾泽里特射线") and Useing_spell("player") ~= 295258 then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.SJ_C8 then
if Isuseable("火红烈焰","火红烈焰") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.SJ_C8 then
if Isuseable("净化冲击","净化冲击") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.SJ_C8 then
if Isuseable("世界血脉共鸣","世界血脉共鸣") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.SJ_C8 then
if Isuseable("空间涟漪","空间涟漪") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.SJ_C8 then
if Isuseable("清醒梦境之忆","清醒梦境之忆") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.SJ_C8 then
if Isuseable("收割火焰","收割火焰")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.SJ_C8 then
if Isuseable("生命缚誓者之祈","生命缚誓者之祈")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.SJ_C8 then
if Isuseable("救世之魂","救世之魂")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.SJ_C8 then
if Isuseable("守护屏障","守护屏障")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.SJ_C8 then
if Isuseable("补充能量","补充能量")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.SJ_C8 then
if Isuseable("静滞","静滞")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.SJ_C8 then
if Isuseable("法力过载","法力过载")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.SJ_C8 then
if Isuseable("活力导管","活力导管")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.SJ_C8 then
if Isuseable("爆燃之拥","爆燃之拥")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.SJ_C8 then
if Isuseable("光荣时刻","光荣时刻")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.SJ_C8 then
if Isuseable("深渊之护","深渊之护")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.SJ_C8 then
if Isuseable("艾泽拉斯的不朽赐福","艾泽拉斯的不朽赐福")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.SJ_C8 then
if Isuseable("强化虚无屏障","强化虚无屏障")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

end

if PandaDB.CcdSwitch ~= false  then
if PandaDB.SJ_A1 ~= false  and Isuseable("百发百中",288613) then
if (Power("FOCUS")>60 and (Aura_time("PLAYER","弹无虚发") == 0 and SpellCooldown(257044) > 0 or not IsTalent("精确瞄准"))) then  ShowColor(mainbutton.icon, 6603,A_1);ShowSpell(debutton.icon, 288613) return end
end
end

--ST
if active_enemies()<3 then

if PandaDB.SJ_A6 ~= false  and Isuseable("爆炸射击",212431) then  ShowColor(mainbutton.icon, 6603,A_6);ShowSpell(debutton.icon, 212431) return end

if PandaDB.SJ_A8 ~= false  and Isuseable("弹幕射击",120360) and Useing_spell("PLAYER")~=120360  then  ShowColor(mainbutton.icon, 6603,A_8);ShowSpell(debutton.icon, 120360) return end

if PandaDB.SJ_A7 ~= false  and Isuseable("夺命黑鸦",131894) then  ShowColor(mainbutton.icon, 6603,A_7);ShowSpell(debutton.icon, 131894) return end

if PandaDB.SJ_A0 ~= false  and Isuseable("毒蛇钉刺",271788) then 
if ( Aura_time("target","毒蛇钉刺","PLAYER|HARMFUL") <=4 and  Last_Spell(1) ~= 271778 )then  ShowColor(mainbutton.icon, 6603,A_0);ShowSpell(debutton.icon, 271788) return end 
end

if PandaDB.SJ_A9 ~= false  and Isuseable("急速射击",257044) and Useing_spell("PLAYER")~=257044 then
if (Aura_time("PLAYER","百发百中") == 0 or Power("FOCUS")<70) then  ShowColor(mainbutton.icon, 6603,A_9);ShowSpell(debutton.icon, 257044) return end
end

if PandaDB.SJ_C1 ~= false  and Isuseable("奥术射击",185358) then
if (Aura_time("PLAYER","百发百中") > 0 and Aura_time("PLAYER","狙击高手")>0) then  ShowColor(mainbutton.icon, 6603,C_1);ShowSpell(debutton.icon, 185358) return end
end

if UnitSpeed("PLAYER")<=1 then 
if PandaDB.SJ_A2 ~= false  and Isuseable("瞄准射击",19434) then 
if (Aura_time("PLAYER","百发百中") > 0 or ( Aura_time("PLAYER","二连发") == 0 or HealthPercent("TARGET")<=20 or HealthPercent("TARGET")>=80 ) and Aura_time("PLAYER","弹无虚发") == 0 or SpellFullCharges(19434)<cast_time(19434) ) then  ShowColor(mainbutton.icon, 6603,A_2);ShowSpell(debutton.icon, 19434) return end 
end
end

if PandaDB.SJ_C2 ~= false  and Isuseable("穿刺射击",198670) then  ShowColor(mainbutton.icon, 6603,C_2);ShowSpell(debutton.icon, 198670) return end

if PandaDB.SJ_C1 ~= false  and Isuseable("奥术射击",185358) then
if ( Aura_time("PLAYER","百发百中") == 0 and ( Aura_time("PLAYER","弹无虚发") >0 and (Power("FOCUS")>41 or Aura_time("PLAYER","狙击高手")>0 )or (Power("FOCUS")>50 and  AzltE("集中火力")>0 or Power("FOCUS")>75) and (SpellCooldown(288613)>5 or Power("FOCUS")>80))) then  ShowColor(mainbutton.icon, 6603,C_1);ShowSpell(debutton.icon, 185358) return end
end

if UnitSpeed("PLAYER")>1 then

if PandaDB.SJ_C1 ~= false  and Isuseable("奥术射击",185358) then
if ( PowerMax("FOCUS")- Power("FOCUS") )/Hunter_focus_regen()<3 then  ShowColor(mainbutton.icon, 6603,C_1);ShowSpell(debutton.icon, 185358) return end
end

end

if PandaDB.SJ_C4 ~= false  and Isuseable("稳固射击",56641)  then  ShowColor(mainbutton.icon, 6603,C_4);ShowSpell(debutton.icon, 56641) return end

--trickshots
elseif active_enemies()>=3 then

if PandaDB.SJ_A8 ~= false  and Isuseable("弹幕射击",120360) and Useing_spell("PLAYER")~=120360  then  ShowColor(mainbutton.icon, 6603,A_8);ShowSpell(debutton.icon, 120360) return end

if PandaDB.SJ_A6 ~= false  and Isuseable("爆炸射击",212431) then  ShowColor(mainbutton.icon, 6603,A_6);ShowSpell(debutton.icon, 212431) return end

if PandaDB.SJ_A9 ~= false  and Isuseable("急速射击",257044) and Useing_spell("PLAYER")~=257044 then
if ( not DCSJ() and (AzltE("集中火力")>0 or AzltE("弦之韵律")>1 or AzltE("激涌射击")>0 or IsTalent("行云流水"))) then  ShowColor(mainbutton.icon, 6603,A_9);ShowSpell(debutton.icon, 257044) return end
end

if UnitSpeed("PLAYER")<=1 then
if PandaDB.SJ_A2 ~= false  and Isuseable("瞄准射击",19434)  then
if ( not DCSJ() and (Aura_time("PLAYER","弹无虚发")==0 or SpellFullCharges(19434)<cast_time(19434) ) ) then  ShowColor(mainbutton.icon, 6603,A_2);ShowSpell(debutton.icon, 19434) return end
end
end

if PandaDB.SJ_A9 ~= false  and Isuseable("急速射击",257044) and Useing_spell("PLAYER")~=257044 then
if (  not DCSJ() ) then  ShowColor(mainbutton.icon, 6603,A_9);ShowSpell(debutton.icon, 257044) return end
end

if PandaDB.SJ_A4 ~= false  and Isuseable("多重射击",2643) then
if ( DCSJ() or Aura_time("PLAYER","弹无虚发")>0 or Power("FOCUS")>70 ) then  ShowColor(mainbutton.icon, 6603,A_4);ShowSpell(debutton.icon, 2643) return end
end

if PandaDB.SJ_C2 ~= false  and Isuseable("穿刺射击",198670) then  ShowColor(mainbutton.icon, 6603,C_2);ShowSpell(debutton.icon, 198670) return end

if PandaDB.SJ_A7 ~= false  and Isuseable("夺命黑鸦",131894) then  ShowColor(mainbutton.icon, 6603,A_7);ShowSpell(debutton.icon, 131894) return end

if PandaDB.SJ_A0 ~= false  and Isuseable("毒蛇钉刺",271788) then
if ( Aura_time("target","毒蛇钉刺","PLAYER|HARMFUL") <=4 and  Last_Spell(1) ~= 271778 )then  ShowColor(mainbutton.icon, 6603,A_0);ShowSpell(debutton.icon, 271788) return end
end

if UnitSpeed("PLAYER")>1 then
if PandaDB.SJ_A4 ~= false  and Isuseable("多重射击",2643) then
if ( PowerMax("FOCUS")- Power("FOCUS") )/Hunter_focus_regen()<3 then  ShowColor(mainbutton.icon, 6603,A_4);ShowSpell(debutton.icon, 2643) return end
end
end

if PandaDB.SJ_C4 ~= false  and Isuseable("稳固射击",56641)  then  ShowColor(mainbutton.icon, 6603,C_4);ShowSpell(debutton.icon, 56641) return end

end




---------------------------------------------------------------------------
--[[                       编辑区                       ]]--
---------------------------------------------------------------------------

ShowColor(mainbutton.icon, 6603,6603);ShowSpell(debutton.icon, 311923)	

--elseif not Authorization() then 
--print("|cffffe00a★Panda★:【|r|c00FF68CC 插件未激活 联系QQ:398371778 |r|cffffe00a】|r")

--end

end

end

local Hunter_Marksmanship = Hunter_Marksmanship
ns.Hunter_Marksmanship = Hunter_Marksmanship

