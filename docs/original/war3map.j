globals
boolean udg_GameOver=false
string array udg_ColorText
force udg_Discos=null
force udg_Losers=null
force udg_Players=null
location array udg_Points
integer udg_Round=0
integer array udg_Score
boolean array udg_Alive
integer udg_collisionRange=0
integer udg_toDrop=0
integer udg_count=0
item array udg_currentItems
integer udg_activeItem=0
real udg_angle=0
unit array udg_kittys
unit udg_selectedKitty=null
trigger array udg_slideTriggers
real udg_timeInterval=0
location udg_tempPoint1=null
location udg_tempPoint2=null
force udg_tempPlayerGroup=null
integer udg_originalTexture=0
integer array udg_originalTerrain
location array udg_terrainPoints
location array udg_teleportPoints
rect array udg_LeapRegions
rect array udg_teleportRegions
real udg_teleportSize=0
boolean udg_loopGuard=false
location array udg_kittyStartingPoints
real udg_minTeleport=0
real udg_speedMultiplier=0
effect array udg_leftSE1
effect array udg_rightSE
real udg_REALSPD1=0
real udg_REALSPD2=0
real udg_REALSPD4=0
real udg_REALSPD5=0
real udg_REALSPD6=0
real udg_REALSPD7=0
real udg_REALSPD8=0
real udg_REALSPD9=0
real udg_REALSPD10=0
real udg_REALSPD11=0
real udg_REALSPD3=0
effect udg_EFECT=null
rect gg_rct_Wolf_Area_One=null
rect gg_rct_Wolf_Area_Two=null
rect gg_rct_Wofl_Area_Three=null
rect gg_rct_Wolf_Area_Four=null
rect gg_rct_Wofl_Area_Five=null
rect gg_rct_Wolf_Area_Six=null
rect gg_rct_Wolf_Area_Seven=null
rect gg_rct_Wolf_Area_Eight=null
rect gg_rct_Wofl_Area_Nine=null
rect gg_rct_Wolf_Area_Ten=null
rect gg_rct_Wofl_Area_Eleven=null
rect gg_rct_Wolf_Area_Twelve=null
rect gg_rct_Wolf_Area_Thirteen=null
rect gg_rct_Wolf_Area_Fourteen=null
rect gg_rct_Wolf_Area_Fifteen=null
rect gg_rct_Next_Round=null
rect gg_rct_Kitty_Start=null
rect gg_rct_Red_Revive=null
rect gg_rct_Blue_Revive=null
rect gg_rct_Teal_Revive=null
rect gg_rct_Purple_Revive=null
rect gg_rct_Orange_Revive=null
rect gg_rct_Yellow_Revive=null
rect gg_rct_Green_Revive=null
rect gg_rct_Pink_Revive=null
rect gg_rct_Gray_Revive=null
rect gg_rct_Light_Blue_Revive=null
rect gg_rct_Dark_Green_Revive=null
rect gg_rct_SideGuardTop1=null
rect gg_rct_SideGuardTop2=null
rect gg_rct_SideGuardTop3=null
rect gg_rct_SideGuardTop4=null
rect gg_rct_SideGuardTop5=null
rect gg_rct_SideGuardTop6=null
rect gg_rct_SideGuardTop7=null
rect gg_rct_SideGuardTop8=null
rect gg_rct_SideGuardBottom8=null
rect gg_rct_SideGuardBottom7=null
rect gg_rct_SideGuardBottom6=null
rect gg_rct_SideGuardBottom5=null
rect gg_rct_SideGuardBottom4=null
rect gg_rct_SideGuardBottom3=null
rect gg_rct_SideGuardBottom2=null
rect gg_rct_SideGuardBottom1=null
rect gg_rct_SideGuardRight1=null
rect gg_rct_SideGuardRight2=null
rect gg_rct_SideGuardRight3=null
rect gg_rct_SideGuardRight4=null
rect gg_rct_SideGuardRight5=null
rect gg_rct_SideGuardRight6=null
rect gg_rct_SideGuardRight7=null
rect gg_rct_SideGuardRight8=null
rect gg_rct_SideGuardLeft8=null
rect gg_rct_SideGuardLeft7=null
rect gg_rct_SideGuardLeft6=null
rect gg_rct_SideGuardLeft5=null
rect gg_rct_SideGuardLeft4=null
rect gg_rct_SideGuardLeft3=null
rect gg_rct_Lvl1=null
rect gg_rct_Lvl2=null
rect gg_rct_Lvl3=null
rect gg_rct_Lvl4=null
rect gg_rct_Lvl5=null
rect gg_rct_Lvl6=null
rect gg_rct_Lvl7=null
rect gg_rct_Lvl8=null
rect gg_rct_Lvl9=null
rect gg_rct_Lvl10=null
rect gg_rct_Lvl11=null
rect gg_rct_Lvl12=null
rect gg_rct_Lvl13=null
rect gg_rct_Lvl14=null
rect gg_rct_Leap1=null
rect gg_rct_Leap2=null
rect gg_rct_Leap3=null
rect gg_rct_Leap4=null
rect gg_rct_Leap5=null
rect gg_rct_Leap6=null
rect gg_rct_Leap7=null
rect gg_rct_Leap8=null
rect gg_rct_Leap9=null
rect gg_rct_Leap10=null
rect gg_rct_Leap11=null
rect gg_rct_Leap12=null
rect gg_rct_Leap13=null
rect gg_rct_Leap14=null
sound gg_snd_Audio_wma=null
sound gg_snd_filename_Kung_Fu_Panda=null
trigger gg_trg_Kick2=null
trigger gg_trg_Kick3=null
trigger gg_trg_Kick4=null
trigger gg_trg_Kick5=null
trigger gg_trg_Kich6=null
trigger gg_trg_Kick7=null
trigger gg_trg_Kick8=null
trigger gg_trg_Kick9=null
trigger gg_trg_Kick10=null
trigger gg_trg_Kick11=null
trigger gg_trg_SATART=null
trigger gg_trg_Game_End_Dbl_Chk=null
trigger gg_trg_bug=null
trigger gg_trg_Leaderboard=null
trigger gg_trg_Set_level=null
trigger gg_trg_Trigger_Next_Round=null
trigger gg_trg_Win=null
trigger gg_trg_Remove=null
trigger gg_trg_Game_Over=null
trigger gg_trg_Not_here=null
trigger gg_trg_Next_Round=null
trigger gg_trg_PlayerLeaves=null
trigger gg_trg_PlayerLeft=null
trigger gg_trg_Starting_Gold=null
trigger gg_trg_TimeofDay=null
trigger gg_trg_Randomize=null
trigger gg_trg_Master_Slide=null
trigger gg_trg_Master_Turn_Point=null
trigger gg_trg_Master_Turn_Unit=null
trigger gg_trg_Master_Turn_Item=null
trigger gg_trg_P1_Slide=null
trigger gg_trg_P2_Slide=null
trigger gg_trg_P3_Slide=null
trigger gg_trg_P4_Slide=null
trigger gg_trg_P5_Slide=null
trigger gg_trg_P6_Slide=null
trigger gg_trg_P7_Slide=null
trigger gg_trg_P8_Slide=null
trigger gg_trg_P9_Slide=null
trigger gg_trg_P10_Slide=null
trigger gg_trg_P11_Slide=null
trigger gg_trg_P1_Revive=null
trigger gg_trg_P2_Revive=null
trigger gg_trg_P3_Revive=null
trigger gg_trg_P4_Revive=null
trigger gg_trg_P5_Revive=null
trigger gg_trg_P6_Revive=null
trigger gg_trg_P7_Revive=null
trigger gg_trg_P8_Revive=null
trigger gg_trg_P9_Revive=null
trigger gg_trg_P10_Revive=null
trigger gg_trg_P11_Revive=null
trigger gg_trg_P1=null
trigger gg_trg_P2=null
trigger gg_trg_P3=null
trigger gg_trg_P4=null
trigger gg_trg_P5=null
trigger gg_trg_P6=null
trigger gg_trg_P7=null
trigger gg_trg_P8=null
trigger gg_trg_P9=null
trigger gg_trg_P10=null
trigger gg_trg_P11=null
trigger gg_trg_Untitled_Trigger_001=null
trigger gg_trg_Axel_F=null
trigger gg_trg_Wolf_Area_One=null
trigger gg_trg_Wolf_Area_Two=null
trigger gg_trg_Wolf_Area_Three=null
trigger gg_trg_Wolf_Area_Four=null
trigger gg_trg_Wolf_Area_Five=null
trigger gg_trg_Wolf_Area_Six=null
trigger gg_trg_Wolf_Area_Seven=null
trigger gg_trg_Wolf_Area_Eight=null
trigger gg_trg_Wolf_Area_Nine=null
trigger gg_trg_Wolf_Area_Ten=null
trigger gg_trg_Wolf_Area_Eleven=null
trigger gg_trg_Wolf_Area_Twelve=null
trigger gg_trg_Wolf_Area_Thirteen=null
trigger gg_trg_Wolf_Area_Fourteen=null
trigger gg_trg_Wolf_Area_Fifteen=null
trigger gg_trg_Spawn=null
trigger gg_trg_Collect_1=null
trigger gg_trg_Collect_2=null
trigger gg_trg_Collect_3=null
trigger gg_trg_Collect_4=null
trigger gg_trg_Collect_5=null
trigger gg_trg_Collect_6=null
trigger gg_trg_Collect_7=null
trigger gg_trg_Collect_8=null
trigger gg_trg_Collect_9=null
trigger gg_trg_Collect_10=null
trigger gg_trg_Collect_11=null
trigger gg_trg_SideGuardTop1=null
trigger gg_trg_SideGuardTop2=null
trigger gg_trg_SideGuardTop3=null
trigger gg_trg_SideGuardTop4=null
trigger gg_trg_SideGuardTop5=null
trigger gg_trg_SideGuardTop6=null
trigger gg_trg_SideGuardTop7=null
trigger gg_trg_SideGuardTop8=null
trigger gg_trg_SideGuardBottom1=null
trigger gg_trg_SideGuardBottom2=null
trigger gg_trg_SideGuardBottom3=null
trigger gg_trg_SideGuardBottom4=null
trigger gg_trg_SideGuardBottom5=null
trigger gg_trg_SideGuardBottom6=null
trigger gg_trg_SideGuardBottom7=null
trigger gg_trg_SideGuardBottom8=null
trigger gg_trg_SideGuardRight1=null
trigger gg_trg_SideGuardRight2=null
trigger gg_trg_SideGuardRight3=null
trigger gg_trg_SideGuardRight4=null
trigger gg_trg_SideGuardRight5=null
trigger gg_trg_SideGuardRight6=null
trigger gg_trg_SideGuardRight7=null
trigger gg_trg_SideGuardRight8=null
trigger gg_trg_SideGuardLeft3=null
trigger gg_trg_SideGuardLeft4=null
trigger gg_trg_SideGuardLeft5=null
trigger gg_trg_SideGuardLeft6=null
trigger gg_trg_SideGuardLeft7=null
trigger gg_trg_SideGuardLeft8=null
trigger gg_trg_Lvl1=null
trigger gg_trg_Lvl2=null
trigger gg_trg_Lvl3=null
trigger gg_trg_Lvl4=null
trigger gg_trg_Lvl5=null
trigger gg_trg_Lvl6=null
trigger gg_trg_Lvl7=null
trigger gg_trg_Lvl8=null
trigger gg_trg_Lvl9=null
trigger gg_trg_Lvl10=null
trigger gg_trg_Lvl11=null
trigger gg_trg_Lvl12=null
trigger gg_trg_Lvl13=null
trigger gg_trg_Lvl14=null
trigger gg_trg_JUMP_effect_1=null
trigger gg_trg_JUMP_effect_2=null
trigger gg_trg_JUMP_effect_3=null
trigger gg_trg_JUMP_effect_4=null
trigger gg_trg_JUMP_effect_5=null
trigger gg_trg_JUMP_effect_6=null
trigger gg_trg_JUMP_effect_7=null
trigger gg_trg_JUMP_effect_8=null
trigger gg_trg_JUMP_effect_9=null
trigger gg_trg_JUMP_effect_10=null
trigger gg_trg_JUMP_effect_11=null
trigger gg_trg_LeapOfFaith=null
trigger gg_trg_JUMp1=null
trigger gg_trg_JUMp2=null
trigger gg_trg_JUMp3=null
trigger gg_trg_JUMp4=null
trigger gg_trg_JUMp5=null
trigger gg_trg_JUMp6=null
trigger gg_trg_JUMp7=null
trigger gg_trg_JUMp8=null
trigger gg_trg_JUMp9=null
trigger gg_trg_JUMp10=null
trigger gg_trg_JUMp11=null
trigger gg_trg_Thaw=null
trigger gg_trg_Drift1=null
trigger gg_trg_driftefect1=null
trigger gg_trg_driftefect2=null
trigger gg_trg_driftefect3=null
trigger gg_trg_driftefect4=null
trigger gg_trg_driftefect5=null
trigger gg_trg_driftefect6=null
trigger gg_trg_driftefect7=null
trigger gg_trg_driftefect8=null
trigger gg_trg_driftefect9=null
trigger gg_trg_driftefect10=null
trigger gg_trg_driftefect11=null
trigger gg_trg_Drift2=null
trigger gg_trg_Drift3=null
trigger gg_trg_Drift4=null
trigger gg_trg_Drift5=null
trigger gg_trg_Drift6=null
trigger gg_trg_Drift7=null
trigger gg_trg_Drift8=null
trigger gg_trg_Drift9=null
trigger gg_trg_Drift10=null
trigger gg_trg_Drift11=null
unit gg_unit_E000_0001=null
unit gg_unit_E000_0002=null
unit gg_unit_E000_0003=null
unit gg_unit_E000_0004=null
unit gg_unit_E000_0005=null
unit gg_unit_E000_0006=null
unit gg_unit_E000_0007=null
unit gg_unit_E000_0008=null
unit gg_unit_E000_0009=null
unit gg_unit_E000_0010=null
unit gg_unit_E000_0011=null
integer array gg_rg_000
endglobals
function InitGlobals takes nothing returns nothing
local integer i=0
set udg_GameOver=false
set i=0
loop
exitwhen(i>1)
set udg_ColorText[i]=""
set i=i+1
endloop
set udg_Discos=bj_FORCE_PLAYER[0]
set udg_Losers=CreateForce()
set udg_Players=CreateForce()
set udg_Round=1
set i=0
loop
exitwhen(i>1)
set udg_Score[i]=0
set i=i+1
endloop
set i=0
loop
exitwhen(i>11)
set udg_Alive[i]=true
set i=i+1
endloop
set udg_collisionRange=40
set udg_count=0
set udg_activeItem=6
set udg_angle=0
set i=0
loop
exitwhen(i>11)
set udg_slideTriggers[i]=CreateTrigger()
set i=i+1
endloop
set udg_timeInterval=0.01
set udg_tempPlayerGroup=CreateForce()
set udg_teleportSize=0
set udg_loopGuard=false
set udg_minTeleport=0
set udg_speedMultiplier=4.00
set udg_REALSPD1=0
set udg_REALSPD2=0
set udg_REALSPD4=0
set udg_REALSPD5=0
set udg_REALSPD6=0
set udg_REALSPD7=0
set udg_REALSPD8=0
set udg_REALSPD9=0
set udg_REALSPD10=0
set udg_REALSPD11=0
set udg_REALSPD3=0
endfunction
function InitRandomGroups takes nothing returns nothing
local integer curset
call RandomDistReset()
call RandomDistAddItem(0,6)
call RandomDistAddItem(1,3)
call RandomDistAddItem(2,3)
call RandomDistAddItem(3,3)
call RandomDistAddItem(4,20)
call RandomDistAddItem(5,2)
call RandomDistAddItem(6,10)
call RandomDistAddItem(7,3)
call RandomDistAddItem(8,20)
call RandomDistAddItem(9,20)
call RandomDistAddItem(10,10)
set curset=RandomDistChoose()
if(curset==0)then
set gg_rg_000[0]='I003'
elseif(curset==1)then
set gg_rg_000[0]='I002'
elseif(curset==2)then
set gg_rg_000[0]='I001'
elseif(curset==3)then
set gg_rg_000[0]='I000'
elseif(curset==4)then
set gg_rg_000[0]='bspd'
elseif(curset==5)then
set gg_rg_000[0]='tkno'
elseif(curset==6)then
set gg_rg_000[0]='penr'
elseif(curset==7)then
set gg_rg_000[0]='texp'
elseif(curset==8)then
set gg_rg_000[0]='pspd'
elseif(curset==9)then
set gg_rg_000[0]='pman'
elseif(curset==10)then
set gg_rg_000[0]='rwiz'
else
set gg_rg_000[0]=-1
endif
endfunction
function Unit000015_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000016_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000017_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000018_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000019_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000020_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000021_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000022_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000023_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000024_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000025_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000026_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000027_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000028_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000029_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000030_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000031_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000032_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000033_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000034_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000035_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000036_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('bspd',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000037_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('bspd',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000038_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000039_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000040_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000041_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('bspd',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000042_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000043_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000044_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000045_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000046_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000047_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000048_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000049_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000050_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000051_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000052_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000053_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000054_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000055_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000056_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000057_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000058_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000059_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000060_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000061_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000062_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000063_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000064_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000065_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000066_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000067_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000068_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000069_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000070_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',1)
call RandomDistAddItem(-1,99)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000071_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000072_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000073_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000074_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000075_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000076_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000077_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000078_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000079_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000080_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000081_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000082_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000083_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000084_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000085_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000086_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000087_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000088_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000089_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000090_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000091_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000092_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000093_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000095_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000096_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000097_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000098_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000099_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000100_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000101_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000102_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000103_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000104_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000105_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000106_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000107_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000108_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000109_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000110_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000111_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000112_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000113_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000114_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000115_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000116_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000118_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000120_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000122_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000124_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000126_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000128_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000130_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000132_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000134_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000136_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000137_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000138_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000139_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000140_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,95)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Unit000260_DropItems takes nothing returns nothing
local widget trigWidget=null
local unit trigUnit=null
local integer itemID=0
local boolean canDrop=true
set trigWidget=bj_lastDyingWidget
if(trigWidget==null)then
set trigUnit=GetTriggerUnit()
endif
if(trigUnit!=null)then
set canDrop=not IsUnitHidden(trigUnit)
if(canDrop and GetChangingUnit()!=null)then
set canDrop=(GetChangingUnitPrevOwner()==Player(PLAYER_NEUTRAL_AGGRESSIVE))
endif
endif
if(canDrop)then
call RandomDistReset()
call RandomDistAddItem('I005',5)
call RandomDistAddItem('I004',5)
call RandomDistAddItem(-1,90)
set itemID=RandomDistChoose()
if(trigUnit!=null)then
call UnitDropItem(trigUnit,itemID)
else
call WidgetDropItem(trigWidget,itemID)
endif
endif
set bj_lastDyingWidget=null
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function InitSounds takes nothing returns nothing
set gg_snd_Audio_wma=CreateSound("war3mapImported\\Audio.wma.WAV",false,false,false,10,10,"")
call SetSoundDuration(gg_snd_Audio_wma,604)
call SetSoundChannel(gg_snd_Audio_wma,0)
call SetSoundVolume(gg_snd_Audio_wma,127)
call SetSoundPitch(gg_snd_Audio_wma,1.0)
set gg_snd_filename_Kung_Fu_Panda=CreateSound("war3mapImported\\filename=Kung-Fu-Panda.mp3",true,false,false,10,10,"DefaultEAXON")
call SetSoundDuration(gg_snd_filename_Kung_Fu_Panda,206780)
call SetSoundChannel(gg_snd_filename_Kung_Fu_Panda,0)
call SetSoundVolume(gg_snd_filename_Kung_Fu_Panda,127)
call SetSoundPitch(gg_snd_filename_Kung_Fu_Panda,1.0)
endfunction
function CreateUnitsForPlayer0 takes nothing returns nothing
local player p=Player(0)
local unit u
local integer unitID
local trigger t
local real life
set gg_unit_E000_0001=CreateUnit(p,'E000',-2657.5,2973.5,285.000)
endfunction
function CreateUnitsForPlayer1 takes nothing returns nothing
local player p=Player(1)
local unit u
local integer unitID
local trigger t
local real life
set gg_unit_E000_0002=CreateUnit(p,'E000',-2736.3,2933.2,300.000)
endfunction
function CreateUnitsForPlayer2 takes nothing returns nothing
local player p=Player(2)
local unit u
local integer unitID
local trigger t
local real life
set gg_unit_E000_0003=CreateUnit(p,'E000',-2800.8,2880.1,315.000)
endfunction
function CreateUnitsForPlayer3 takes nothing returns nothing
local player p=Player(3)
local unit u
local integer unitID
local trigger t
local real life
set gg_unit_E000_0004=CreateUnit(p,'E000',-2845.4,2818.4,330.000)
endfunction
function CreateUnitsForPlayer4 takes nothing returns nothing
local player p=Player(4)
local unit u
local integer unitID
local trigger t
local real life
set gg_unit_E000_0005=CreateUnit(p,'E000',-2881.9,2742.4,345.000)
endfunction
function CreateUnitsForPlayer5 takes nothing returns nothing
local player p=Player(5)
local unit u
local integer unitID
local trigger t
local real life
set gg_unit_E000_0006=CreateUnit(p,'E000',-2888.0,2664.1,0.000)
endfunction
function CreateUnitsForPlayer6 takes nothing returns nothing
local player p=Player(6)
local unit u
local integer unitID
local trigger t
local real life
set gg_unit_E000_0007=CreateUnit(p,'E000',-2879.9,2580.9,15.000)
endfunction
function CreateUnitsForPlayer7 takes nothing returns nothing
local player p=Player(7)
local unit u
local integer unitID
local trigger t
local real life
set gg_unit_E000_0008=CreateUnit(p,'E000',-2841.3,2505.0,30.000)
endfunction
function CreateUnitsForPlayer8 takes nothing returns nothing
local player p=Player(8)
local unit u
local integer unitID
local trigger t
local real life
set gg_unit_E000_0009=CreateUnit(p,'E000',-2790.7,2433.7,45.000)
endfunction
function CreateUnitsForPlayer9 takes nothing returns nothing
local player p=Player(9)
local unit u
local integer unitID
local trigger t
local real life
set gg_unit_E000_0010=CreateUnit(p,'E000',-2727.4,2385.3,60.000)
endfunction
function CreateUnitsForPlayer10 takes nothing returns nothing
local player p=Player(10)
local unit u
local integer unitID
local trigger t
local real life
set gg_unit_E000_0011=CreateUnit(p,'E000',-2659.3,2352.1,75.000)
endfunction
function CreateUnitsForPlayer11 takes nothing returns nothing
local player p=Player(11)
local unit u
local integer unitID
local trigger t
local real life
set u=CreateUnit(p,'nwwg',1996.3,341.9,129.430)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000017_DropItems)
set u=CreateUnit(p,'nwwg',2018.2,-1999.2,314.490)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000018_DropItems)
set u=CreateUnit(p,'nwwg',2287.3,-1342.4,73.220)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000019_DropItems)
set u=CreateUnit(p,'nwwg',-2249.6,2855.9,226.440)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000031_DropItems)
set u=CreateUnit(p,'nwwg',-2031.7,2484.9,257.620)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000085_DropItems)
set u=CreateUnit(p,'nwwg',-1564.1,2863.4,250.480)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000033_DropItems)
set u=CreateUnit(p,'nwwg',-1143.5,2441.4,144.320)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000034_DropItems)
set u=CreateUnit(p,'nwwg',-403.4,2489.5,221.360)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000036_DropItems)
set u=CreateUnit(p,'nwwg',-22.2,2887.8,283.500)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000037_DropItems)
set u=CreateUnit(p,'nwwg',389.3,2489.5,198.640)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000038_DropItems)
set u=CreateUnit(p,'nwwg',808.3,2877.1,259.940)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000039_DropItems)
set u=CreateUnit(p,'nwwg',1597.6,2882.6,37.530)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000041_DropItems)
set u=CreateUnit(p,'nwwg',1956.2,2371.8,22.560)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000042_DropItems)
set u=CreateUnit(p,'nwwg',2200.8,2867.7,192.490)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000043_DropItems)
set u=CreateUnit(p,'nwwg',2701.7,1978.1,164.980)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000044_DropItems)
set u=CreateUnit(p,'nwwg',3212.6,1644.3,219.060)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000045_DropItems)
set u=CreateUnit(p,'nwwg',2665.7,1291.0,217.160)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000046_DropItems)
set u=CreateUnit(p,'nwwg',3159.0,1090.3,356.780)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000047_DropItems)
set u=CreateUnit(p,'nwwg',2673.6,759.6,341.710)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000048_DropItems)
set u=CreateUnit(p,'nwwg',3145.1,391.3,270.880)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000049_DropItems)
set u=CreateUnit(p,'nwwg',2691.5,160.0,182.010)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000050_DropItems)
set u=CreateUnit(p,'nwwg',3130.1,-337.6,69.610)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000051_DropItems)
set u=CreateUnit(p,'nwwg',2684.8,-634.8,19.580)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000052_DropItems)
set u=CreateUnit(p,'nwwg',3157.3,-1147.4,142.960)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000053_DropItems)
set u=CreateUnit(p,'nwwg',2665.5,-1526.6,357.600)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000054_DropItems)
set u=CreateUnit(p,'nwwg',3190.4,-1939.8,96.320)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000055_DropItems)
set u=CreateUnit(p,'nwwg',2667.2,-2414.3,11.280)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000056_DropItems)
set u=CreateUnit(p,'nwwg',3161.7,-2588.1,176.800)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000057_DropItems)
set u=CreateUnit(p,'nwwg',-2202.0,-3104.3,159.100)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000058_DropItems)
set u=CreateUnit(p,'nwwg',-2097.1,-3506.8,55.520)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000059_DropItems)
set u=CreateUnit(p,'nwwg',-1780.3,-3025.6,286.860)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000060_DropItems)
set u=CreateUnit(p,'nwwg',-1476.0,-3530.9,259.880)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000061_DropItems)
set u=CreateUnit(p,'nwwg',-1055.1,-3070.9,84.880)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000062_DropItems)
set u=CreateUnit(p,'nwwg',-858.9,-3515.5,291.100)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000063_DropItems)
set u=CreateUnit(p,'nwwg',-503.6,-3023.1,326.840)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000064_DropItems)
set u=CreateUnit(p,'nwwg',-24.1,-3532.6,168.540)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000065_DropItems)
set u=CreateUnit(p,'nwwg',313.4,-3015.7,359.040)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000066_DropItems)
set u=CreateUnit(p,'nwwg',688.8,-3518.9,63.600)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000067_DropItems)
set u=CreateUnit(p,'nwwg',1078.4,-3025.6,309.330)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000068_DropItems)
set u=CreateUnit(p,'nwwg',1450.0,-3518.9,84.860)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000069_DropItems)
set u=CreateUnit(p,'nwwg',1807.8,-3010.7,151.340)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000070_DropItems)
set u=CreateUnit(p,'nwwg',2228.2,-3508.6,153.780)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000071_DropItems)
set u=CreateUnit(p,'nwwg',-3154.3,-2631.7,141.380)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000072_DropItems)
set u=CreateUnit(p,'nwwg',-2643.4,-2257.5,72.470)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000073_DropItems)
set u=CreateUnit(p,'nwwg',-3165.0,-1836.1,115.130)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000074_DropItems)
set u=CreateUnit(p,'nwwg',-2636.0,-1380.3,304.040)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000075_DropItems)
set u=CreateUnit(p,'nwwg',-3240.4,-987.4,58.540)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000076_DropItems)
set u=CreateUnit(p,'nwwg',-2648.2,-494.5,193.850)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000077_DropItems)
set u=CreateUnit(p,'nwwg',-2650.7,-1803.3,29.530)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000078_DropItems)
set u=CreateUnit(p,'nwwg',-3127.7,-2411.1,220.070)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000079_DropItems)
set u=CreateUnit(p,'nwwg',-3205.9,-357.3,208.980)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000080_DropItems)
set u=CreateUnit(p,'nwwg',-2612.3,249.2,181.820)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000081_DropItems)
set u=CreateUnit(p,'nwwg',-3184.6,423.3,7.390)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000082_DropItems)
set u=CreateUnit(p,'nwwg',-2660.3,788.9,206.570)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000083_DropItems)
set u=CreateUnit(p,'nwwg',-3169.3,1106.1,345.200)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000084_DropItems)
set u=CreateUnit(p,'nwwg',-2277.6,2102.0,94.620)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000032_DropItems)
set u=CreateUnit(p,'nwwg',-1901.2,1592.2,2.430)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000086_DropItems)
set u=CreateUnit(p,'nwwg',-1362.3,2114.7,157.930)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000087_DropItems)
set u=CreateUnit(p,'nwwg',-981.1,1600.6,112.380)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000088_DropItems)
set u=CreateUnit(p,'nwwg',-506.3,2127.5,201.900)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000089_DropItems)
set u=CreateUnit(p,'nwwg',16.8,1630.6,286.430)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000090_DropItems)
set u=CreateUnit(p,'nwwg',499.9,2103.5,288.950)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000091_DropItems)
set u=CreateUnit(p,'nwwg',980.8,1588.0,297.930)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000092_DropItems)
set u=CreateUnit(p,'nwwg',1483.2,2115.3,158.320)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000093_DropItems)
set u=CreateUnit(p,'nwwg',2038.9,1244.4,165.880)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000095_DropItems)
set u=CreateUnit(p,'nwwg',2343.3,544.8,335.720)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000096_DropItems)
set u=CreateUnit(p,'nwwg',2003.4,-150.5,301.980)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000097_DropItems)
set u=CreateUnit(p,'nwwg',2328.8,-820.9,5.120)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000098_DropItems)
set u=CreateUnit(p,'nwwg',1970.9,-1382.1,322.630)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000099_DropItems)
set u=CreateUnit(p,'nwwg',2356.9,-1942.3,325.360)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000100_DropItems)
set u=CreateUnit(p,'nwwg',1641.3,-2766.8,79.180)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000101_DropItems)
set u=CreateUnit(p,'nwwg',932.4,-2506.0,156.830)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000102_DropItems)
set u=CreateUnit(p,'nwwg',535.8,-2756.2,289.700)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000103_DropItems)
set u=CreateUnit(p,'nwwg',132.0,-2500.9,130.160)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000104_DropItems)
set u=CreateUnit(p,'nwwg',-342.4,-2732.6,358.520)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000105_DropItems)
set u=CreateUnit(p,'nwwg',-785.8,-2506.0,348.870)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000106_DropItems)
set u=CreateUnit(p,'nwwg',-1152.0,-2730.4,79.950)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000107_DropItems)
set u=CreateUnit(p,'nwwg',-1432.0,-2500.9,138.950)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000108_DropItems)
set u=CreateUnit(p,'nwwg',-1666.5,-2714.5,272.370)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000109_DropItems)
set u=CreateUnit(p,'nwwg',-2103.1,-1915.7,98.100)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000110_DropItems)
set u=CreateUnit(p,'nwwg',-2364.1,-1643.9,17.820)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000111_DropItems)
set u=CreateUnit(p,'nwwg',-2129.3,-1109.5,275.860)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000112_DropItems)
set u=CreateUnit(p,'nwwg',-2355.5,-620.4,166.110)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000113_DropItems)
set u=CreateUnit(p,'nwwg',-2110.1,-68.3,288.290)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000114_DropItems)
set u=CreateUnit(p,'nwwg',-2389.1,449.0,330.750)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000115_DropItems)
set u=CreateUnit(p,'nwwg',-2335.3,-192.3,234.150)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000116_DropItems)
set u=CreateUnit(p,'nwwg',-1234.0,1073.7,109.370)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000021_DropItems)
set u=CreateUnit(p,'nwwg',-924.0,1082.5,100.950)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000118_DropItems)
set u=CreateUnit(p,'nwwg',0.0,1075.5,108.160)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000020_DropItems)
set u=CreateUnit(p,'nwwg',-351.5,1077.9,148.990)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000120_DropItems)
set u=CreateUnit(p,'nwwg',1400.2,273.7,182.810)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000023_DropItems)
set u=CreateUnit(p,'nwwg',359.1,1082.5,234.540)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000122_DropItems)
set u=CreateUnit(p,'nwwg',1604.7,-661.5,189.410)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000024_DropItems)
set u=CreateUnit(p,'nwwg',937.6,1087.0,232.750)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000124_DropItems)
set u=CreateUnit(p,'nwwg',1409.2,-1279.2,111.270)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000025_DropItems)
set u=CreateUnit(p,'nwwg',1478.4,576.9,5.000)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000126_DropItems)
set u=CreateUnit(p,'nwwg',-835.8,-1819.1,30.240)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000026_DropItems)
set u=CreateUnit(p,'nwwg',1467.7,-190.2,291.530)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000128_DropItems)
set u=CreateUnit(p,'nwwg',707.3,-1763.0,296.130)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000027_DropItems)
set u=CreateUnit(p,'nwwg',1465.6,-1043.1,219.720)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000130_DropItems)
set u=CreateUnit(p,'nwwg',-88.0,-1986.0,198.060)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000028_DropItems)
set u=CreateUnit(p,'nwwg',945.6,-1859.8,250.390)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000132_DropItems)
set u=CreateUnit(p,'nwwg',348.0,-1860.9,194.380)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000134_DropItems)
set u=CreateUnit(p,'nwwg',-319.7,558.5,221.960)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000035_DropItems)
set u=CreateUnit(p,'nwwg',-483.3,-1853.3,120.270)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000136_DropItems)
set u=CreateUnit(p,'nwwg',-961.3,-1944.3,124.230)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000138_DropItems)
set u=CreateUnit(p,'nwwg',867.3,-1166.2,23.670)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000040_DropItems)
set u=CreateUnit(p,'nwwg',-1474.8,-844.2,276.590)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000015_DropItems)
set u=CreateUnit(p,'nwwg',-1463.5,-58.3,180.370)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000137_DropItems)
set u=CreateUnit(p,'nwwg',-757.5,320.4,6.690)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000139_DropItems)
set u=CreateUnit(p,'nwwg',20.4,316.5,193.160)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000030_DropItems)
set u=CreateUnit(p,'nwwg',305.0,477.5,176.150)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000022_DropItems)
set u=CreateUnit(p,'nwwg',860.0,-106.2,319.540)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000016_DropItems)
set u=CreateUnit(p,'nwwg',848.9,-773.9,81.260)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000029_DropItems)
set u=CreateUnit(p,'nwwg',463.0,-1228.0,314.900)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000140_DropItems)
set u=CreateUnit(p,'n001',800.2,-434.1,179.030)
set t=CreateTrigger()
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_CHANGE_OWNER)
call TriggerAddAction(t,function Unit000260_DropItems)
endfunction
function CreateNeutralPassiveBuildings takes nothing returns nothing
local player p=Player(PLAYER_NEUTRAL_PASSIVE)
local unit u
local integer unitID
local trigger t
local real life
set u=CreateUnit(p,'ngme',-3136.0,2432.0,270.000)
set u=CreateUnit(p,'ngme',-2368.0,-2752.0,270.000)
set u=CreateUnit(p,'ngme',1664.0,1280.0,270.000)
endfunction
function CreateNeutralPassive takes nothing returns nothing
local player p=Player(PLAYER_NEUTRAL_PASSIVE)
local unit u
local integer unitID
local trigger t
local real life
set u=CreateUnit(p,'nech',-2522.9,2907.4,218.459)
set u=CreateUnit(p,'nech',-2524.1,2752.7,283.445)
set u=CreateUnit(p,'nech',-2503.2,2606.9,47.506)
set u=CreateUnit(p,'nech',-2509.2,2466.7,289.202)
set u=CreateUnit(p,'nech',2510.0,2879.1,356.517)
set u=CreateUnit(p,'nech',2510.7,2719.8,261.713)
set u=CreateUnit(p,'nech',2511.5,2569.4,13.591)
set u=CreateUnit(p,'nech',2512.6,2424.2,226.160)
set u=CreateUnit(p,'nech',2714.7,2264.5,178.215)
set u=CreateUnit(p,'nech',2828.5,2243.5,226.237)
set u=CreateUnit(p,'nech',2969.6,2233.1,320.118)
set u=CreateUnit(p,'nech',3115.6,2233.1,53.055)
set u=CreateUnit(p,'nech',2747.5,-2910.8,49.363)
set u=CreateUnit(p,'nech',2897.3,-2910.8,260.021)
set u=CreateUnit(p,'nech',3036.6,-2914.3,244.497)
set u=CreateUnit(p,'nech',3159.8,-2917.8,273.117)
set u=CreateUnit(p,'nech',2520.5,-3126.1,257.429)
set u=CreateUnit(p,'nech',2526.5,-3258.6,291.410)
set u=CreateUnit(p,'nech',2522.5,-3378.9,9.954)
set u=CreateUnit(p,'nech',-2498.8,-3147.0,233.642)
set u=CreateUnit(p,'nech',-2485.1,-3288.3,281.182)
set u=CreateUnit(p,'nech',-2499.3,-3429.9,314.955)
set u=CreateUnit(p,'nech',-2694.9,-2933.5,315.317)
set u=CreateUnit(p,'nech',-2844.0,-2937.1,317.811)
set u=CreateUnit(p,'nech',-2993.3,-2937.1,71.919)
set u=CreateUnit(p,'nech',-3154.8,-2929.9,187.476)
set u=CreateUnit(p,'nech',-2709.7,1460.1,121.051)
set u=CreateUnit(p,'nech',-2867.4,1483.2,191.794)
set u=CreateUnit(p,'nech',-3014.1,1487.3,310.901)
set u=CreateUnit(p,'nech',-3156.8,1471.2,93.057)
set u=CreateUnit(p,'nech',-2540.5,1986.4,339.345)
set u=CreateUnit(p,'nech',-2521.5,1846.6,272.513)
set u=CreateUnit(p,'nech',-2523.5,1719.6,95.793)
set u=CreateUnit(p,'nech',1885.6,1966.7,342.410)
set u=CreateUnit(p,'nech',1887.4,1827.1,94.804)
set u=CreateUnit(p,'nech',1893.5,1660.8,196.068)
set u=CreateUnit(p,'nech',2057.2,1489.0,106.131)
set u=CreateUnit(p,'nech',2148.5,1489.0,162.811)
set u=CreateUnit(p,'nech',2253.4,1485.4,78.632)
set u=CreateUnit(p,'nech',2121.0,-2255.9,359.945)
set u=CreateUnit(p,'nech',2269.4,-2268.1,80.796)
set u=CreateUnit(p,'nech',1905.7,-2489.7,156.988)
set u=CreateUnit(p,'nech',1893.2,-2637.4,161.130)
set u=CreateUnit(p,'nech',-1872.4,-2504.1,58.669)
set u=CreateUnit(p,'nech',-1877.5,-2663.9,302.759)
set u=CreateUnit(p,'nech',-2262.4,-2272.8,335.346)
set u=CreateUnit(p,'nech',-2107.2,-2280.5,307.714)
set u=CreateUnit(p,'nech',-2252.5,630.5,85.597)
set u=CreateUnit(p,'nech',-2098.1,658.0,184.082)
set u=CreateUnit(p,'nech',-1750.0,1097.2,190.003)
set u=CreateUnit(p,'nech',1270.6,1071.9,335.423)
set u=CreateUnit(p,'nech',1463.9,828.3,25.324)
set u=CreateUnit(p,'nech',1470.0,-1613.5,139.487)
set u=CreateUnit(p,'nech',1240.8,-1876.2,198.177)
set u=CreateUnit(p,'nech',-1222.7,-1853.2,123.424)
set u=CreateUnit(p,'nech',-1473.2,-1612.6,237.872)
set u=CreateUnit(p,'nech',-1475.3,181.6,144.914)
set u=CreateUnit(p,'nech',-1246.7,438.0,269.646)
set u=CreateUnit(p,'nech',607.6,414.7,304.418)
set u=CreateUnit(p,'nech',820.7,203.9,299.705)
set u=CreateUnit(p,'nech',22.4,-1144.5,321.063)
set u=CreateUnit(p,'nech',36.3,-1310.2,135.630)
set u=CreateUnit(p,'nech',-1778.4,3012.1,286.653)
set u=CreateUnit(p,'nech',-916.3,2584.0,106.977)
set u=CreateUnit(p,'nech',-357.0,2994.6,152.220)
set u=CreateUnit(p,'nech',-162.5,2356.7,269.701)
set u=CreateUnit(p,'nech',253.7,2581.1,10.053)
set u=CreateUnit(p,'nech',813.0,2346.4,297.420)
set u=CreateUnit(p,'nech',1486.9,2971.2,123.578)
set u=CreateUnit(p,'nech',1977.2,2407.0,270.107)
set u=CreateUnit(p,'nech',2645.8,1551.4,224.271)
set u=CreateUnit(p,'nech',3148.8,737.1,236.697)
set u=CreateUnit(p,'nech',2770.4,-63.1,331.874)
set u=CreateUnit(p,'nech',3043.5,-1001.3,227.435)
set u=CreateUnit(p,'nech',2668.4,-1985.3,275.051)
set u=CreateUnit(p,'nech',1886.8,-3215.3,118.151)
set u=CreateUnit(p,'nech',889.6,-3369.4,61.404)
set u=CreateUnit(p,'nech',387.8,-3030.3,280.929)
set u=CreateUnit(p,'nech',-112.5,-3530.4,249.145)
set u=CreateUnit(p,'nech',-976.6,-3212.8,42.650)
set u=CreateUnit(p,'nech',-1699.9,-3066.1,35.091)
set u=CreateUnit(p,'nech',-1648.4,-3528.8,324.205)
set u=CreateUnit(p,'nech',-3219.9,-2287.4,103.769)
set u=CreateUnit(p,'nech',-2789.6,-1545.4,263.669)
set u=CreateUnit(p,'nech',-3096.7,-859.0,86.905)
set u=CreateUnit(p,'nech',-2767.7,-81.3,225.622)
set u=CreateUnit(p,'nech',-3153.8,185.9,124.776)
set u=CreateUnit(p,'nech',-2884.6,1014.5,227.446)
set u=CreateUnit(p,'nech',-2051.6,1805.5,299.057)
set u=CreateUnit(p,'nech',-1293.3,1813.4,196.815)
set u=CreateUnit(p,'nech',-828.4,2109.0,88.640)
set u=CreateUnit(p,'nech',-420.0,1541.5,142.750)
set u=CreateUnit(p,'nech',317.4,1936.0,96.254)
set u=CreateUnit(p,'nech',1120.5,1696.2,208.747)
set u=CreateUnit(p,'nech',2314.0,940.3,305.407)
set u=CreateUnit(p,'nech',2039.7,131.5,298.112)
set u=CreateUnit(p,'nech',2261.4,-384.7,194.497)
set u=CreateUnit(p,'nech',2057.9,-1348.1,200.825)
set u=CreateUnit(p,'nech',1410.6,-2577.7,60.262)
set u=CreateUnit(p,'nech',580.1,-2629.3,132.279)
set u=CreateUnit(p,'nech',-567.6,-2389.2,65.481)
set u=CreateUnit(p,'nech',-1291.5,-2743.5,136.531)
set u=CreateUnit(p,'nech',-2169.5,-1785.1,129.412)
set u=CreateUnit(p,'nech',-2316.9,-885.9,167.898)
set u=CreateUnit(p,'nech',-1983.5,-279.4,308.066)
set u=CreateUnit(p,'nech',-1128.2,1093.5,223.623)
set u=CreateUnit(p,'nech',-199.7,920.1,49.814)
set u=CreateUnit(p,'nech',550.4,1296.1,41.980)
set u=CreateUnit(p,'nech',1303.9,25.2,52.549)
set u=CreateUnit(p,'nech',1669.5,-726.1,193.398)
set u=CreateUnit(p,'nech',599.6,-1721.0,295.904)
set u=CreateUnit(p,'nech',-424.1,-2050.9,64.206)
set u=CreateUnit(p,'nech',-1706.9,-1115.0,308.967)
set u=CreateUnit(p,'nech',-1435.6,-396.1,161.702)
set u=CreateUnit(p,'nech',-813.8,553.7,268.986)
set u=CreateUnit(p,'nech',-10.6,178.5,12.624)
set u=CreateUnit(p,'nech',1047.9,-209.8,184.719)
set u=CreateUnit(p,'nech',588.1,-902.0,158.603)
set u=CreateUnit(p,'nech',1034.4,-1386.0,80.499)
endfunction
function CreatePlayerBuildings takes nothing returns nothing
endfunction
function CreatePlayerUnits takes nothing returns nothing
call CreateUnitsForPlayer0()
call CreateUnitsForPlayer1()
call CreateUnitsForPlayer2()
call CreateUnitsForPlayer3()
call CreateUnitsForPlayer4()
call CreateUnitsForPlayer5()
call CreateUnitsForPlayer6()
call CreateUnitsForPlayer7()
call CreateUnitsForPlayer8()
call CreateUnitsForPlayer9()
call CreateUnitsForPlayer10()
call CreateUnitsForPlayer11()
endfunction
function CreateAllUnits takes nothing returns nothing
call CreateNeutralPassiveBuildings()
call CreatePlayerBuildings()
call CreateNeutralPassive()
call CreatePlayerUnits()
endfunction
function CreateRegions takes nothing returns nothing
local weathereffect we
set gg_rct_Wolf_Area_One=Rect(-2400.0,2240.0,2368.0,3072.0)
set gg_rct_Wolf_Area_Two=Rect(2496.0,-2752.0,3360.0,2112.0)
set gg_rct_Wofl_Area_Three=Rect(-2368.0,-3616.0,2368.0,-2880.0)
set gg_rct_Wolf_Area_Four=Rect(-3328.0,-2752.0,-2528.0,1344.0)
set gg_rct_Wofl_Area_Five=Rect(-2368.0,1440.0,1728.0,2208.0)
set gg_rct_Wolf_Area_Six=Rect(1888.0,-2080.0,2464.0,1344.0)
set gg_rct_Wolf_Area_Seven=Rect(-1728.0,-2848.0,1728.0,-2272.0)
set gg_rct_Wolf_Area_Eight=Rect(-2528.0,-2112.0,-1856.0,576.0)
set gg_rct_Wofl_Area_Nine=Rect(-1344.0,768.0,1120.0,1312.0)
set gg_rct_Wolf_Area_Ten=Rect(1216.0,-1504.0,1728.0,704.0)
set gg_rct_Wofl_Area_Eleven=Rect(-1120.0,-2144.0,1120.0,-1632.0)
set gg_rct_Wolf_Area_Twelve=Rect(-1728.0,-1504.0,-1216.0,64.0)
set gg_rct_Wolf_Area_Thirteen=Rect(-1120.0,192.0,480.0,672.0)
set gg_rct_Wolf_Area_Fourteen=Rect(576.0,-928.0,1056.0,64.0)
set gg_rct_Wolf_Area_Fifteen=Rect(96.0,-1504.0,1056.0,-992.0)
set gg_rct_Next_Round=Rect(-224.0,-1440.0,-192.0,-960.0)
set gg_rct_Kitty_Start=Rect(-2976.0,2272.0,-2592.0,3040.0)
set gg_rct_Red_Revive=Rect(-2944.0,2880.0,-2816.0,2976.0)
set gg_rct_Blue_Revive=Rect(-2944.0,2752.0,-2816.0,2848.0)
set gg_rct_Teal_Revive=Rect(-2944.0,2624.0,-2816.0,2720.0)
set gg_rct_Purple_Revive=Rect(-2944.0,2464.0,-2816.0,2560.0)
set gg_rct_Orange_Revive=Rect(-2944.0,2336.0,-2848.0,2432.0)
set gg_rct_Yellow_Revive=Rect(-2784.0,2880.0,-2688.0,2976.0)
set gg_rct_Green_Revive=Rect(-2784.0,2752.0,-2688.0,2848.0)
set gg_rct_Pink_Revive=Rect(-2784.0,2624.0,-2688.0,2688.0)
set gg_rct_Gray_Revive=Rect(-2784.0,2464.0,-2688.0,2560.0)
set gg_rct_Light_Blue_Revive=Rect(-2784.0,2336.0,-2688.0,2432.0)
set gg_rct_Dark_Green_Revive=Rect(-3104.0,2624.0,-2976.0,2720.0)
set gg_rct_SideGuardTop1=Rect(-2496.0,3008.0,2496.0,3040.0)
set gg_rct_SideGuardTop2=Rect(-2496.0,2336.0,2496.0,2368.0)
set gg_rct_SideGuardTop3=Rect(-2496.0,2112.0,1856.0,2144.0)
set gg_rct_SideGuardTop4=Rect(-2496.0,1568.0,1856.0,1600.0)
set gg_rct_SideGuardTop5=Rect(-1728.0,1216.0,1216.0,1248.0)
set gg_rct_SideGuardTop6=Rect(-1728.0,928.0,1216.0,960.0)
set gg_rct_SideGuardTop7=Rect(-1216.0,576.0,576.0,608.0)
set gg_rct_SideGuardTop8=Rect(-1216.0,288.0,576.0,320.0)
set gg_rct_SideGuardBottom8=Rect(64.0,-1088.0,672.0,-1056.0)
set gg_rct_SideGuardBottom7=Rect(64.0,-1376.0,992.0,-1344.0)
set gg_rct_SideGuardBottom6=Rect(-1216.0,-1728.0,1216.0,-1696.0)
set gg_rct_SideGuardBottom5=Rect(-1216.0,-2016.0,1216.0,-1984.0)
set gg_rct_SideGuardBottom4=Rect(-1856.0,-2368.0,1856.0,-2336.0)
set gg_rct_SideGuardBottom3=Rect(-1856.0,-2784.0,1856.0,-2752.0)
set gg_rct_SideGuardBottom2=Rect(-2496.0,-3008.0,2496.0,-2976.0)
set gg_rct_SideGuardBottom1=Rect(-2496.0,-3552.0,2496.0,-3520.0)
set gg_rct_SideGuardRight1=Rect(3264.0,-2880.0,3296.0,2240.0)
set gg_rct_SideGuardRight2=Rect(2560.0,-2880.0,2592.0,2240.0)
set gg_rct_SideGuardRight3=Rect(2368.0,-2240.0,2400.0,1472.0)
set gg_rct_SideGuardRight4=Rect(1920.0,-2240.0,1952.0,1472.0)
set gg_rct_SideGuardRight5=Rect(1600.0,-1600.0,1632.0,832.0)
set gg_rct_SideGuardRight6=Rect(1280.0,-1600.0,1312.0,832.0)
set gg_rct_SideGuardRight7=Rect(960.0,-1376.0,992.0,192.0)
set gg_rct_SideGuardRight8=Rect(640.0,-1088.0,672.0,192.0)
set gg_rct_SideGuardLeft8=Rect(-1344.0,-1600.0,-1312.0,192.0)
set gg_rct_SideGuardLeft7=Rect(-1664.0,-1600.0,-1632.0,192.0)
set gg_rct_SideGuardLeft6=Rect(-1984.0,-2240.0,-1952.0,704.0)
set gg_rct_SideGuardLeft5=Rect(-2432.0,-2240.0,-2400.0,704.0)
set gg_rct_SideGuardLeft4=Rect(-2624.0,-2880.0,-2592.0,1472.0)
set gg_rct_SideGuardLeft3=Rect(-3296.0,-2880.0,-3264.0,1472.0)
set gg_rct_Lvl1=Rect(2560.0,2304.0,3264.0,3008.0)
set gg_rct_Lvl2=Rect(2560.0,-3520.0,3264.0,-2944.0)
set gg_rct_Lvl3=Rect(-3264.0,-3520.0,-2560.0,-2944.0)
set gg_rct_Lvl4=Rect(-3264.0,1536.0,-2560.0,2112.0)
set gg_rct_Lvl5=Rect(1920.0,1536.0,2368.0,2112.0)
set gg_rct_Lvl6=Rect(1920.0,-2752.0,2368.0,-2304.0)
set gg_rct_Lvl7=Rect(-2368.0,-2752.0,-1920.0,-2304.0)
set gg_rct_Lvl8=Rect(-2368.0,768.0,-1792.0,1216.0)
set gg_rct_Lvl9=Rect(1280.0,896.0,1600.0,1216.0)
set gg_rct_Lvl10=Rect(1280.0,-1984.0,1600.0,-1664.0)
set gg_rct_Lvl11=Rect(-1600.0,-1984.0,-1280.0,-1664.0)
set gg_rct_Lvl12=Rect(-1600.0,256.0,-1280.0,448.0)
set gg_rct_Lvl13=Rect(640.0,256.0,960.0,576.0)
set gg_rct_Lvl14=Rect(-192.0,-1344.0,0.0,-1088.0)
set gg_rct_Leap1=Rect(-3296.0,2272.0,3328.0,3040.0)
set gg_rct_Leap2=Rect(2528.0,-3584.0,3296.0,3040.0)
set gg_rct_Leap3=Rect(-3328.0,-3584.0,3296.0,-2912.0)
set gg_rct_Leap4=Rect(-3328.0,-3584.0,-2528.0,2176.0)
set gg_rct_Leap5=Rect(-3328.0,1472.0,2464.0,2208.0)
set gg_rct_Leap6=Rect(1856.0,-2880.0,2464.0,2176.0)
set gg_rct_Leap7=Rect(-2464.0,-2912.0,2464.0,-2272.0)
set gg_rct_Leap8=Rect(-2464.0,-2880.0,-1888.0,1312.0)
set gg_rct_Leap9=Rect(-2464.0,832.0,1696.0,1312.0)
set gg_rct_Leap10=Rect(1248.0,-2112.0,1696.0,1312.0)
set gg_rct_Leap11=Rect(-1696.0,-2144.0,1696.0,-1632.0)
set gg_rct_Leap12=Rect(-1696.0,-2144.0,-1216.0,672.0)
set gg_rct_Leap13=Rect(-1696.0,192.0,1056.0,672.0)
set gg_rct_Leap14=Rect(576.0,-1504.0,1056.0,672.0)
endfunction
function Trig_Kick2_Actions takes nothing returns nothing
call CustomDefeatBJ(Player(1),"TRIGSTR_369")
endfunction
function InitTrig_Kick2 takes nothing returns nothing
set gg_trg_Kick2=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_Kick2,Player(0),"-kich p2",true)
call TriggerAddAction(gg_trg_Kick2,function Trig_Kick2_Actions)
endfunction
function Trig_Kick3_Actions takes nothing returns nothing
call CustomDefeatBJ(Player(2),"TRIGSTR_370")
endfunction
function InitTrig_Kick3 takes nothing returns nothing
set gg_trg_Kick3=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_Kick3,Player(0),"-kich p3",true)
call TriggerAddAction(gg_trg_Kick3,function Trig_Kick3_Actions)
endfunction
function Trig_Kick4_Actions takes nothing returns nothing
call CustomDefeatBJ(Player(3),"TRIGSTR_371")
endfunction
function InitTrig_Kick4 takes nothing returns nothing
set gg_trg_Kick4=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_Kick4,Player(0),"-kich p4",true)
call TriggerAddAction(gg_trg_Kick4,function Trig_Kick4_Actions)
endfunction
function Trig_Kick5_Actions takes nothing returns nothing
call CustomDefeatBJ(Player(4),"TRIGSTR_372")
endfunction
function InitTrig_Kick5 takes nothing returns nothing
set gg_trg_Kick5=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_Kick5,Player(0),"-kich p5",true)
call TriggerAddAction(gg_trg_Kick5,function Trig_Kick5_Actions)
endfunction
function Trig_Kich6_Actions takes nothing returns nothing
call CustomDefeatBJ(Player(5),"TRIGSTR_373")
endfunction
function InitTrig_Kich6 takes nothing returns nothing
set gg_trg_Kich6=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_Kich6,Player(0),"-kich p6",true)
call TriggerAddAction(gg_trg_Kich6,function Trig_Kich6_Actions)
endfunction
function Trig_Kick7_Actions takes nothing returns nothing
call CustomDefeatBJ(Player(6),"TRIGSTR_374")
endfunction
function InitTrig_Kick7 takes nothing returns nothing
set gg_trg_Kick7=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_Kick7,Player(0),"-kich p7",true)
call TriggerAddAction(gg_trg_Kick7,function Trig_Kick7_Actions)
endfunction
function Trig_Kick8_Actions takes nothing returns nothing
call CustomDefeatBJ(Player(7),"TRIGSTR_375")
endfunction
function InitTrig_Kick8 takes nothing returns nothing
set gg_trg_Kick8=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_Kick8,Player(0),"-kich p8",true)
call TriggerAddAction(gg_trg_Kick8,function Trig_Kick8_Actions)
endfunction
function Trig_Kick9_Actions takes nothing returns nothing
call CustomDefeatBJ(Player(8),"TRIGSTR_376")
endfunction
function InitTrig_Kick9 takes nothing returns nothing
set gg_trg_Kick9=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_Kick9,Player(0),"-kich p9",true)
call TriggerAddAction(gg_trg_Kick9,function Trig_Kick9_Actions)
endfunction
function Trig_Kick10_Actions takes nothing returns nothing
call CustomDefeatBJ(Player(9),"TRIGSTR_377")
endfunction
function InitTrig_Kick10 takes nothing returns nothing
set gg_trg_Kick10=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_Kick10,Player(0),"-kich p10",true)
call TriggerAddAction(gg_trg_Kick10,function Trig_Kick10_Actions)
endfunction
function Trig_Kick11_Actions takes nothing returns nothing
call CustomDefeatBJ(Player(10),"TRIGSTR_379")
endfunction
function InitTrig_Kick11 takes nothing returns nothing
set gg_trg_Kick11=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_Kick11,Player(0),"-kich p11",true)
call TriggerAddAction(gg_trg_Kick11,function Trig_Kick11_Actions)
endfunction
function Trig_SATART_Actions takes nothing returns nothing
call SetSkyModel("Environment\\Sky\\BlizzardSky\\BlizzardSky.mdl")
set udg_REALSPD1=1.00
set udg_REALSPD10=1.00
set udg_REALSPD11=1.00
set udg_REALSPD2=1.00
set udg_REALSPD3=1.00
set udg_REALSPD4=1.00
set udg_REALSPD5=1.00
set udg_REALSPD6=1.00
set udg_REALSPD7=1.00
set udg_REALSPD8=1.00
set udg_REALSPD9=1.00
endfunction
function InitTrig_SATART takes nothing returns nothing
set gg_trg_SATART=CreateTrigger()
call TriggerAddAction(gg_trg_SATART,function Trig_SATART_Actions)
endfunction
function Trig_Game_End_Dbl_Chk_Func002002001 takes nothing returns boolean
return(IsUnitAliveBJ(GetEnumUnit())==true)
endfunction
function Trig_Game_End_Dbl_Chk_Func002002 takes nothing returns nothing
if(Trig_Game_End_Dbl_Chk_Func002002001())then
set udg_GameOver=false
else
call DoNothing()
endif
endfunction
function Trig_Game_End_Dbl_Chk_Func003001 takes nothing returns boolean
return(udg_GameOver==true)
endfunction
function Trig_Game_End_Dbl_Chk_Actions takes nothing returns nothing
set udg_GameOver=true
call ForGroupBJ(GetUnitsOfTypeIdAll('E000'),function Trig_Game_End_Dbl_Chk_Func002002)
if(Trig_Game_End_Dbl_Chk_Func003001())then
call TriggerExecute(gg_trg_Game_Over)
else
call DoNothing()
endif
endfunction
function InitTrig_Game_End_Dbl_Chk takes nothing returns nothing
set gg_trg_Game_End_Dbl_Chk=CreateTrigger()
call TriggerRegisterTimerEventPeriodic(gg_trg_Game_End_Dbl_Chk,5.00)
call TriggerAddAction(gg_trg_Game_End_Dbl_Chk,function Trig_Game_End_Dbl_Chk_Actions)
endfunction
function Trig_Leaderboard_Func001001001 takes nothing returns boolean
return(GetPlayerSlotState(GetFilterPlayer())==PLAYER_SLOT_STATE_PLAYING)
endfunction
function Trig_Leaderboard_Func005001001 takes nothing returns boolean
return(GetPlayerSlotState(GetFilterPlayer())==PLAYER_SLOT_STATE_PLAYING)
endfunction
function Trig_Leaderboard_Func005002 takes nothing returns nothing
call LeaderboardAddItemBJ(GetEnumPlayer(),GetLastCreatedLeaderboard(),GetPlayerName(GetEnumPlayer()),0)
endfunction
function Trig_Leaderboard_Actions takes nothing returns nothing
call CreateLeaderboardBJ(GetPlayersMatching(Condition(function Trig_Leaderboard_Func001001001)),"TRIGSTR_021")
call LeaderboardAddItemBJ(Player(PLAYER_NEUTRAL_PASSIVE),GetLastCreatedLeaderboard(),("Map by vietnghiavnnPoint"),500)
call LeaderboardSetPlayerItemStyleBJ(Player(PLAYER_NEUTRAL_PASSIVE),GetLastCreatedLeaderboard(),true,false,false)
call LeaderboardSetPlayerItemLabelColorBJ(Player(PLAYER_NEUTRAL_PASSIVE),GetLastCreatedLeaderboard(),100,100,100,0)
call ForForce(GetPlayersMatching(Condition(function Trig_Leaderboard_Func005001001)),function Trig_Leaderboard_Func005002)
call LeaderboardRemovePlayerItemBJ(Player(11),GetLastCreatedLeaderboard())
endfunction
function InitTrig_Leaderboard takes nothing returns nothing
set gg_trg_Leaderboard=CreateTrigger()
call TriggerRegisterTimerEventSingle(gg_trg_Leaderboard,2.00)
call TriggerAddAction(gg_trg_Leaderboard,function Trig_Leaderboard_Actions)
endfunction
function Trig_Set_level_Actions takes nothing returns nothing
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=11
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call CreateNUnitsAtLoc(1,'nwwg',Player(11),GetRandomLocInRect(gg_rct_Wolf_Area_One),GetRandomDirectionDeg())
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=11
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call CreateNUnitsAtLoc(1,'nwwg',Player(11),GetRandomLocInRect(gg_rct_Wofl_Area_Three),GetRandomDirectionDeg())
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=11
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call CreateNUnitsAtLoc(1,'nwwg',Player(11),GetRandomLocInRect(gg_rct_Wofl_Area_Five),GetRandomDirectionDeg())
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=11
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call CreateNUnitsAtLoc(1,'nwwg',Player(11),GetRandomLocInRect(gg_rct_Wolf_Area_Seven),GetRandomDirectionDeg())
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=3
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call CreateNUnitsAtLoc(1,'nwwg',Player(11),GetRandomLocInRect(gg_rct_Wofl_Area_Nine),GetRandomDirectionDeg())
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=3
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call CreateNUnitsAtLoc(1,'nwwg',Player(11),GetRandomLocInRect(gg_rct_Wofl_Area_Eleven),GetRandomDirectionDeg())
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=3
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call CreateNUnitsAtLoc(1,'nwwg',Player(11),GetRandomLocInRect(gg_rct_Wolf_Area_Thirteen),GetRandomDirectionDeg())
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=3
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call CreateNUnitsAtLoc(1,'nwwg',Player(11),GetRandomLocInRect(gg_rct_Wolf_Area_Fifteen),GetRandomDirectionDeg())
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=3
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call CreateNUnitsAtLoc(1,'nwwg',Player(PLAYER_NEUTRAL_PASSIVE),GetRandomLocInRect(gg_rct_Wolf_Area_Two),GetRandomDirectionDeg())
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=2
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call CreateNUnitsAtLoc(1,'nwwg',Player(PLAYER_NEUTRAL_PASSIVE),GetRectCenter(gg_rct_Wolf_Area_Four),GetRandomDirectionDeg())
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=2
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call CreateNUnitsAtLoc(1,'nwwg',Player(PLAYER_NEUTRAL_PASSIVE),GetRectCenter(gg_rct_Wolf_Area_Six),GetRandomDirectionDeg())
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=2
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call CreateNUnitsAtLoc(1,'nwwg',Player(PLAYER_NEUTRAL_PASSIVE),GetRectCenter(gg_rct_Wolf_Area_Eight),GetRandomDirectionDeg())
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=2
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call CreateNUnitsAtLoc(1,'nwwg',Player(PLAYER_NEUTRAL_PASSIVE),GetRectCenter(gg_rct_Wolf_Area_Ten),GetRandomDirectionDeg())
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=2
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call CreateNUnitsAtLoc(1,'nwwg',Player(PLAYER_NEUTRAL_PASSIVE),GetRectCenter(gg_rct_Wolf_Area_Twelve),GetRandomDirectionDeg())
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction
function InitTrig_Set_level takes nothing returns nothing
set gg_trg_Set_level=CreateTrigger()
call TriggerAddAction(gg_trg_Set_level,function Trig_Set_level_Actions)
endfunction
function Trig_Trigger_Next_Round_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='E000'))then
return false
endif
return true
endfunction
function Trig_Trigger_Next_Round_Func005002 takes nothing returns nothing
call AdjustPlayerStateBJ(100,GetEnumPlayer(),PLAYER_STATE_RESOURCE_GOLD)
endfunction
function Trig_Trigger_Next_Round_Func009001 takes nothing returns boolean
return(udg_Round==1)
endfunction
function Trig_Trigger_Next_Round_Func010001 takes nothing returns boolean
return(udg_Round==2)
endfunction
function Trig_Trigger_Next_Round_Func011001 takes nothing returns boolean
return(udg_Round==3)
endfunction
function Trig_Trigger_Next_Round_Func012002 takes nothing returns nothing
call PanCameraToTimedLocForPlayer(GetEnumPlayer(),GetRectCenter(gg_rct_Kitty_Start),5.00)
endfunction
function Trig_Trigger_Next_Round_Actions takes nothing returns nothing
call PauseAllUnitsBJ(true)
call AddHeroXPSwapped(300,GetTriggerUnit(),true)
call AdjustPlayerStateBJ(200,GetOwningPlayer(GetTriggerUnit()),PLAYER_STATE_RESOURCE_GOLD)
call ForForce(GetPlayersAll(),function Trig_Trigger_Next_Round_Func005002)
set udg_Score[GetConvertedPlayerId(GetOwningPlayer(GetEnteringUnit()))]=(udg_Score[GetConvertedPlayerId(GetOwningPlayer(GetEnteringUnit()))]+5)
call LeaderboardSetPlayerItemValueBJ(GetOwningPlayer(GetEnteringUnit()),GetLastCreatedLeaderboard(),udg_Score[GetConvertedPlayerId(GetOwningPlayer(GetEnteringUnit()))])
call LeaderboardSortItemsBJ(GetLastCreatedLeaderboard(),bj_SORTTYPE_SORTBYVALUE,false)
if(Trig_Trigger_Next_Round_Func009001())then
call DisplayTextToForce(GetPlayersAll(),"TRIGSTR_293")
else
call DoNothing()
endif
if(Trig_Trigger_Next_Round_Func010001())then
call DisplayTextToForce(GetPlayersAll(),"TRIGSTR_294")
else
call DoNothing()
endif
if(Trig_Trigger_Next_Round_Func011001())then
call DisplayTextToForce(GetPlayersAll(),"TRIGSTR_295")
else
call DoNothing()
endif
call ForForce(GetPlayersAll(),function Trig_Trigger_Next_Round_Func012002)
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=5
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call DisplayTimedTextToForce(GetPlayersAll(),6.00,"TRIGSTR_027")
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call ExplodeUnitBJ(GetTriggerUnit())
call TriggerExecute(gg_trg_Next_Round)
set udg_Round=(udg_Round+1)
endfunction
function InitTrig_Trigger_Next_Round takes nothing returns nothing
set gg_trg_Trigger_Next_Round=CreateTrigger()
call TriggerRegisterEnterRectSimple(gg_trg_Trigger_Next_Round,gg_rct_Next_Round)
call TriggerAddCondition(gg_trg_Trigger_Next_Round,Condition(function Trig_Trigger_Next_Round_Conditions))
call TriggerAddAction(gg_trg_Trigger_Next_Round,function Trig_Trigger_Next_Round_Actions)
endfunction
function Trig_Win_Conditions takes nothing returns boolean
if(not(udg_Round==5))then
return false
endif
return true
endfunction
function Trig_Win_Func003002 takes nothing returns nothing
call CustomVictoryBJ(GetEnumPlayer(),true,false)
endfunction
function Trig_Win_Actions takes nothing returns nothing
call DisplayTimedTextToForce(GetPlayersAll(),5.00,"TRIGSTR_136")
call TriggerSleepAction(5.00)
call ForForce(GetPlayersByMapControl(MAP_CONTROL_USER),function Trig_Win_Func003002)
endfunction
function InitTrig_Win takes nothing returns nothing
set gg_trg_Win=CreateTrigger()
call TriggerAddCondition(gg_trg_Win,Condition(function Trig_Win_Conditions))
call TriggerAddAction(gg_trg_Win,function Trig_Win_Actions)
endfunction
function Trig_Remove_Func001001001 takes nothing returns boolean
return(GetPlayerSlotState(GetFilterPlayer())==PLAYER_SLOT_STATE_PLAYING)
endfunction
function Trig_Remove_Func001002001 takes nothing returns boolean
return(GetPlayerColor(GetEnumPlayer())==PLAYER_COLOR_RED)
endfunction
function Trig_Remove_Func001002 takes nothing returns nothing
if(Trig_Remove_Func001002001())then
set udg_ColorText[GetConvertedPlayerId(GetEnumPlayer())]="|cffff0800"
else
call DoNothing()
endif
endfunction
function Trig_Remove_Func002001001 takes nothing returns boolean
return(GetPlayerSlotState(GetFilterPlayer())==PLAYER_SLOT_STATE_PLAYING)
endfunction
function Trig_Remove_Func002002001 takes nothing returns boolean
return(GetPlayerColor(GetEnumPlayer())==PLAYER_COLOR_BLUE)
endfunction
function Trig_Remove_Func002002 takes nothing returns nothing
if(Trig_Remove_Func002002001())then
set udg_ColorText[GetConvertedPlayerId(GetEnumPlayer())]="|cff0044FF"
else
call DoNothing()
endif
endfunction
function Trig_Remove_Func003001001 takes nothing returns boolean
return(GetPlayerSlotState(GetFilterPlayer())==PLAYER_SLOT_STATE_PLAYING)
endfunction
function Trig_Remove_Func003002001 takes nothing returns boolean
return(GetPlayerColor(GetEnumPlayer())==PLAYER_COLOR_CYAN)
endfunction
function Trig_Remove_Func003002 takes nothing returns nothing
if(Trig_Remove_Func003002001())then
set udg_ColorText[GetConvertedPlayerId(GetEnumPlayer())]="|cff28e8c0"
else
call DoNothing()
endif
endfunction
function Trig_Remove_Func004001001 takes nothing returns boolean
return(GetPlayerSlotState(GetFilterPlayer())==PLAYER_SLOT_STATE_PLAYING)
endfunction
function Trig_Remove_Func004002001 takes nothing returns boolean
return(GetPlayerColor(GetEnumPlayer())==PLAYER_COLOR_PURPLE)
endfunction
function Trig_Remove_Func004002 takes nothing returns nothing
if(Trig_Remove_Func004002001())then
set udg_ColorText[GetConvertedPlayerId(GetEnumPlayer())]="|cff600088"
else
call DoNothing()
endif
endfunction
function Trig_Remove_Func005001001 takes nothing returns boolean
return(GetPlayerSlotState(GetFilterPlayer())==PLAYER_SLOT_STATE_PLAYING)
endfunction
function Trig_Remove_Func005002001 takes nothing returns boolean
return(GetPlayerColor(GetEnumPlayer())==PLAYER_COLOR_YELLOW)
endfunction
function Trig_Remove_Func005002 takes nothing returns nothing
if(Trig_Remove_Func005002001())then
set udg_ColorText[GetConvertedPlayerId(GetEnumPlayer())]="|cffFFFF00"
else
call DoNothing()
endif
endfunction
function Trig_Remove_Func006001001 takes nothing returns boolean
return(GetPlayerSlotState(GetFilterPlayer())==PLAYER_SLOT_STATE_PLAYING)
endfunction
function Trig_Remove_Func006002001 takes nothing returns boolean
return(GetPlayerColor(GetEnumPlayer())==PLAYER_COLOR_ORANGE)
endfunction
function Trig_Remove_Func006002 takes nothing returns nothing
if(Trig_Remove_Func006002001())then
set udg_ColorText[GetConvertedPlayerId(GetEnumPlayer())]="|cffFF8C18"
else
call DoNothing()
endif
endfunction
function Trig_Remove_Func007001001 takes nothing returns boolean
return(GetPlayerSlotState(GetFilterPlayer())==PLAYER_SLOT_STATE_PLAYING)
endfunction
function Trig_Remove_Func007002001 takes nothing returns boolean
return(GetPlayerColor(GetEnumPlayer())==PLAYER_COLOR_GREEN)
endfunction
function Trig_Remove_Func007002 takes nothing returns nothing
if(Trig_Remove_Func007002001())then
set udg_ColorText[GetConvertedPlayerId(GetEnumPlayer())]="|cff28C400"
else
call DoNothing()
endif
endfunction
function Trig_Remove_Func008001001 takes nothing returns boolean
return(GetPlayerSlotState(GetFilterPlayer())==PLAYER_SLOT_STATE_PLAYING)
endfunction
function Trig_Remove_Func008002001 takes nothing returns boolean
return(GetPlayerColor(GetEnumPlayer())==PLAYER_COLOR_PINK)
endfunction
function Trig_Remove_Func008002 takes nothing returns nothing
if(Trig_Remove_Func008002001())then
set udg_ColorText[GetConvertedPlayerId(GetEnumPlayer())]="|cffE85CB8"
else
call DoNothing()
endif
endfunction
function Trig_Remove_Func009001001 takes nothing returns boolean
return(GetPlayerSlotState(GetFilterPlayer())==PLAYER_SLOT_STATE_PLAYING)
endfunction
function Trig_Remove_Func009002001 takes nothing returns boolean
return(GetPlayerColor(GetEnumPlayer())==PLAYER_COLOR_LIGHT_GRAY)
endfunction
function Trig_Remove_Func009002 takes nothing returns nothing
if(Trig_Remove_Func009002001())then
set udg_ColorText[GetConvertedPlayerId(GetEnumPlayer())]="|cff989898"
else
call DoNothing()
endif
endfunction
function Trig_Remove_Func010001001 takes nothing returns boolean
return(GetPlayerSlotState(GetFilterPlayer())==PLAYER_SLOT_STATE_PLAYING)
endfunction
function Trig_Remove_Func010002001 takes nothing returns boolean
return(GetPlayerColor(GetEnumPlayer())==PLAYER_COLOR_LIGHT_BLUE)
endfunction
function Trig_Remove_Func010002 takes nothing returns nothing
if(Trig_Remove_Func010002001())then
set udg_ColorText[GetConvertedPlayerId(GetEnumPlayer())]="|cff80C0F8"
else
call DoNothing()
endif
endfunction
function Trig_Remove_Func011001001 takes nothing returns boolean
return(GetPlayerSlotState(GetFilterPlayer())==PLAYER_SLOT_STATE_PLAYING)
endfunction
function Trig_Remove_Func011002001 takes nothing returns boolean
return(GetPlayerColor(GetEnumPlayer())==PLAYER_COLOR_AQUA)
endfunction
function Trig_Remove_Func011002 takes nothing returns nothing
if(Trig_Remove_Func011002001())then
set udg_ColorText[GetConvertedPlayerId(GetEnumPlayer())]="|cff186450"
else
call DoNothing()
endif
endfunction
function Trig_Remove_Func012001001 takes nothing returns boolean
return(GetPlayerSlotState(GetFilterPlayer())==PLAYER_SLOT_STATE_PLAYING)
endfunction
function Trig_Remove_Func012002001 takes nothing returns boolean
return(GetPlayerColor(GetEnumPlayer())==PLAYER_COLOR_BROWN)
endfunction
function Trig_Remove_Func012002 takes nothing returns nothing
if(Trig_Remove_Func012002001())then
set udg_ColorText[GetConvertedPlayerId(GetEnumPlayer())]="|cff583010"
else
call DoNothing()
endif
endfunction
function Trig_Remove_Actions takes nothing returns nothing
call ForForce(GetPlayersMatching(Condition(function Trig_Remove_Func001001001)),function Trig_Remove_Func001002)
call ForForce(GetPlayersMatching(Condition(function Trig_Remove_Func002001001)),function Trig_Remove_Func002002)
call ForForce(GetPlayersMatching(Condition(function Trig_Remove_Func003001001)),function Trig_Remove_Func003002)
call ForForce(GetPlayersMatching(Condition(function Trig_Remove_Func004001001)),function Trig_Remove_Func004002)
call ForForce(GetPlayersMatching(Condition(function Trig_Remove_Func005001001)),function Trig_Remove_Func005002)
call ForForce(GetPlayersMatching(Condition(function Trig_Remove_Func006001001)),function Trig_Remove_Func006002)
call ForForce(GetPlayersMatching(Condition(function Trig_Remove_Func007001001)),function Trig_Remove_Func007002)
call ForForce(GetPlayersMatching(Condition(function Trig_Remove_Func008001001)),function Trig_Remove_Func008002)
call ForForce(GetPlayersMatching(Condition(function Trig_Remove_Func009001001)),function Trig_Remove_Func009002)
call ForForce(GetPlayersMatching(Condition(function Trig_Remove_Func010001001)),function Trig_Remove_Func010002)
call ForForce(GetPlayersMatching(Condition(function Trig_Remove_Func011001001)),function Trig_Remove_Func011002)
call ForForce(GetPlayersMatching(Condition(function Trig_Remove_Func012001001)),function Trig_Remove_Func012002)
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=11
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_Score[GetForLoopIndexA()]=0
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=11
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_Alive[GetForLoopIndexA()]=true
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction
function InitTrig_Remove takes nothing returns nothing
set gg_trg_Remove=CreateTrigger()
call TriggerRegisterTimerEventSingle(gg_trg_Remove,3.00)
call TriggerAddAction(gg_trg_Remove,function Trig_Remove_Actions)
endfunction
function Trig_Game_Over_Conditions takes nothing returns boolean
if(not(CountPlayersInForceBJ(udg_Players)==0))then
return false
endif
return true
endfunction
function Trig_Game_Over_Func003002 takes nothing returns nothing
call CustomDefeatBJ(GetEnumPlayer(),"TRIGSTR_305")
endfunction
function Trig_Game_Over_Actions takes nothing returns nothing
call QueuedTriggerClearInactiveBJ()
set udg_GameOver=true
call ForForce(udg_Losers,function Trig_Game_Over_Func003002)
call DisableTrigger(gg_trg_Game_End_Dbl_Chk)
call DisableTrigger(GetTriggeringTrigger())
call TriggerSleepAction(30.00)
endfunction
function InitTrig_Game_Over takes nothing returns nothing
set gg_trg_Game_Over=CreateTrigger()
call DisableTrigger(gg_trg_Game_Over)
call TriggerAddCondition(gg_trg_Game_Over,Condition(function Trig_Game_Over_Conditions))
call TriggerAddAction(gg_trg_Game_Over,function Trig_Game_Over_Actions)
endfunction
function Trig_Not_here_Func048001 takes nothing returns boolean
return(GetPlayerSlotState(Player(0))==PLAYER_SLOT_STATE_EMPTY)
endfunction
function Trig_Not_here_Func048002002 takes nothing returns nothing
call RemoveUnit(GetEnumUnit())
endfunction
function Trig_Not_here_Func049001 takes nothing returns boolean
return(GetPlayerSlotState(Player(1))==PLAYER_SLOT_STATE_EMPTY)
endfunction
function Trig_Not_here_Func049002002 takes nothing returns nothing
call RemoveUnit(GetEnumUnit())
endfunction
function Trig_Not_here_Func050001 takes nothing returns boolean
return(GetPlayerSlotState(Player(2))==PLAYER_SLOT_STATE_EMPTY)
endfunction
function Trig_Not_here_Func050002002 takes nothing returns nothing
call RemoveUnit(GetEnumUnit())
endfunction
function Trig_Not_here_Func051001 takes nothing returns boolean
return(GetPlayerSlotState(Player(3))==PLAYER_SLOT_STATE_EMPTY)
endfunction
function Trig_Not_here_Func051002002 takes nothing returns nothing
call RemoveUnit(GetEnumUnit())
endfunction
function Trig_Not_here_Func052001 takes nothing returns boolean
return(GetPlayerSlotState(Player(4))==PLAYER_SLOT_STATE_EMPTY)
endfunction
function Trig_Not_here_Func052002002 takes nothing returns nothing
call RemoveUnit(GetEnumUnit())
endfunction
function Trig_Not_here_Func053001 takes nothing returns boolean
return(GetPlayerSlotState(Player(5))==PLAYER_SLOT_STATE_EMPTY)
endfunction
function Trig_Not_here_Func053002002 takes nothing returns nothing
call RemoveUnit(GetEnumUnit())
endfunction
function Trig_Not_here_Func054001 takes nothing returns boolean
return(GetPlayerSlotState(Player(6))==PLAYER_SLOT_STATE_EMPTY)
endfunction
function Trig_Not_here_Func054002002 takes nothing returns nothing
call RemoveUnit(GetEnumUnit())
endfunction
function Trig_Not_here_Func055001 takes nothing returns boolean
return(GetPlayerSlotState(Player(7))==PLAYER_SLOT_STATE_EMPTY)
endfunction
function Trig_Not_here_Func055002002 takes nothing returns nothing
call RemoveUnit(GetEnumUnit())
endfunction
function Trig_Not_here_Func056001 takes nothing returns boolean
return(GetPlayerSlotState(Player(8))==PLAYER_SLOT_STATE_EMPTY)
endfunction
function Trig_Not_here_Func056002002 takes nothing returns nothing
call RemoveUnit(GetEnumUnit())
endfunction
function Trig_Not_here_Func057001 takes nothing returns boolean
return(GetPlayerSlotState(Player(9))==PLAYER_SLOT_STATE_EMPTY)
endfunction
function Trig_Not_here_Func057002002 takes nothing returns nothing
call RemoveUnit(GetEnumUnit())
endfunction
function Trig_Not_here_Func058001 takes nothing returns boolean
return(GetPlayerSlotState(Player(10))==PLAYER_SLOT_STATE_EMPTY)
endfunction
function Trig_Not_here_Func058002002 takes nothing returns nothing
call RemoveUnit(GetEnumUnit())
endfunction
function Trig_Not_here_Func061002 takes nothing returns nothing
call CreateFogModifierRectBJ(true,GetEnumPlayer(),FOG_OF_WAR_VISIBLE,GetEntireMapRect())
endfunction
function Trig_Not_here_Func063001001 takes nothing returns boolean
return(GetPlayerSlotState(GetFilterPlayer())==PLAYER_SLOT_STATE_PLAYING)
endfunction
function Trig_Not_here_Func063002 takes nothing returns nothing
call ForceAddPlayerSimple(GetEnumPlayer(),udg_Losers)
endfunction
function Trig_Not_here_Func064001001 takes nothing returns boolean
return(GetPlayerSlotState(GetFilterPlayer())==PLAYER_SLOT_STATE_PLAYING)
endfunction
function Trig_Not_here_Func064002 takes nothing returns nothing
call ForceAddPlayerSimple(GetEnumPlayer(),udg_Players)
endfunction
function Trig_Not_here_Func066002 takes nothing returns nothing
call ForceRemovePlayerSimple(GetEnumPlayer(),udg_Discos)
endfunction
function Trig_Not_here_Actions takes nothing returns nothing
set udg_kittyStartingPoints[1]=GetUnitLoc(gg_unit_E000_0001)
set udg_kittyStartingPoints[2]=GetUnitLoc(gg_unit_E000_0002)
set udg_kittyStartingPoints[3]=GetUnitLoc(gg_unit_E000_0003)
set udg_kittyStartingPoints[4]=GetUnitLoc(gg_unit_E000_0004)
set udg_kittyStartingPoints[5]=GetUnitLoc(gg_unit_E000_0005)
set udg_kittyStartingPoints[6]=GetUnitLoc(gg_unit_E000_0006)
set udg_kittyStartingPoints[7]=GetUnitLoc(gg_unit_E000_0007)
set udg_kittyStartingPoints[8]=GetUnitLoc(gg_unit_E000_0008)
set udg_kittyStartingPoints[9]=GetUnitLoc(gg_unit_E000_0009)
set udg_kittyStartingPoints[10]=GetUnitLoc(gg_unit_E000_0010)
set udg_kittyStartingPoints[11]=GetUnitLoc(gg_unit_E000_0011)
set udg_LeapRegions[1]=gg_rct_Leap1
set udg_LeapRegions[2]=gg_rct_Leap2
set udg_LeapRegions[3]=gg_rct_Leap3
set udg_LeapRegions[4]=gg_rct_Leap4
set udg_LeapRegions[5]=gg_rct_Leap5
set udg_LeapRegions[6]=gg_rct_Leap6
set udg_LeapRegions[7]=gg_rct_Leap7
set udg_LeapRegions[8]=gg_rct_Leap8
set udg_LeapRegions[9]=gg_rct_Leap9
set udg_LeapRegions[10]=gg_rct_Leap10
set udg_LeapRegions[11]=gg_rct_Leap11
set udg_LeapRegions[12]=gg_rct_Leap12
set udg_LeapRegions[13]=gg_rct_Leap13
set udg_LeapRegions[14]=gg_rct_Leap14
set udg_kittys[1]=gg_unit_E000_0001
set udg_kittys[2]=gg_unit_E000_0002
set udg_kittys[3]=gg_unit_E000_0003
set udg_kittys[4]=gg_unit_E000_0004
set udg_kittys[5]=gg_unit_E000_0005
set udg_kittys[6]=gg_unit_E000_0006
set udg_kittys[7]=gg_unit_E000_0007
set udg_kittys[8]=gg_unit_E000_0008
set udg_kittys[9]=gg_unit_E000_0009
set udg_kittys[10]=gg_unit_E000_0010
set udg_kittys[11]=gg_unit_E000_0011
set udg_slideTriggers[1]=gg_trg_P1_Slide
set udg_slideTriggers[2]=gg_trg_P2_Slide
set udg_slideTriggers[3]=gg_trg_P3_Slide
set udg_slideTriggers[4]=gg_trg_P4_Slide
set udg_slideTriggers[5]=gg_trg_P5_Slide
set udg_slideTriggers[6]=gg_trg_P6_Slide
set udg_slideTriggers[7]=gg_trg_P7_Slide
set udg_slideTriggers[8]=gg_trg_P8_Slide
set udg_slideTriggers[9]=gg_trg_P9_Slide
set udg_slideTriggers[10]=gg_trg_P10_Slide
set udg_slideTriggers[11]=gg_trg_P11_Slide
if(Trig_Not_here_Func048001())then
call ForGroupBJ(GetUnitsOfPlayerAll(Player(0)),function Trig_Not_here_Func048002002)
else
call DoNothing()
endif
if(Trig_Not_here_Func049001())then
call ForGroupBJ(GetUnitsOfPlayerAll(Player(1)),function Trig_Not_here_Func049002002)
else
call DoNothing()
endif
if(Trig_Not_here_Func050001())then
call ForGroupBJ(GetUnitsOfPlayerAll(Player(2)),function Trig_Not_here_Func050002002)
else
call DoNothing()
endif
if(Trig_Not_here_Func051001())then
call ForGroupBJ(GetUnitsOfPlayerAll(Player(3)),function Trig_Not_here_Func051002002)
else
call DoNothing()
endif
if(Trig_Not_here_Func052001())then
call ForGroupBJ(GetUnitsOfPlayerAll(Player(4)),function Trig_Not_here_Func052002002)
else
call DoNothing()
endif
if(Trig_Not_here_Func053001())then
call ForGroupBJ(GetUnitsOfPlayerAll(Player(5)),function Trig_Not_here_Func053002002)
else
call DoNothing()
endif
if(Trig_Not_here_Func054001())then
call ForGroupBJ(GetUnitsOfPlayerAll(Player(6)),function Trig_Not_here_Func054002002)
else
call DoNothing()
endif
if(Trig_Not_here_Func055001())then
call ForGroupBJ(GetUnitsOfPlayerAll(Player(7)),function Trig_Not_here_Func055002002)
else
call DoNothing()
endif
if(Trig_Not_here_Func056001())then
call ForGroupBJ(GetUnitsOfPlayerAll(Player(8)),function Trig_Not_here_Func056002002)
else
call DoNothing()
endif
if(Trig_Not_here_Func057001())then
call ForGroupBJ(GetUnitsOfPlayerAll(Player(9)),function Trig_Not_here_Func057002002)
else
call DoNothing()
endif
if(Trig_Not_here_Func058001())then
call ForGroupBJ(GetUnitsOfPlayerAll(Player(10)),function Trig_Not_here_Func058002002)
else
call DoNothing()
endif
call EnableDawnDusk(false)
call UseTimeOfDayBJ(false)
call ForForce(GetPlayersAll(),function Trig_Not_here_Func061002)
call ForForce(GetPlayersMatching(Condition(function Trig_Not_here_Func063001001)),function Trig_Not_here_Func063002)
call ForForce(GetPlayersMatching(Condition(function Trig_Not_here_Func064001001)),function Trig_Not_here_Func064002)
call ForceRemovePlayerSimple(Player(11),udg_Losers)
call ForForce(udg_Discos,function Trig_Not_here_Func066002)
call DisplayTimedTextToForce(GetPlayersAll(),15.00,"TRIGSTR_019")
set udg_GameOver=false
call SetPlayerOnScoreScreenBJ(false,Player(11))
endfunction
function InitTrig_Not_here takes nothing returns nothing
set gg_trg_Not_here=CreateTrigger()
call TriggerAddAction(gg_trg_Not_here,function Trig_Not_here_Actions)
endfunction
function Trig_Next_Round_Func002002 takes nothing returns nothing
call SetUnitPositionLoc(GetFilterUnit(),GetRectCenter(gg_rct_Kitty_Start))
endfunction
function Trig_Next_Round_Func003002 takes nothing returns nothing
call RemoveUnit(GetEnumUnit())
endfunction
function Trig_Next_Round_Func006002 takes nothing returns nothing
call ForceRemovePlayerSimple(GetEnumPlayer(),udg_Losers)
endfunction
function Trig_Next_Round_Func007001001 takes nothing returns boolean
return(GetPlayerSlotState(GetFilterPlayer())==PLAYER_SLOT_STATE_PLAYING)
endfunction
function Trig_Next_Round_Func007002001 takes nothing returns boolean
return(IsPlayerInForce(GetEnumPlayer(),udg_Players)==true)
endfunction
function Trig_Next_Round_Func007002 takes nothing returns nothing
if(Trig_Next_Round_Func007002001())then
call DoNothing()
else
call ForceAddPlayerSimple(GetEnumPlayer(),udg_Players)
endif
endfunction
function Trig_Next_Round_Func012002 takes nothing returns nothing
call SetUnitUserData(GetEnumUnit(),0)
endfunction
function Trig_Next_Round_Actions takes nothing returns nothing
call TriggerSleepAction(1.00)
call ForGroupBJ(GetUnitsOfTypeIdAll('E000'),function Trig_Next_Round_Func002002)
call ForGroupBJ(GetUnitsOfTypeIdAll('n00D'),function Trig_Next_Round_Func003002)
call TriggerSleepAction(2.00)
call TriggerExecute(gg_trg_PlayerLeaves)
call ForForce(udg_Losers,function Trig_Next_Round_Func006002)
call ForForce(GetPlayersMatching(Condition(function Trig_Next_Round_Func007001001)),function Trig_Next_Round_Func007002)
call ForceRemovePlayerSimple(Player(11),udg_Players)
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=11
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call SetUnitPositionLoc(udg_kittys[GetForLoopIndexA()],udg_kittyStartingPoints[GetForLoopIndexA()])
call ReviveHeroLoc(udg_kittys[GetForLoopIndexA()],udg_kittyStartingPoints[GetForLoopIndexA()],true)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call PauseAllUnitsBJ(false)
call TriggerSleepAction(2.00)
call ForGroupBJ(GetUnitsOfTypeIdAll('E000'),function Trig_Next_Round_Func012002)
call TriggerExecute(gg_trg_Set_level)
call ConditionalTriggerExecute(gg_trg_Win)
call TriggerSleepAction(10.00)
endfunction
function InitTrig_Next_Round takes nothing returns nothing
set gg_trg_Next_Round=CreateTrigger()
call TriggerAddAction(gg_trg_Next_Round,function Trig_Next_Round_Actions)
endfunction
function Trig_PlayerLeaves_Conditions takes nothing returns boolean
if(not(udg_GameOver==false))then
return false
endif
return true
endfunction
function Trig_PlayerLeaves_Func002002001 takes nothing returns boolean
return(GetPlayerSlotState(GetEnumPlayer())==PLAYER_SLOT_STATE_LEFT)
endfunction
function Trig_PlayerLeaves_Func002002 takes nothing returns nothing
if(Trig_PlayerLeaves_Func002002001())then
call TriggerExecute(gg_trg_PlayerLeft)
else
call DoNothing()
endif
endfunction
function Trig_PlayerLeaves_Func003002001 takes nothing returns boolean
return(GetPlayerSlotState(GetEnumPlayer())==PLAYER_SLOT_STATE_LEFT)
endfunction
function Trig_PlayerLeaves_Func003002 takes nothing returns nothing
if(Trig_PlayerLeaves_Func003002001())then
call TriggerExecute(gg_trg_PlayerLeft)
else
call DoNothing()
endif
endfunction
function Trig_PlayerLeaves_Actions takes nothing returns nothing
call ForForce(udg_Players,function Trig_PlayerLeaves_Func002002)
call ForForce(udg_Losers,function Trig_PlayerLeaves_Func003002)
endfunction
function InitTrig_PlayerLeaves takes nothing returns nothing
set gg_trg_PlayerLeaves=CreateTrigger()
call TriggerRegisterTimerEventPeriodic(gg_trg_PlayerLeaves,6.00)
call TriggerAddCondition(gg_trg_PlayerLeaves,Condition(function Trig_PlayerLeaves_Conditions))
call TriggerAddAction(gg_trg_PlayerLeaves,function Trig_PlayerLeaves_Actions)
endfunction
function Trig_PlayerLeft_Func001001 takes nothing returns boolean
return(IsPlayerInForce(GetEnumPlayer(),udg_Discos)==true)
endfunction
function Trig_PlayerLeft_Func005002 takes nothing returns nothing
call RemoveUnit(GetEnumUnit())
endfunction
function Trig_PlayerLeft_Actions takes nothing returns nothing
if(Trig_PlayerLeft_Func001001())then
return
else
call DoNothing()
endif
call ForceAddPlayerSimple(GetEnumPlayer(),udg_Discos)
call DisplayTimedTextToForce(GetPlayersAll(),10.00,(udg_ColorText[GetConvertedPlayerId(GetEnumPlayer())]+(GetPlayerName(GetEnumPlayer())+"|r Dã ra khoi game !!!!! (Thàng cùi báp)")))
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=5
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call DisplayTimedTextToForce(GetPlayersAll(),6.00,"TRIGSTR_023")
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call ForGroupBJ(GetUnitsOfPlayerAll(GetEnumPlayer()),function Trig_PlayerLeft_Func005002)
call ForceRemovePlayerSimple(GetEnumPlayer(),udg_Players)
call ForceRemovePlayerSimple(GetEnumPlayer(),udg_Losers)
call LeaderboardRemovePlayerItemBJ(GetEnumPlayer(),GetLastCreatedLeaderboard())
endfunction
function InitTrig_PlayerLeft takes nothing returns nothing
set gg_trg_PlayerLeft=CreateTrigger()
call TriggerAddAction(gg_trg_PlayerLeft,function Trig_PlayerLeft_Actions)
endfunction
function Trig_Starting_Gold_Actions takes nothing returns nothing
call SetPlayerStateBJ(Player(0),PLAYER_STATE_RESOURCE_GOLD,200)
call SetPlayerStateBJ(Player(1),PLAYER_STATE_RESOURCE_GOLD,200)
call SetPlayerStateBJ(Player(2),PLAYER_STATE_RESOURCE_GOLD,200)
call SetPlayerStateBJ(Player(3),PLAYER_STATE_RESOURCE_GOLD,200)
call SetPlayerStateBJ(Player(4),PLAYER_STATE_RESOURCE_GOLD,200)
call SetPlayerStateBJ(Player(5),PLAYER_STATE_RESOURCE_GOLD,200)
call SetPlayerStateBJ(Player(6),PLAYER_STATE_RESOURCE_GOLD,200)
call SetPlayerStateBJ(Player(7),PLAYER_STATE_RESOURCE_GOLD,200)
call SetPlayerStateBJ(Player(8),PLAYER_STATE_RESOURCE_GOLD,200)
call SetPlayerStateBJ(Player(9),PLAYER_STATE_RESOURCE_GOLD,200)
call SetPlayerStateBJ(Player(10),PLAYER_STATE_RESOURCE_GOLD,200)
endfunction
function InitTrig_Starting_Gold takes nothing returns nothing
set gg_trg_Starting_Gold=CreateTrigger()
call TriggerAddAction(gg_trg_Starting_Gold,function Trig_Starting_Gold_Actions)
endfunction
function Trig_TimeofDay_Actions takes nothing returns nothing
call SetTimeOfDay(12.00)
endfunction
function InitTrig_TimeofDay takes nothing returns nothing
set gg_trg_TimeofDay=CreateTrigger()
call TriggerRegisterTimerEventSingle(gg_trg_TimeofDay,0.01)
call TriggerAddAction(gg_trg_TimeofDay,function Trig_TimeofDay_Actions)
endfunction
function Trig_Master_Slide_Func001Func001Func003C takes nothing returns boolean
if(not(GetTerrainTypeBJ(udg_tempPoint1)=='Nice'))then
return false
endif
return true
endfunction
function Trig_Master_Slide_Func001Func001C takes nothing returns boolean
if(not(IsUnitAliveBJ(udg_kittys[GetForLoopIndexA()])==true))then
return false
endif
return true
endfunction
function Trig_Master_Slide_Actions takes nothing returns nothing
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=12
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(Trig_Master_Slide_Func001Func001C())then
set udg_tempPoint1=GetUnitLoc(udg_kittys[GetForLoopIndexA()])
if(Trig_Master_Slide_Func001Func001Func003C())then
call EnableTrigger(udg_slideTriggers[GetForLoopIndexA()])
else
call DisableTrigger(udg_slideTriggers[GetForLoopIndexA()])
endif
call RemoveLocation(udg_tempPoint1)
else
call DoNothing()
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction
function InitTrig_Master_Slide takes nothing returns nothing
set gg_trg_Master_Slide=CreateTrigger()
call TriggerRegisterTimerEventPeriodic(gg_trg_Master_Slide,0.10)
call TriggerAddAction(gg_trg_Master_Slide,function Trig_Master_Slide_Actions)
endfunction
function Trig_Master_Turn_Point_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='E000'))then
return false
endif
if(not(GetTerrainTypeBJ(GetUnitLoc(GetTriggerUnit()))=='Nice'))then
return false
endif
return true
endfunction
function Trig_Master_Turn_Point_Actions takes nothing returns nothing
call IssueImmediateOrder(GetTriggerUnit(),"stop")
call SetUnitPositionLocFacingLocBJ(GetTriggerUnit(),GetUnitLoc(GetTriggerUnit()),GetOrderPointLoc())
endfunction
function InitTrig_Master_Turn_Point takes nothing returns nothing
set gg_trg_Master_Turn_Point=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_Master_Turn_Point,EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
call TriggerAddCondition(gg_trg_Master_Turn_Point,Condition(function Trig_Master_Turn_Point_Conditions))
call TriggerAddAction(gg_trg_Master_Turn_Point,function Trig_Master_Turn_Point_Actions)
endfunction
function Trig_Master_Turn_Unit_Func005C takes nothing returns boolean
if((GetUnitTypeId(GetOrderTargetUnit())=='nwwg'))then
return true
endif
if((GetUnitTypeId(GetOrderTargetUnit())=='E000'))then
return true
endif
if((GetUnitTypeId(GetOrderTargetUnit())=='n000'))then
return true
endif
if((GetUnitTypeId(GetOrderTargetUnit())=='n00A'))then
return true
endif
if((GetUnitTypeId(GetOrderTargetUnit())=='n00B'))then
return true
endif
if((GetUnitTypeId(GetOrderTargetUnit())=='n002'))then
return true
endif
if((GetUnitTypeId(GetOrderTargetUnit())=='n003'))then
return true
endif
if((GetUnitTypeId(GetOrderTargetUnit())=='n004'))then
return true
endif
if((GetUnitTypeId(GetOrderTargetUnit())=='n005'))then
return true
endif
if((GetUnitTypeId(GetOrderTargetUnit())=='n006'))then
return true
endif
if((GetUnitTypeId(GetOrderTargetUnit())=='n007'))then
return true
endif
if((GetUnitTypeId(GetOrderTargetUnit())=='n008'))then
return true
endif
if((GetUnitTypeId(GetOrderTargetUnit())=='n009'))then
return true
endif
if((GetUnitTypeId(GetOrderTargetUnit())=='n00D'))then
return true
endif
return false
endfunction
function Trig_Master_Turn_Unit_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='E000'))then
return false
endif
if(not(GetTerrainTypeBJ(GetUnitLoc(GetTriggerUnit()))=='Nice'))then
return false
endif
if(not Trig_Master_Turn_Unit_Func005C())then
return false
endif
return true
endfunction
function Trig_Master_Turn_Unit_Actions takes nothing returns nothing
call IssueImmediateOrder(GetTriggerUnit(),"stop")
call SetUnitPositionLocFacingLocBJ(GetTriggerUnit(),GetUnitLoc(GetTriggerUnit()),GetUnitLoc(GetOrderTargetUnit()))
endfunction
function InitTrig_Master_Turn_Unit takes nothing returns nothing
set gg_trg_Master_Turn_Unit=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_Master_Turn_Unit,EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER)
call TriggerAddCondition(gg_trg_Master_Turn_Unit,Condition(function Trig_Master_Turn_Unit_Conditions))
call TriggerAddAction(gg_trg_Master_Turn_Unit,function Trig_Master_Turn_Unit_Actions)
endfunction
function Trig_Master_Turn_Item_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='E000'))then
return false
endif
if(not(GetTerrainTypeBJ(GetUnitLoc(GetTriggerUnit()))=='Nice'))then
return false
endif
return true
endfunction
function Trig_Master_Turn_Item_Func002C takes nothing returns boolean
if(not(GetUnitTypeId(GetOrderTargetUnit())!='nwwg'))then
return false
endif
if(not(GetUnitTypeId(GetOrderTargetUnit())!='E000'))then
return false
endif
if(not(GetUnitTypeId(GetOrderTargetUnit())!='n000'))then
return false
endif
if(not(GetUnitTypeId(GetOrderTargetUnit())!='n00A'))then
return false
endif
if(not(GetUnitTypeId(GetOrderTargetUnit())!='n00B'))then
return false
endif
if(not(GetUnitTypeId(GetOrderTargetUnit())!='n002'))then
return false
endif
if(not(GetUnitTypeId(GetOrderTargetUnit())!='n003'))then
return false
endif
if(not(GetUnitTypeId(GetOrderTargetUnit())!='n004'))then
return false
endif
if(not(GetUnitTypeId(GetOrderTargetUnit())!='n005'))then
return false
endif
if(not(GetUnitTypeId(GetOrderTargetUnit())!='n006'))then
return false
endif
if(not(GetUnitTypeId(GetOrderTargetUnit())!='n007'))then
return false
endif
if(not(GetUnitTypeId(GetOrderTargetUnit())!='n008'))then
return false
endif
if(not(GetUnitTypeId(GetOrderTargetUnit())!='n009'))then
return false
endif
if(not(GetUnitTypeId(GetOrderTargetUnit())!='n00D'))then
return false
endif
return true
endfunction
function Trig_Master_Turn_Item_Actions takes nothing returns nothing
call IssueImmediateOrder(GetTriggerUnit(),"stop")
if(Trig_Master_Turn_Item_Func002C())then
call SetUnitPositionLocFacingLocBJ(GetTriggerUnit(),GetUnitLoc(GetTriggerUnit()),GetItemLoc(GetOrderTargetItem()))
else
call DoNothing()
endif
endfunction
function InitTrig_Master_Turn_Item takes nothing returns nothing
set gg_trg_Master_Turn_Item=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_Master_Turn_Item,EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER)
call TriggerAddCondition(gg_trg_Master_Turn_Item,Condition(function Trig_Master_Turn_Item_Conditions))
call TriggerAddAction(gg_trg_Master_Turn_Item,function Trig_Master_Turn_Item_Actions)
endfunction
function Trig_P1_Slide_Actions takes nothing returns nothing
set udg_selectedKitty=gg_unit_E000_0001
set udg_tempPoint1=GetUnitLoc(udg_selectedKitty)
set udg_tempPoint2=PolarProjectionBJ(udg_tempPoint1,(udg_speedMultiplier*((GetUnitMoveSpeed(udg_selectedKitty)*udg_REALSPD1)/ GetUnitDefaultMoveSpeed(udg_selectedKitty))),GetUnitFacing(udg_selectedKitty))
call SetUnitPositionLoc(udg_selectedKitty,udg_tempPoint2)
call RemoveLocation(udg_tempPoint1)
call RemoveLocation(udg_tempPoint2)
endfunction
function InitTrig_P1_Slide takes nothing returns nothing
set gg_trg_P1_Slide=CreateTrigger()
call DisableTrigger(gg_trg_P1_Slide)
call TriggerRegisterTimerEventPeriodic(gg_trg_P1_Slide,0.01)
call TriggerAddAction(gg_trg_P1_Slide,function Trig_P1_Slide_Actions)
endfunction
function Trig_P2_Slide_Actions takes nothing returns nothing
set udg_selectedKitty=gg_unit_E000_0002
set udg_tempPoint1=GetUnitLoc(udg_selectedKitty)
set udg_tempPoint2=PolarProjectionBJ(udg_tempPoint1,(udg_speedMultiplier*((GetUnitMoveSpeed(udg_selectedKitty)*udg_REALSPD2)/ GetUnitDefaultMoveSpeed(udg_selectedKitty))),GetUnitFacing(udg_selectedKitty))
call SetUnitPositionLoc(udg_selectedKitty,udg_tempPoint2)
call RemoveLocation(udg_tempPoint1)
call RemoveLocation(udg_tempPoint2)
endfunction
function InitTrig_P2_Slide takes nothing returns nothing
set gg_trg_P2_Slide=CreateTrigger()
call DisableTrigger(gg_trg_P2_Slide)
call TriggerRegisterTimerEventPeriodic(gg_trg_P2_Slide,0.01)
call TriggerAddAction(gg_trg_P2_Slide,function Trig_P2_Slide_Actions)
endfunction
function Trig_P3_Slide_Actions takes nothing returns nothing
set udg_selectedKitty=gg_unit_E000_0003
set udg_tempPoint1=GetUnitLoc(udg_selectedKitty)
set udg_tempPoint2=PolarProjectionBJ(udg_tempPoint1,(udg_speedMultiplier*((GetUnitMoveSpeed(udg_selectedKitty)*udg_REALSPD3)/ GetUnitDefaultMoveSpeed(udg_selectedKitty))),GetUnitFacing(udg_selectedKitty))
call SetUnitPositionLoc(udg_selectedKitty,udg_tempPoint2)
call RemoveLocation(udg_tempPoint1)
call RemoveLocation(udg_tempPoint2)
endfunction
function InitTrig_P3_Slide takes nothing returns nothing
set gg_trg_P3_Slide=CreateTrigger()
call DisableTrigger(gg_trg_P3_Slide)
call TriggerRegisterTimerEventPeriodic(gg_trg_P3_Slide,0.01)
call TriggerAddAction(gg_trg_P3_Slide,function Trig_P3_Slide_Actions)
endfunction
function Trig_P4_Slide_Actions takes nothing returns nothing
set udg_selectedKitty=gg_unit_E000_0004
set udg_tempPoint1=GetUnitLoc(udg_selectedKitty)
set udg_tempPoint2=PolarProjectionBJ(udg_tempPoint1,(udg_speedMultiplier*((GetUnitMoveSpeed(udg_selectedKitty)*udg_REALSPD4)/ GetUnitDefaultMoveSpeed(udg_selectedKitty))),GetUnitFacing(udg_selectedKitty))
call SetUnitPositionLoc(udg_selectedKitty,udg_tempPoint2)
call RemoveLocation(udg_tempPoint1)
call RemoveLocation(udg_tempPoint2)
endfunction
function InitTrig_P4_Slide takes nothing returns nothing
set gg_trg_P4_Slide=CreateTrigger()
call DisableTrigger(gg_trg_P4_Slide)
call TriggerRegisterTimerEventPeriodic(gg_trg_P4_Slide,0.01)
call TriggerAddAction(gg_trg_P4_Slide,function Trig_P4_Slide_Actions)
endfunction
function Trig_P5_Slide_Actions takes nothing returns nothing
set udg_selectedKitty=gg_unit_E000_0005
set udg_tempPoint1=GetUnitLoc(udg_selectedKitty)
set udg_tempPoint2=PolarProjectionBJ(udg_tempPoint1,(udg_speedMultiplier*((GetUnitMoveSpeed(udg_selectedKitty)*udg_REALSPD5)/ GetUnitDefaultMoveSpeed(udg_selectedKitty))),GetUnitFacing(udg_selectedKitty))
call SetUnitPositionLoc(udg_selectedKitty,udg_tempPoint2)
call RemoveLocation(udg_tempPoint1)
call RemoveLocation(udg_tempPoint2)
endfunction
function InitTrig_P5_Slide takes nothing returns nothing
set gg_trg_P5_Slide=CreateTrigger()
call DisableTrigger(gg_trg_P5_Slide)
call TriggerRegisterTimerEventPeriodic(gg_trg_P5_Slide,0.01)
call TriggerAddAction(gg_trg_P5_Slide,function Trig_P5_Slide_Actions)
endfunction
function Trig_P6_Slide_Actions takes nothing returns nothing
set udg_selectedKitty=gg_unit_E000_0006
set udg_tempPoint1=GetUnitLoc(udg_selectedKitty)
set udg_tempPoint2=PolarProjectionBJ(udg_tempPoint1,(udg_speedMultiplier*((GetUnitMoveSpeed(udg_selectedKitty)*udg_REALSPD6)/ GetUnitDefaultMoveSpeed(udg_selectedKitty))),GetUnitFacing(udg_selectedKitty))
call SetUnitPositionLoc(udg_selectedKitty,udg_tempPoint2)
call RemoveLocation(udg_tempPoint1)
call RemoveLocation(udg_tempPoint2)
endfunction
function InitTrig_P6_Slide takes nothing returns nothing
set gg_trg_P6_Slide=CreateTrigger()
call DisableTrigger(gg_trg_P6_Slide)
call TriggerRegisterTimerEventPeriodic(gg_trg_P6_Slide,0.01)
call TriggerAddAction(gg_trg_P6_Slide,function Trig_P6_Slide_Actions)
endfunction
function Trig_P7_Slide_Actions takes nothing returns nothing
set udg_selectedKitty=gg_unit_E000_0007
set udg_tempPoint1=GetUnitLoc(udg_selectedKitty)
set udg_tempPoint2=PolarProjectionBJ(udg_tempPoint1,(udg_speedMultiplier*((GetUnitMoveSpeed(udg_selectedKitty)*udg_REALSPD7)/ GetUnitDefaultMoveSpeed(udg_selectedKitty))),GetUnitFacing(udg_selectedKitty))
call SetUnitPositionLoc(udg_selectedKitty,udg_tempPoint2)
call RemoveLocation(udg_tempPoint1)
call RemoveLocation(udg_tempPoint2)
endfunction
function InitTrig_P7_Slide takes nothing returns nothing
set gg_trg_P7_Slide=CreateTrigger()
call DisableTrigger(gg_trg_P7_Slide)
call TriggerRegisterTimerEventPeriodic(gg_trg_P7_Slide,0.01)
call TriggerAddAction(gg_trg_P7_Slide,function Trig_P7_Slide_Actions)
endfunction
function Trig_P8_Slide_Actions takes nothing returns nothing
set udg_selectedKitty=gg_unit_E000_0008
set udg_tempPoint1=GetUnitLoc(udg_selectedKitty)
set udg_tempPoint2=PolarProjectionBJ(udg_tempPoint1,(udg_speedMultiplier*((GetUnitMoveSpeed(udg_selectedKitty)*udg_REALSPD8)/ GetUnitDefaultMoveSpeed(udg_selectedKitty))),GetUnitFacing(udg_selectedKitty))
call SetUnitPositionLoc(udg_selectedKitty,udg_tempPoint2)
call RemoveLocation(udg_tempPoint1)
call RemoveLocation(udg_tempPoint2)
endfunction
function InitTrig_P8_Slide takes nothing returns nothing
set gg_trg_P8_Slide=CreateTrigger()
call DisableTrigger(gg_trg_P8_Slide)
call TriggerRegisterTimerEventPeriodic(gg_trg_P8_Slide,0.01)
call TriggerAddAction(gg_trg_P8_Slide,function Trig_P8_Slide_Actions)
endfunction
function Trig_P9_Slide_Actions takes nothing returns nothing
set udg_selectedKitty=gg_unit_E000_0009
set udg_tempPoint1=GetUnitLoc(udg_selectedKitty)
set udg_tempPoint2=PolarProjectionBJ(udg_tempPoint1,(udg_speedMultiplier*((GetUnitMoveSpeed(udg_selectedKitty)*udg_REALSPD9)/ GetUnitDefaultMoveSpeed(udg_selectedKitty))),GetUnitFacing(udg_selectedKitty))
call SetUnitPositionLoc(udg_selectedKitty,udg_tempPoint2)
call RemoveLocation(udg_tempPoint1)
call RemoveLocation(udg_tempPoint2)
endfunction
function InitTrig_P9_Slide takes nothing returns nothing
set gg_trg_P9_Slide=CreateTrigger()
call DisableTrigger(gg_trg_P9_Slide)
call TriggerRegisterTimerEventPeriodic(gg_trg_P9_Slide,0.01)
call TriggerAddAction(gg_trg_P9_Slide,function Trig_P9_Slide_Actions)
endfunction
function Trig_P10_Slide_Actions takes nothing returns nothing
set udg_selectedKitty=gg_unit_E000_0010
set udg_tempPoint1=GetUnitLoc(udg_selectedKitty)
set udg_tempPoint2=PolarProjectionBJ(udg_tempPoint1,(udg_speedMultiplier*((GetUnitMoveSpeed(udg_selectedKitty)*udg_REALSPD10)/ GetUnitDefaultMoveSpeed(udg_selectedKitty))),GetUnitFacing(udg_selectedKitty))
call SetUnitPositionLoc(udg_selectedKitty,udg_tempPoint2)
call RemoveLocation(udg_tempPoint1)
call RemoveLocation(udg_tempPoint2)
endfunction
function InitTrig_P10_Slide takes nothing returns nothing
set gg_trg_P10_Slide=CreateTrigger()
call DisableTrigger(gg_trg_P10_Slide)
call TriggerRegisterTimerEventPeriodic(gg_trg_P10_Slide,0.01)
call TriggerAddAction(gg_trg_P10_Slide,function Trig_P10_Slide_Actions)
endfunction
function Trig_P11_Slide_Actions takes nothing returns nothing
set udg_selectedKitty=gg_unit_E000_0011
set udg_tempPoint1=GetUnitLoc(udg_selectedKitty)
set udg_tempPoint2=PolarProjectionBJ(udg_tempPoint1,(udg_speedMultiplier*((GetUnitMoveSpeed(udg_selectedKitty)*udg_REALSPD11)/ GetUnitDefaultMoveSpeed(udg_selectedKitty))),GetUnitFacing(udg_selectedKitty))
call SetUnitPositionLoc(udg_selectedKitty,udg_tempPoint2)
call RemoveLocation(udg_tempPoint1)
call RemoveLocation(udg_tempPoint2)
endfunction
function InitTrig_P11_Slide takes nothing returns nothing
set gg_trg_P11_Slide=CreateTrigger()
call DisableTrigger(gg_trg_P11_Slide)
call TriggerRegisterTimerEventPeriodic(gg_trg_P11_Slide,0.01)
call TriggerAddAction(gg_trg_P11_Slide,function Trig_P11_Slide_Actions)
endfunction
function Trig_P1_Revive_Conditions takes nothing returns boolean
if(not(IsUnitAliveBJ(gg_unit_E000_0001)==true))then
return false
endif
if(not(GetUnitTypeId(GetTriggerUnit())=='n00D'))then
return false
endif
if(not(GetOwningPlayer(GetTriggerUnit())!=Player(0)))then
return false
endif
return true
endfunction
function Trig_P1_Revive_Actions takes nothing returns nothing
call AddHeroXPSwapped(-20,udg_kittys[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],false)
call AdjustPlayerStateBJ(-15,GetOwningPlayer(GetTriggerUnit()),PLAYER_STATE_RESOURCE_GOLD)
call AdjustPlayerStateBJ(30,Player(0),PLAYER_STATE_RESOURCE_GOLD)
call AddHeroXPSwapped(50,gg_unit_E000_0001,true)
call SetUnitPositionLocFacingBJ(udg_kittys[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],GetUnitLoc(gg_unit_E000_0001),GetUnitFacing(gg_unit_E000_0001))
call SetUnitFacingTimed(udg_kittys[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],GetUnitFacing(gg_unit_E000_0001),0)
call ReviveHeroLoc(udg_kittys[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],GetUnitLoc(GetTriggerUnit()),true)
call PanCameraToTimedLocForPlayer(GetOwningPlayer(GetTriggerUnit()),GetUnitLoc(udg_kittys[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]),0.00)
call ForceAddPlayerSimple(GetOwningPlayer(GetTriggerUnit()),udg_Players)
call ForceRemovePlayerSimple(GetOwningPlayer(GetTriggerUnit()),udg_Losers)
set udg_Score[1]=(udg_Score[1]+1)
call LeaderboardSetPlayerItemValueBJ(Player(0),GetLastCreatedLeaderboard(),udg_Score[1])
call LeaderboardSortItemsBJ(GetLastCreatedLeaderboard(),bj_SORTTYPE_SORTBYVALUE,false)
set udg_Alive[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]=true
call RemoveUnit(GetTriggerUnit())
endfunction
function InitTrig_P1_Revive takes nothing returns nothing
set gg_trg_P1_Revive=CreateTrigger()
call TriggerRegisterUnitInRangeSimple(gg_trg_P1_Revive,70.00,gg_unit_E000_0001)
call TriggerAddCondition(gg_trg_P1_Revive,Condition(function Trig_P1_Revive_Conditions))
call TriggerAddAction(gg_trg_P1_Revive,function Trig_P1_Revive_Actions)
endfunction
function Trig_P2_Revive_Conditions takes nothing returns boolean
if(not(IsUnitAliveBJ(gg_unit_E000_0002)==true))then
return false
endif
if(not(GetUnitTypeId(GetTriggerUnit())=='n00D'))then
return false
endif
if(not(GetOwningPlayer(GetTriggerUnit())!=Player(1)))then
return false
endif
return true
endfunction
function Trig_P2_Revive_Actions takes nothing returns nothing
call AddHeroXPSwapped(-20,udg_kittys[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],false)
call AdjustPlayerStateBJ(-15,GetOwningPlayer(GetTriggerUnit()),PLAYER_STATE_RESOURCE_GOLD)
call AdjustPlayerStateBJ(30,Player(1),PLAYER_STATE_RESOURCE_GOLD)
call AddHeroXPSwapped(50,gg_unit_E000_0002,true)
call SetUnitPositionLocFacingBJ(udg_kittys[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],GetUnitLoc(gg_unit_E000_0002),GetUnitFacing(gg_unit_E000_0002))
call SetUnitFacingTimed(udg_kittys[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],GetUnitFacing(gg_unit_E000_0002),0)
call ReviveHeroLoc(udg_kittys[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],GetUnitLoc(GetTriggerUnit()),true)
call PanCameraToTimedLocForPlayer(GetOwningPlayer(GetTriggerUnit()),GetUnitLoc(udg_kittys[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]),0.00)
call ForceAddPlayerSimple(GetOwningPlayer(GetTriggerUnit()),udg_Players)
call ForceRemovePlayerSimple(GetOwningPlayer(GetTriggerUnit()),udg_Losers)
set udg_Score[2]=(udg_Score[2]+1)
call LeaderboardSetPlayerItemValueBJ(Player(1),GetLastCreatedLeaderboard(),udg_Score[2])
call LeaderboardSortItemsBJ(GetLastCreatedLeaderboard(),bj_SORTTYPE_SORTBYVALUE,false)
set udg_Alive[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]=true
call RemoveUnit(GetTriggerUnit())
endfunction
function InitTrig_P2_Revive takes nothing returns nothing
set gg_trg_P2_Revive=CreateTrigger()
call TriggerRegisterUnitInRangeSimple(gg_trg_P2_Revive,70.00,gg_unit_E000_0002)
call TriggerAddCondition(gg_trg_P2_Revive,Condition(function Trig_P2_Revive_Conditions))
call TriggerAddAction(gg_trg_P2_Revive,function Trig_P2_Revive_Actions)
endfunction
function Trig_P3_Revive_Conditions takes nothing returns boolean
if(not(IsUnitAliveBJ(gg_unit_E000_0003)==true))then
return false
endif
if(not(GetUnitTypeId(GetTriggerUnit())=='n00D'))then
return false
endif
if(not(GetOwningPlayer(GetTriggerUnit())!=Player(2)))then
return false
endif
return true
endfunction
function Trig_P3_Revive_Actions takes nothing returns nothing
call AddHeroXPSwapped(-20,udg_kittys[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],false)
call AdjustPlayerStateBJ(-15,GetOwningPlayer(GetTriggerUnit()),PLAYER_STATE_RESOURCE_GOLD)
call AdjustPlayerStateBJ(30,Player(2),PLAYER_STATE_RESOURCE_GOLD)
call AddHeroXPSwapped(50,gg_unit_E000_0003,true)
call SetUnitPositionLocFacingBJ(udg_kittys[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],GetUnitLoc(gg_unit_E000_0003),GetUnitFacing(gg_unit_E000_0003))
call SetUnitFacingTimed(udg_kittys[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],GetUnitFacing(gg_unit_E000_0003),0)
call ReviveHeroLoc(udg_kittys[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],GetUnitLoc(GetTriggerUnit()),true)
call PanCameraToTimedLocForPlayer(GetOwningPlayer(GetTriggerUnit()),GetUnitLoc(udg_kittys[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]),0.00)
call ForceAddPlayerSimple(GetOwningPlayer(GetTriggerUnit()),udg_Players)
call ForceRemovePlayerSimple(GetOwningPlayer(GetTriggerUnit()),udg_Losers)
set udg_Score[3]=(udg_Score[3]+1)
call LeaderboardSetPlayerItemValueBJ(Player(2),GetLastCreatedLeaderboard(),udg_Score[3])
call LeaderboardSortItemsBJ(GetLastCreatedLeaderboard(),bj_SORTTYPE_SORTBYVALUE,false)
set udg_Alive[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]=true
call RemoveUnit(GetTriggerUnit())
endfunction
function InitTrig_P3_Revive takes nothing returns nothing
set gg_trg_P3_Revive=CreateTrigger()
call TriggerRegisterUnitInRangeSimple(gg_trg_P3_Revive,70.00,gg_unit_E000_0003)
call TriggerAddCondition(gg_trg_P3_Revive,Condition(function Trig_P3_Revive_Conditions))
call TriggerAddAction(gg_trg_P3_Revive,function Trig_P3_Revive_Actions)
endfunction
function Trig_P4_Revive_Conditions takes nothing returns boolean
if(not(IsUnitAliveBJ(gg_unit_E000_0004)==true))then
return false
endif
if(not(GetUnitTypeId(GetTriggerUnit())=='n00D'))then
return false
endif
if(not(GetOwningPlayer(GetTriggerUnit())!=Player(3)))then
return false
endif
return true
endfunction
function Trig_P4_Revive_Actions takes nothing returns nothing
call AddHeroXPSwapped(-20,udg_kittys[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],false)
call AdjustPlayerStateBJ(-15,GetOwningPlayer(GetTriggerUnit()),PLAYER_STATE_RESOURCE_GOLD)
call AdjustPlayerStateBJ(30,Player(3),PLAYER_STATE_RESOURCE_GOLD)
call AddHeroXPSwapped(50,gg_unit_E000_0004,true)
call SetUnitPositionLocFacingBJ(udg_kittys[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],GetUnitLoc(gg_unit_E000_0004),GetUnitFacing(gg_unit_E000_0004))
call SetUnitFacingTimed(udg_kittys[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],GetUnitFacing(gg_unit_E000_0004),0)
call ReviveHeroLoc(udg_kittys[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],GetUnitLoc(GetTriggerUnit()),true)
call PanCameraToTimedLocForPlayer(GetOwningPlayer(GetTriggerUnit()),GetUnitLoc(udg_kittys[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]),0.00)
call ForceAddPlayerSimple(GetOwningPlayer(GetTriggerUnit()),udg_Players)
call ForceRemovePlayerSimple(GetOwningPlayer(GetTriggerUnit()),udg_Losers)
set udg_Score[4]=(udg_Score[4]+1)
call LeaderboardSetPlayerItemValueBJ(Player(3),GetLastCreatedLeaderboard(),udg_Score[4])
call LeaderboardSortItemsBJ(GetLastCreatedLeaderboard(),bj_SORTTYPE_SORTBYVALUE,false)
set udg_Alive[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]=true
call RemoveUnit(GetTriggerUnit())
endfunction
function InitTrig_P4_Revive takes nothing returns nothing
set gg_trg_P4_Revive=CreateTrigger()
call TriggerRegisterUnitInRangeSimple(gg_trg_P4_Revive,70.00,gg_unit_E000_0004)
call TriggerAddCondition(gg_trg_P4_Revive,Condition(function Trig_P4_Revive_Conditions))
call TriggerAddAction(gg_trg_P4_Revive,function Trig_P4_Revive_Actions)
endfunction
function Trig_P5_Revive_Conditions takes nothing returns boolean
if(not(IsUnitAliveBJ(gg_unit_E000_0005)==true))then
return false
endif
if(not(GetUnitTypeId(GetTriggerUnit())=='n00D'))then
return false
endif
if(not(GetOwningPlayer(GetTriggerUnit())!=Player(4)))then
return false
endif
return true
endfunction
function Trig_P5_Revive_Actions takes nothing returns nothing
call AddHeroXPSwapped(-20,udg_kittys[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],false)
call AdjustPlayerStateBJ(-15,GetOwningPlayer(GetTriggerUnit()),PLAYER_STATE_RESOURCE_GOLD)
call AdjustPlayerStateBJ(30,Player(4),PLAYER_STATE_RESOURCE_GOLD)
call AddHeroXPSwapped(50,gg_unit_E000_0005,true)
call SetUnitPositionLocFacingBJ(udg_kittys[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],GetUnitLoc(gg_unit_E000_0005),GetUnitFacing(gg_unit_E000_0005))
call SetUnitFacingTimed(udg_kittys[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],GetUnitFacing(gg_unit_E000_0005),0)
call ReviveHeroLoc(udg_kittys[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],GetUnitLoc(GetTriggerUnit()),true)
call PanCameraToTimedLocForPlayer(GetOwningPlayer(GetTriggerUnit()),GetUnitLoc(udg_kittys[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]),0.00)
call ForceAddPlayerSimple(GetOwningPlayer(GetTriggerUnit()),udg_Players)
call ForceRemovePlayerSimple(GetOwningPlayer(GetTriggerUnit()),udg_Losers)
set udg_Score[5]=(udg_Score[5]+1)
call LeaderboardSetPlayerItemValueBJ(Player(4),GetLastCreatedLeaderboard(),udg_Score[5])
call LeaderboardSortItemsBJ(GetLastCreatedLeaderboard(),bj_SORTTYPE_SORTBYVALUE,false)
set udg_Alive[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]=true
call RemoveUnit(GetTriggerUnit())
endfunction
function InitTrig_P5_Revive takes nothing returns nothing
set gg_trg_P5_Revive=CreateTrigger()
call TriggerRegisterUnitInRangeSimple(gg_trg_P5_Revive,70.00,gg_unit_E000_0005)
call TriggerAddCondition(gg_trg_P5_Revive,Condition(function Trig_P5_Revive_Conditions))
call TriggerAddAction(gg_trg_P5_Revive,function Trig_P5_Revive_Actions)
endfunction
function Trig_P6_Revive_Conditions takes nothing returns boolean
if(not(IsUnitAliveBJ(gg_unit_E000_0006)==true))then
return false
endif
if(not(GetUnitTypeId(GetTriggerUnit())=='n00D'))then
return false
endif
if(not(GetOwningPlayer(GetTriggerUnit())!=Player(5)))then
return false
endif
return true
endfunction
function Trig_P6_Revive_Actions takes nothing returns nothing
call AddHeroXPSwapped(-20,udg_kittys[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],false)
call AdjustPlayerStateBJ(-15,GetOwningPlayer(GetTriggerUnit()),PLAYER_STATE_RESOURCE_GOLD)
call AdjustPlayerStateBJ(30,Player(5),PLAYER_STATE_RESOURCE_GOLD)
call AddHeroXPSwapped(50,gg_unit_E000_0006,true)
call SetUnitPositionLocFacingBJ(udg_kittys[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],GetUnitLoc(gg_unit_E000_0006),GetUnitFacing(gg_unit_E000_0006))
call SetUnitFacingTimed(udg_kittys[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],GetUnitFacing(gg_unit_E000_0006),0)
call ReviveHeroLoc(udg_kittys[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],GetUnitLoc(GetTriggerUnit()),true)
call PanCameraToTimedLocForPlayer(GetOwningPlayer(GetTriggerUnit()),GetUnitLoc(udg_kittys[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]),0.00)
call ForceAddPlayerSimple(GetOwningPlayer(GetTriggerUnit()),udg_Players)
call ForceRemovePlayerSimple(GetOwningPlayer(GetTriggerUnit()),udg_Losers)
set udg_Score[6]=(udg_Score[6]+1)
call LeaderboardSetPlayerItemValueBJ(Player(5),GetLastCreatedLeaderboard(),udg_Score[6])
call LeaderboardSortItemsBJ(GetLastCreatedLeaderboard(),bj_SORTTYPE_SORTBYVALUE,false)
set udg_Alive[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]=true
call RemoveUnit(GetTriggerUnit())
endfunction
function InitTrig_P6_Revive takes nothing returns nothing
set gg_trg_P6_Revive=CreateTrigger()
call TriggerRegisterUnitInRangeSimple(gg_trg_P6_Revive,70.00,gg_unit_E000_0006)
call TriggerAddCondition(gg_trg_P6_Revive,Condition(function Trig_P6_Revive_Conditions))
call TriggerAddAction(gg_trg_P6_Revive,function Trig_P6_Revive_Actions)
endfunction
function Trig_P7_Revive_Conditions takes nothing returns boolean
if(not(IsUnitAliveBJ(gg_unit_E000_0007)==true))then
return false
endif
if(not(GetUnitTypeId(GetTriggerUnit())=='n00D'))then
return false
endif
if(not(GetOwningPlayer(GetTriggerUnit())!=Player(6)))then
return false
endif
return true
endfunction
function Trig_P7_Revive_Actions takes nothing returns nothing
call AddHeroXPSwapped(-20,udg_kittys[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],false)
call AdjustPlayerStateBJ(-15,GetOwningPlayer(GetTriggerUnit()),PLAYER_STATE_RESOURCE_GOLD)
call AdjustPlayerStateBJ(30,Player(6),PLAYER_STATE_RESOURCE_GOLD)
call AddHeroXPSwapped(50,gg_unit_E000_0007,true)
call SetUnitPositionLocFacingBJ(udg_kittys[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],GetUnitLoc(gg_unit_E000_0007),GetUnitFacing(gg_unit_E000_0007))
call SetUnitFacingTimed(udg_kittys[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],GetUnitFacing(gg_unit_E000_0007),0)
call ReviveHeroLoc(udg_kittys[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],GetUnitLoc(GetTriggerUnit()),true)
call PanCameraToTimedLocForPlayer(GetOwningPlayer(GetTriggerUnit()),GetUnitLoc(udg_kittys[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]),0.00)
call ForceAddPlayerSimple(GetOwningPlayer(GetTriggerUnit()),udg_Players)
call ForceRemovePlayerSimple(GetOwningPlayer(GetTriggerUnit()),udg_Losers)
set udg_Score[7]=(udg_Score[7]+1)
call LeaderboardSetPlayerItemValueBJ(Player(6),GetLastCreatedLeaderboard(),udg_Score[7])
call LeaderboardSortItemsBJ(GetLastCreatedLeaderboard(),bj_SORTTYPE_SORTBYVALUE,false)
set udg_Alive[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]=true
call RemoveUnit(GetTriggerUnit())
endfunction
function InitTrig_P7_Revive takes nothing returns nothing
set gg_trg_P7_Revive=CreateTrigger()
call TriggerRegisterUnitInRangeSimple(gg_trg_P7_Revive,70.00,gg_unit_E000_0007)
call TriggerAddCondition(gg_trg_P7_Revive,Condition(function Trig_P7_Revive_Conditions))
call TriggerAddAction(gg_trg_P7_Revive,function Trig_P7_Revive_Actions)
endfunction
function Trig_P8_Revive_Conditions takes nothing returns boolean
if(not(IsUnitAliveBJ(gg_unit_E000_0008)==true))then
return false
endif
if(not(GetUnitTypeId(GetTriggerUnit())=='n00D'))then
return false
endif
if(not(GetOwningPlayer(GetTriggerUnit())!=Player(7)))then
return false
endif
return true
endfunction
function Trig_P8_Revive_Actions takes nothing returns nothing
call AddHeroXPSwapped(-20,udg_kittys[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],false)
call AdjustPlayerStateBJ(-15,GetOwningPlayer(GetTriggerUnit()),PLAYER_STATE_RESOURCE_GOLD)
call AdjustPlayerStateBJ(30,Player(7),PLAYER_STATE_RESOURCE_GOLD)
call AddHeroXPSwapped(50,gg_unit_E000_0008,true)
call SetUnitPositionLocFacingBJ(udg_kittys[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],GetUnitLoc(gg_unit_E000_0008),GetUnitFacing(gg_unit_E000_0008))
call SetUnitFacingTimed(udg_kittys[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],GetUnitFacing(gg_unit_E000_0008),0)
call ReviveHeroLoc(udg_kittys[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],GetUnitLoc(GetTriggerUnit()),true)
call PanCameraToTimedLocForPlayer(GetOwningPlayer(GetTriggerUnit()),GetUnitLoc(udg_kittys[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]),0.00)
call ForceAddPlayerSimple(GetOwningPlayer(GetTriggerUnit()),udg_Players)
call ForceRemovePlayerSimple(GetOwningPlayer(GetTriggerUnit()),udg_Losers)
set udg_Score[8]=(udg_Score[8]+1)
call LeaderboardSetPlayerItemValueBJ(Player(7),GetLastCreatedLeaderboard(),udg_Score[8])
call LeaderboardSortItemsBJ(GetLastCreatedLeaderboard(),bj_SORTTYPE_SORTBYVALUE,false)
set udg_Alive[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]=true
call RemoveUnit(GetTriggerUnit())
endfunction
function InitTrig_P8_Revive takes nothing returns nothing
set gg_trg_P8_Revive=CreateTrigger()
call TriggerRegisterUnitInRangeSimple(gg_trg_P8_Revive,70.00,gg_unit_E000_0008)
call TriggerAddCondition(gg_trg_P8_Revive,Condition(function Trig_P8_Revive_Conditions))
call TriggerAddAction(gg_trg_P8_Revive,function Trig_P8_Revive_Actions)
endfunction
function Trig_P9_Revive_Conditions takes nothing returns boolean
if(not(IsUnitAliveBJ(gg_unit_E000_0009)==true))then
return false
endif
if(not(GetUnitTypeId(GetTriggerUnit())=='n00D'))then
return false
endif
if(not(GetOwningPlayer(GetTriggerUnit())!=Player(8)))then
return false
endif
return true
endfunction
function Trig_P9_Revive_Actions takes nothing returns nothing
call AddHeroXPSwapped(-20,udg_kittys[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],false)
call AdjustPlayerStateBJ(-15,GetOwningPlayer(GetTriggerUnit()),PLAYER_STATE_RESOURCE_GOLD)
call AdjustPlayerStateBJ(30,Player(8),PLAYER_STATE_RESOURCE_GOLD)
call AddHeroXPSwapped(50,gg_unit_E000_0009,true)
call SetUnitPositionLocFacingBJ(udg_kittys[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],GetUnitLoc(gg_unit_E000_0009),GetUnitFacing(gg_unit_E000_0009))
call SetUnitFacingTimed(udg_kittys[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],GetUnitFacing(gg_unit_E000_0009),0)
call ReviveHeroLoc(udg_kittys[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],GetUnitLoc(GetTriggerUnit()),true)
call PanCameraToTimedLocForPlayer(GetOwningPlayer(GetTriggerUnit()),GetUnitLoc(udg_kittys[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]),0.00)
call ForceAddPlayerSimple(GetOwningPlayer(GetTriggerUnit()),udg_Players)
call ForceRemovePlayerSimple(GetOwningPlayer(GetTriggerUnit()),udg_Losers)
set udg_Score[9]=(udg_Score[9]+1)
call LeaderboardSetPlayerItemValueBJ(Player(8),GetLastCreatedLeaderboard(),udg_Score[9])
call LeaderboardSortItemsBJ(GetLastCreatedLeaderboard(),bj_SORTTYPE_SORTBYVALUE,false)
set udg_Alive[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]=true
call RemoveUnit(GetTriggerUnit())
endfunction
function InitTrig_P9_Revive takes nothing returns nothing
set gg_trg_P9_Revive=CreateTrigger()
call TriggerRegisterUnitInRangeSimple(gg_trg_P9_Revive,70.00,gg_unit_E000_0009)
call TriggerAddCondition(gg_trg_P9_Revive,Condition(function Trig_P9_Revive_Conditions))
call TriggerAddAction(gg_trg_P9_Revive,function Trig_P9_Revive_Actions)
endfunction
function Trig_P10_Revive_Conditions takes nothing returns boolean
if(not(IsUnitAliveBJ(gg_unit_E000_0010)==true))then
return false
endif
if(not(GetUnitTypeId(GetTriggerUnit())=='n00D'))then
return false
endif
if(not(GetOwningPlayer(GetTriggerUnit())!=Player(9)))then
return false
endif
return true
endfunction
function Trig_P10_Revive_Actions takes nothing returns nothing
call AddHeroXPSwapped(-20,udg_kittys[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],false)
call AdjustPlayerStateBJ(-15,GetOwningPlayer(GetTriggerUnit()),PLAYER_STATE_RESOURCE_GOLD)
call AdjustPlayerStateBJ(30,Player(9),PLAYER_STATE_RESOURCE_GOLD)
call AddHeroXPSwapped(50,gg_unit_E000_0010,true)
call SetUnitPositionLocFacingBJ(udg_kittys[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],GetUnitLoc(gg_unit_E000_0010),GetUnitFacing(gg_unit_E000_0010))
call SetUnitFacingTimed(udg_kittys[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],GetUnitFacing(gg_unit_E000_0010),0)
call ReviveHeroLoc(udg_kittys[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],GetUnitLoc(GetTriggerUnit()),true)
call PanCameraToTimedLocForPlayer(GetOwningPlayer(GetTriggerUnit()),GetUnitLoc(udg_kittys[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]),0.00)
call ForceAddPlayerSimple(GetOwningPlayer(GetTriggerUnit()),udg_Players)
call ForceRemovePlayerSimple(GetOwningPlayer(GetTriggerUnit()),udg_Losers)
set udg_Score[10]=(udg_Score[10]+1)
call LeaderboardSetPlayerItemValueBJ(Player(9),GetLastCreatedLeaderboard(),udg_Score[10])
call LeaderboardSortItemsBJ(GetLastCreatedLeaderboard(),bj_SORTTYPE_SORTBYVALUE,false)
set udg_Alive[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]=true
call RemoveUnit(GetTriggerUnit())
endfunction
function InitTrig_P10_Revive takes nothing returns nothing
set gg_trg_P10_Revive=CreateTrigger()
call TriggerRegisterUnitInRangeSimple(gg_trg_P10_Revive,70.00,gg_unit_E000_0010)
call TriggerAddCondition(gg_trg_P10_Revive,Condition(function Trig_P10_Revive_Conditions))
call TriggerAddAction(gg_trg_P10_Revive,function Trig_P10_Revive_Actions)
endfunction
function Trig_P11_Revive_Conditions takes nothing returns boolean
if(not(IsUnitAliveBJ(gg_unit_E000_0011)==true))then
return false
endif
if(not(GetUnitTypeId(GetTriggerUnit())=='n00D'))then
return false
endif
if(not(GetOwningPlayer(GetTriggerUnit())!=Player(10)))then
return false
endif
return true
endfunction
function Trig_P11_Revive_Actions takes nothing returns nothing
call AddHeroXPSwapped(-20,udg_kittys[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],false)
call AdjustPlayerStateBJ(-15,GetOwningPlayer(GetTriggerUnit()),PLAYER_STATE_RESOURCE_GOLD)
call AdjustPlayerStateBJ(30,Player(10),PLAYER_STATE_RESOURCE_GOLD)
call AddHeroXPSwapped(50,gg_unit_E000_0011,true)
call SetUnitPositionLocFacingBJ(udg_kittys[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],GetUnitLoc(gg_unit_E000_0011),GetUnitFacing(gg_unit_E000_0011))
call SetUnitFacingTimed(udg_kittys[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],GetUnitFacing(gg_unit_E000_0011),0)
call ReviveHeroLoc(udg_kittys[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],GetUnitLoc(GetTriggerUnit()),true)
call PanCameraToTimedLocForPlayer(GetOwningPlayer(GetTriggerUnit()),GetUnitLoc(udg_kittys[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]),0.00)
call ForceAddPlayerSimple(GetOwningPlayer(GetTriggerUnit()),udg_Players)
call ForceRemovePlayerSimple(GetOwningPlayer(GetTriggerUnit()),udg_Losers)
set udg_Score[11]=(udg_Score[11]+1)
call LeaderboardSetPlayerItemValueBJ(Player(10),GetLastCreatedLeaderboard(),udg_Score[11])
call LeaderboardSortItemsBJ(GetLastCreatedLeaderboard(),bj_SORTTYPE_SORTBYVALUE,false)
set udg_Alive[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]=true
call RemoveUnit(GetTriggerUnit())
endfunction
function InitTrig_P11_Revive takes nothing returns nothing
set gg_trg_P11_Revive=CreateTrigger()
call TriggerRegisterUnitInRangeSimple(gg_trg_P11_Revive,70.00,gg_unit_E000_0011)
call TriggerAddCondition(gg_trg_P11_Revive,Condition(function Trig_P11_Revive_Conditions))
call TriggerAddAction(gg_trg_P11_Revive,function Trig_P11_Revive_Actions)
endfunction
function Trig_P1_Conditions takes nothing returns boolean
if(not(IsUnitAliveBJ(gg_unit_E000_0001)==true))then
return false
endif
if(not(R2I(GetUnitFlyHeight(gg_unit_E000_0001))==0))then
return false
endif
if(not(GetUnitTypeId(GetTriggerUnit())=='nwwg'))then
return false
endif
return true
endfunction
function Trig_P1_Func010001 takes nothing returns boolean
return(udg_Alive[1]==true)
endfunction
function Trig_P1_Actions takes nothing returns nothing
call DisableTrigger(udg_slideTriggers[1])
call CreateNUnitsAtLoc(1,'n00D',Player(0),GetUnitLoc(gg_unit_E000_0001),bj_UNIT_FACING)
call KillUnit(gg_unit_E000_0001)
call ForceRemovePlayerSimple(Player(0),udg_Players)
call ForceAddPlayerSimple(Player(0),udg_Losers)
call ConditionalTriggerExecute(gg_trg_Game_Over)
if(Trig_P1_Func010001())then
call DoNothing()
else
return
endif
set udg_Score[1]=(udg_Score[1]-1)
call LeaderboardSetPlayerItemValueBJ(Player(0),GetLastCreatedLeaderboard(),udg_Score[1])
call LeaderboardSortItemsBJ(GetLastCreatedLeaderboard(),bj_SORTTYPE_SORTBYVALUE,false)
set udg_Alive[1]=false
endfunction
function InitTrig_P1 takes nothing returns nothing
set gg_trg_P1=CreateTrigger()
call TriggerRegisterUnitInRangeSimple(gg_trg_P1,I2R(GetUnitPointValueByType('E000')),gg_unit_E000_0001)
call TriggerAddCondition(gg_trg_P1,Condition(function Trig_P1_Conditions))
call TriggerAddAction(gg_trg_P1,function Trig_P1_Actions)
endfunction
function Trig_P2_Conditions takes nothing returns boolean
if(not(IsUnitAliveBJ(gg_unit_E000_0002)==true))then
return false
endif
if(not(R2I(GetUnitFlyHeight(gg_unit_E000_0002))==0))then
return false
endif
if(not(GetUnitTypeId(GetTriggerUnit())=='nwwg'))then
return false
endif
return true
endfunction
function Trig_P2_Func009001 takes nothing returns boolean
return(udg_Alive[2]==true)
endfunction
function Trig_P2_Actions takes nothing returns nothing
call DisableTrigger(udg_slideTriggers[2])
call CreateNUnitsAtLoc(1,'n00D',Player(1),GetUnitLoc(gg_unit_E000_0002),bj_UNIT_FACING)
call KillUnit(gg_unit_E000_0002)
call ForceRemovePlayerSimple(Player(1),udg_Players)
call ForceAddPlayerSimple(Player(1),udg_Losers)
call ConditionalTriggerExecute(gg_trg_Game_Over)
if(Trig_P2_Func009001())then
call DoNothing()
else
return
endif
set udg_Score[2]=(udg_Score[2]-1)
call LeaderboardSetPlayerItemValueBJ(Player(1),GetLastCreatedLeaderboard(),udg_Score[2])
call LeaderboardSortItemsBJ(GetLastCreatedLeaderboard(),bj_SORTTYPE_SORTBYVALUE,false)
set udg_Alive[2]=false
endfunction
function InitTrig_P2 takes nothing returns nothing
set gg_trg_P2=CreateTrigger()
call TriggerRegisterUnitInRangeSimple(gg_trg_P2,I2R(GetUnitPointValueByType('E000')),gg_unit_E000_0002)
call TriggerAddCondition(gg_trg_P2,Condition(function Trig_P2_Conditions))
call TriggerAddAction(gg_trg_P2,function Trig_P2_Actions)
endfunction
function Trig_P3_Conditions takes nothing returns boolean
if(not(IsUnitAliveBJ(gg_unit_E000_0003)==true))then
return false
endif
if(not(R2I(GetUnitFlyHeight(gg_unit_E000_0003))==0))then
return false
endif
if(not(GetUnitTypeId(GetTriggerUnit())=='nwwg'))then
return false
endif
return true
endfunction
function Trig_P3_Func010001 takes nothing returns boolean
return(udg_Alive[3]==true)
endfunction
function Trig_P3_Actions takes nothing returns nothing
call DisableTrigger(udg_slideTriggers[3])
call CreateNUnitsAtLoc(1,'n00D',Player(2),GetUnitLoc(gg_unit_E000_0003),bj_UNIT_FACING)
call KillUnit(gg_unit_E000_0003)
call ForceRemovePlayerSimple(Player(2),udg_Players)
call ForceAddPlayerSimple(Player(2),udg_Losers)
call ConditionalTriggerExecute(gg_trg_Game_Over)
if(Trig_P3_Func010001())then
call DoNothing()
else
return
endif
set udg_Score[3]=(udg_Score[3]-1)
call LeaderboardSetPlayerItemValueBJ(Player(2),GetLastCreatedLeaderboard(),udg_Score[3])
call LeaderboardSortItemsBJ(GetLastCreatedLeaderboard(),bj_SORTTYPE_SORTBYVALUE,false)
set udg_Alive[3]=false
endfunction
function InitTrig_P3 takes nothing returns nothing
set gg_trg_P3=CreateTrigger()
call TriggerRegisterUnitInRangeSimple(gg_trg_P3,I2R(GetUnitPointValueByType('E000')),gg_unit_E000_0003)
call TriggerAddCondition(gg_trg_P3,Condition(function Trig_P3_Conditions))
call TriggerAddAction(gg_trg_P3,function Trig_P3_Actions)
endfunction
function Trig_P4_Conditions takes nothing returns boolean
if(not(IsUnitAliveBJ(gg_unit_E000_0004)==true))then
return false
endif
if(not(R2I(GetUnitFlyHeight(gg_unit_E000_0004))==0))then
return false
endif
if(not(GetUnitTypeId(GetTriggerUnit())=='nwwg'))then
return false
endif
return true
endfunction
function Trig_P4_Func010001 takes nothing returns boolean
return(udg_Alive[4]==true)
endfunction
function Trig_P4_Actions takes nothing returns nothing
call DisableTrigger(udg_slideTriggers[4])
call CreateNUnitsAtLoc(1,'n00D',Player(3),GetUnitLoc(gg_unit_E000_0004),bj_UNIT_FACING)
call KillUnit(gg_unit_E000_0004)
call ForceRemovePlayerSimple(Player(3),udg_Players)
call ForceAddPlayerSimple(Player(3),udg_Losers)
call ConditionalTriggerExecute(gg_trg_Game_Over)
if(Trig_P4_Func010001())then
call DoNothing()
else
return
endif
set udg_Score[4]=(udg_Score[4]-1)
call LeaderboardSetPlayerItemValueBJ(Player(3),GetLastCreatedLeaderboard(),udg_Score[4])
call LeaderboardSortItemsBJ(GetLastCreatedLeaderboard(),bj_SORTTYPE_SORTBYVALUE,false)
set udg_Alive[4]=false
endfunction
function InitTrig_P4 takes nothing returns nothing
set gg_trg_P4=CreateTrigger()
call TriggerRegisterUnitInRangeSimple(gg_trg_P4,I2R(GetUnitPointValueByType('E000')),gg_unit_E000_0004)
call TriggerAddCondition(gg_trg_P4,Condition(function Trig_P4_Conditions))
call TriggerAddAction(gg_trg_P4,function Trig_P4_Actions)
endfunction
function Trig_P5_Conditions takes nothing returns boolean
if(not(IsUnitAliveBJ(gg_unit_E000_0005)==true))then
return false
endif
if(not(R2I(GetUnitFlyHeight(gg_unit_E000_0005))==0))then
return false
endif
if(not(GetUnitTypeId(GetTriggerUnit())=='nwwg'))then
return false
endif
return true
endfunction
function Trig_P5_Func010001 takes nothing returns boolean
return(udg_Alive[5]==true)
endfunction
function Trig_P5_Actions takes nothing returns nothing
call DisableTrigger(udg_slideTriggers[5])
call CreateNUnitsAtLoc(1,'n00D',Player(4),GetUnitLoc(gg_unit_E000_0005),bj_UNIT_FACING)
call KillUnit(gg_unit_E000_0005)
call ForceRemovePlayerSimple(Player(4),udg_Players)
call ForceAddPlayerSimple(Player(4),udg_Losers)
call ConditionalTriggerExecute(gg_trg_Game_Over)
if(Trig_P5_Func010001())then
call DoNothing()
else
return
endif
set udg_Score[5]=(udg_Score[5]-1)
call LeaderboardSetPlayerItemValueBJ(Player(4),GetLastCreatedLeaderboard(),udg_Score[5])
call LeaderboardSortItemsBJ(GetLastCreatedLeaderboard(),bj_SORTTYPE_SORTBYVALUE,false)
set udg_Alive[5]=false
endfunction
function InitTrig_P5 takes nothing returns nothing
set gg_trg_P5=CreateTrigger()
call TriggerRegisterUnitInRangeSimple(gg_trg_P5,I2R(GetUnitPointValueByType('E000')),gg_unit_E000_0005)
call TriggerAddCondition(gg_trg_P5,Condition(function Trig_P5_Conditions))
call TriggerAddAction(gg_trg_P5,function Trig_P5_Actions)
endfunction
function Trig_P6_Conditions takes nothing returns boolean
if(not(IsUnitAliveBJ(gg_unit_E000_0006)==true))then
return false
endif
if(not(R2I(GetUnitFlyHeight(gg_unit_E000_0006))==0))then
return false
endif
if(not(GetUnitTypeId(GetTriggerUnit())=='nwwg'))then
return false
endif
return true
endfunction
function Trig_P6_Func010001 takes nothing returns boolean
return(udg_Alive[6]==true)
endfunction
function Trig_P6_Actions takes nothing returns nothing
call DisableTrigger(udg_slideTriggers[6])
call CreateNUnitsAtLoc(1,'n00D',Player(5),GetUnitLoc(gg_unit_E000_0006),bj_UNIT_FACING)
call KillUnit(gg_unit_E000_0006)
call ForceRemovePlayerSimple(Player(5),udg_Players)
call ForceAddPlayerSimple(Player(5),udg_Losers)
call ConditionalTriggerExecute(gg_trg_Game_Over)
if(Trig_P6_Func010001())then
call DoNothing()
else
return
endif
set udg_Score[6]=(udg_Score[6]-1)
call LeaderboardSetPlayerItemValueBJ(Player(5),GetLastCreatedLeaderboard(),udg_Score[6])
call LeaderboardSortItemsBJ(GetLastCreatedLeaderboard(),bj_SORTTYPE_SORTBYVALUE,false)
set udg_Alive[6]=false
endfunction
function InitTrig_P6 takes nothing returns nothing
set gg_trg_P6=CreateTrigger()
call TriggerRegisterUnitInRangeSimple(gg_trg_P6,I2R(GetUnitPointValueByType('E000')),gg_unit_E000_0006)
call TriggerAddCondition(gg_trg_P6,Condition(function Trig_P6_Conditions))
call TriggerAddAction(gg_trg_P6,function Trig_P6_Actions)
endfunction
function Trig_P7_Conditions takes nothing returns boolean
if(not(IsUnitAliveBJ(gg_unit_E000_0007)==true))then
return false
endif
if(not(R2I(GetUnitFlyHeight(gg_unit_E000_0007))==0))then
return false
endif
if(not(GetUnitTypeId(GetTriggerUnit())=='nwwg'))then
return false
endif
return true
endfunction
function Trig_P7_Func011001 takes nothing returns boolean
return(udg_Alive[7]==true)
endfunction
function Trig_P7_Actions takes nothing returns nothing
call DisableTrigger(udg_slideTriggers[7])
call CreateNUnitsAtLoc(1,'n00D',Player(6),GetUnitLoc(gg_unit_E000_0007),bj_UNIT_FACING)
call KillUnit(gg_unit_E000_0007)
call ForceRemovePlayerSimple(Player(6),udg_Players)
call ForceAddPlayerSimple(Player(6),udg_Losers)
call ConditionalTriggerExecute(gg_trg_Game_Over)
if(Trig_P7_Func011001())then
call DoNothing()
else
return
endif
set udg_Score[7]=(udg_Score[7]-1)
call LeaderboardSetPlayerItemValueBJ(Player(6),GetLastCreatedLeaderboard(),udg_Score[7])
call LeaderboardSortItemsBJ(GetLastCreatedLeaderboard(),bj_SORTTYPE_SORTBYVALUE,false)
set udg_Alive[7]=false
endfunction
function InitTrig_P7 takes nothing returns nothing
set gg_trg_P7=CreateTrigger()
call TriggerRegisterUnitInRangeSimple(gg_trg_P7,I2R(GetUnitPointValueByType('E000')),gg_unit_E000_0007)
call TriggerAddCondition(gg_trg_P7,Condition(function Trig_P7_Conditions))
call TriggerAddAction(gg_trg_P7,function Trig_P7_Actions)
endfunction
function Trig_P8_Conditions takes nothing returns boolean
if(not(IsUnitAliveBJ(gg_unit_E000_0008)==true))then
return false
endif
if(not(R2I(GetUnitFlyHeight(gg_unit_E000_0008))==0))then
return false
endif
if(not(GetUnitTypeId(GetTriggerUnit())=='nwwg'))then
return false
endif
return true
endfunction
function Trig_P8_Func011001 takes nothing returns boolean
return(udg_Alive[8]==true)
endfunction
function Trig_P8_Actions takes nothing returns nothing
call DisableTrigger(udg_slideTriggers[8])
call CreateNUnitsAtLoc(1,'n00D',Player(7),GetUnitLoc(gg_unit_E000_0008),bj_UNIT_FACING)
call KillUnit(gg_unit_E000_0008)
call ForceRemovePlayerSimple(Player(7),udg_Players)
call ForceAddPlayerSimple(Player(7),udg_Losers)
call ConditionalTriggerExecute(gg_trg_Game_Over)
if(Trig_P8_Func011001())then
call DoNothing()
else
return
endif
set udg_Score[8]=(udg_Score[8]-1)
call LeaderboardSetPlayerItemValueBJ(Player(7),GetLastCreatedLeaderboard(),udg_Score[8])
call LeaderboardSortItemsBJ(GetLastCreatedLeaderboard(),bj_SORTTYPE_SORTBYVALUE,false)
set udg_Alive[8]=false
endfunction
function InitTrig_P8 takes nothing returns nothing
set gg_trg_P8=CreateTrigger()
call TriggerRegisterUnitInRangeSimple(gg_trg_P8,I2R(GetUnitPointValueByType('E000')),gg_unit_E000_0008)
call TriggerAddCondition(gg_trg_P8,Condition(function Trig_P8_Conditions))
call TriggerAddAction(gg_trg_P8,function Trig_P8_Actions)
endfunction
function Trig_P9_Conditions takes nothing returns boolean
if(not(IsUnitAliveBJ(gg_unit_E000_0009)==true))then
return false
endif
if(not(R2I(GetUnitFlyHeight(gg_unit_E000_0009))==0))then
return false
endif
if(not(GetUnitTypeId(GetTriggerUnit())=='nwwg'))then
return false
endif
return true
endfunction
function Trig_P9_Func011001 takes nothing returns boolean
return(udg_Alive[9]==true)
endfunction
function Trig_P9_Actions takes nothing returns nothing
call DisableTrigger(udg_slideTriggers[9])
call CreateNUnitsAtLoc(1,'n00D',Player(8),GetUnitLoc(gg_unit_E000_0009),bj_UNIT_FACING)
call KillUnit(gg_unit_E000_0009)
call ForceRemovePlayerSimple(Player(8),udg_Players)
call ForceAddPlayerSimple(Player(8),udg_Losers)
call ConditionalTriggerExecute(gg_trg_Game_Over)
if(Trig_P9_Func011001())then
call DoNothing()
else
return
endif
set udg_Score[9]=(udg_Score[9]-1)
call LeaderboardSetPlayerItemValueBJ(Player(8),GetLastCreatedLeaderboard(),udg_Score[9])
call LeaderboardSortItemsBJ(GetLastCreatedLeaderboard(),bj_SORTTYPE_SORTBYVALUE,false)
set udg_Alive[9]=false
endfunction
function InitTrig_P9 takes nothing returns nothing
set gg_trg_P9=CreateTrigger()
call TriggerRegisterUnitInRangeSimple(gg_trg_P9,I2R(GetUnitPointValueByType('E000')),gg_unit_E000_0009)
call TriggerAddCondition(gg_trg_P9,Condition(function Trig_P9_Conditions))
call TriggerAddAction(gg_trg_P9,function Trig_P9_Actions)
endfunction
function Trig_P10_Conditions takes nothing returns boolean
if(not(IsUnitAliveBJ(gg_unit_E000_0010)==true))then
return false
endif
if(not(R2I(GetUnitFlyHeight(gg_unit_E000_0010))==0))then
return false
endif
if(not(GetUnitTypeId(GetTriggerUnit())=='nwwg'))then
return false
endif
return true
endfunction
function Trig_P10_Func011001 takes nothing returns boolean
return(udg_Alive[10]==true)
endfunction
function Trig_P10_Actions takes nothing returns nothing
call DisableTrigger(udg_slideTriggers[10])
call CreateNUnitsAtLoc(1,'n00D',Player(9),GetUnitLoc(gg_unit_E000_0010),bj_UNIT_FACING)
call KillUnit(gg_unit_E000_0010)
call ForceRemovePlayerSimple(Player(9),udg_Players)
call ForceAddPlayerSimple(Player(9),udg_Losers)
call ConditionalTriggerExecute(gg_trg_Game_Over)
if(Trig_P10_Func011001())then
call DoNothing()
else
return
endif
set udg_Score[10]=(udg_Score[10]-1)
call LeaderboardSetPlayerItemValueBJ(Player(9),GetLastCreatedLeaderboard(),udg_Score[10])
call LeaderboardSortItemsBJ(GetLastCreatedLeaderboard(),bj_SORTTYPE_SORTBYVALUE,false)
set udg_Alive[10]=false
endfunction
function InitTrig_P10 takes nothing returns nothing
set gg_trg_P10=CreateTrigger()
call TriggerRegisterUnitInRangeSimple(gg_trg_P10,I2R(GetUnitPointValueByType('E000')),gg_unit_E000_0010)
call TriggerAddCondition(gg_trg_P10,Condition(function Trig_P10_Conditions))
call TriggerAddAction(gg_trg_P10,function Trig_P10_Actions)
endfunction
function Trig_P11_Conditions takes nothing returns boolean
if(not(IsUnitAliveBJ(gg_unit_E000_0011)==true))then
return false
endif
if(not(R2I(GetUnitFlyHeight(gg_unit_E000_0011))==0))then
return false
endif
if(not(GetUnitTypeId(GetTriggerUnit())=='nwwg'))then
return false
endif
return true
endfunction
function Trig_P11_Func010001 takes nothing returns boolean
return(udg_Alive[11]==true)
endfunction
function Trig_P11_Actions takes nothing returns nothing
call DisableTrigger(udg_slideTriggers[11])
call CreateNUnitsAtLoc(1,'n00D',Player(10),GetUnitLoc(gg_unit_E000_0011),bj_UNIT_FACING)
call KillUnit(gg_unit_E000_0011)
call ForceRemovePlayerSimple(Player(10),udg_Players)
call ForceAddPlayerSimple(Player(10),udg_Losers)
call ConditionalTriggerExecute(gg_trg_Game_Over)
if(Trig_P11_Func010001())then
call DoNothing()
else
return
endif
set udg_Score[11]=(udg_Score[11]-1)
call LeaderboardSetPlayerItemValueBJ(Player(10),GetLastCreatedLeaderboard(),udg_Score[10])
call LeaderboardSortItemsBJ(GetLastCreatedLeaderboard(),bj_SORTTYPE_SORTBYVALUE,false)
set udg_Alive[11]=false
endfunction
function InitTrig_P11 takes nothing returns nothing
set gg_trg_P11=CreateTrigger()
call TriggerRegisterUnitInRangeSimple(gg_trg_P11,I2R(GetUnitPointValueByType('E000')),gg_unit_E000_0011)
call TriggerAddCondition(gg_trg_P11,Condition(function Trig_P11_Conditions))
call TriggerAddAction(gg_trg_P11,function Trig_P11_Actions)
endfunction
function Trig_Untitled_Trigger_001_Actions takes nothing returns nothing
call ClearMapMusicBJ()
endfunction
function InitTrig_Untitled_Trigger_001 takes nothing returns nothing
set gg_trg_Untitled_Trigger_001=CreateTrigger()
call TriggerRegisterTimerEventSingle(gg_trg_Untitled_Trigger_001,1.00)
call TriggerAddAction(gg_trg_Untitled_Trigger_001,function Trig_Untitled_Trigger_001_Actions)
endfunction
function Trig_Axel_F_Actions takes nothing returns nothing
call PlaySoundBJ(gg_snd_filename_Kung_Fu_Panda)
call SetSoundVolumeBJ(gg_snd_filename_Kung_Fu_Panda,100.00)
endfunction
function InitTrig_Axel_F takes nothing returns nothing
set gg_trg_Axel_F=CreateTrigger()
call TriggerRegisterTimerEventSingle(gg_trg_Axel_F,4.00)
call TriggerAddAction(gg_trg_Axel_F,function Trig_Axel_F_Actions)
endfunction
function Trig_Wolf_Area_One_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='nwwg'))then
return false
endif
return true
endfunction
function Trig_Wolf_Area_One_Actions takes nothing returns nothing
call IssuePointOrderLoc(GetTriggerUnit(),"move",GetRandomLocInRect(gg_rct_Wolf_Area_One))
endfunction
function InitTrig_Wolf_Area_One takes nothing returns nothing
set gg_trg_Wolf_Area_One=CreateTrigger()
call TriggerRegisterLeaveRectSimple(gg_trg_Wolf_Area_One,gg_rct_Wolf_Area_One)
call TriggerAddCondition(gg_trg_Wolf_Area_One,Condition(function Trig_Wolf_Area_One_Conditions))
call TriggerAddAction(gg_trg_Wolf_Area_One,function Trig_Wolf_Area_One_Actions)
endfunction
function Trig_Wolf_Area_Two_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='nwwg'))then
return false
endif
return true
endfunction
function Trig_Wolf_Area_Two_Actions takes nothing returns nothing
call IssuePointOrderLoc(GetTriggerUnit(),"move",GetRandomLocInRect(gg_rct_Wolf_Area_Two))
endfunction
function InitTrig_Wolf_Area_Two takes nothing returns nothing
set gg_trg_Wolf_Area_Two=CreateTrigger()
call TriggerRegisterLeaveRectSimple(gg_trg_Wolf_Area_Two,gg_rct_Wolf_Area_Two)
call TriggerAddCondition(gg_trg_Wolf_Area_Two,Condition(function Trig_Wolf_Area_Two_Conditions))
call TriggerAddAction(gg_trg_Wolf_Area_Two,function Trig_Wolf_Area_Two_Actions)
endfunction
function Trig_Wolf_Area_Three_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='nwwg'))then
return false
endif
return true
endfunction
function Trig_Wolf_Area_Three_Actions takes nothing returns nothing
call IssuePointOrderLoc(GetTriggerUnit(),"move",GetRandomLocInRect(gg_rct_Wofl_Area_Three))
endfunction
function InitTrig_Wolf_Area_Three takes nothing returns nothing
set gg_trg_Wolf_Area_Three=CreateTrigger()
call TriggerRegisterLeaveRectSimple(gg_trg_Wolf_Area_Three,gg_rct_Wofl_Area_Three)
call TriggerAddCondition(gg_trg_Wolf_Area_Three,Condition(function Trig_Wolf_Area_Three_Conditions))
call TriggerAddAction(gg_trg_Wolf_Area_Three,function Trig_Wolf_Area_Three_Actions)
endfunction
function Trig_Wolf_Area_Four_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='nwwg'))then
return false
endif
return true
endfunction
function Trig_Wolf_Area_Four_Actions takes nothing returns nothing
call IssuePointOrderLoc(GetTriggerUnit(),"move",GetRandomLocInRect(gg_rct_Wolf_Area_Four))
endfunction
function InitTrig_Wolf_Area_Four takes nothing returns nothing
set gg_trg_Wolf_Area_Four=CreateTrigger()
call TriggerRegisterLeaveRectSimple(gg_trg_Wolf_Area_Four,gg_rct_Wolf_Area_Four)
call TriggerAddCondition(gg_trg_Wolf_Area_Four,Condition(function Trig_Wolf_Area_Four_Conditions))
call TriggerAddAction(gg_trg_Wolf_Area_Four,function Trig_Wolf_Area_Four_Actions)
endfunction
function Trig_Wolf_Area_Five_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='nwwg'))then
return false
endif
return true
endfunction
function Trig_Wolf_Area_Five_Actions takes nothing returns nothing
call IssuePointOrderLoc(GetTriggerUnit(),"move",GetRandomLocInRect(gg_rct_Wofl_Area_Five))
endfunction
function InitTrig_Wolf_Area_Five takes nothing returns nothing
set gg_trg_Wolf_Area_Five=CreateTrigger()
call TriggerRegisterLeaveRectSimple(gg_trg_Wolf_Area_Five,gg_rct_Wofl_Area_Five)
call TriggerAddCondition(gg_trg_Wolf_Area_Five,Condition(function Trig_Wolf_Area_Five_Conditions))
call TriggerAddAction(gg_trg_Wolf_Area_Five,function Trig_Wolf_Area_Five_Actions)
endfunction
function Trig_Wolf_Area_Six_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='nwwg'))then
return false
endif
return true
endfunction
function Trig_Wolf_Area_Six_Actions takes nothing returns nothing
call IssuePointOrderLoc(GetTriggerUnit(),"move",GetRandomLocInRect(gg_rct_Wolf_Area_Six))
endfunction
function InitTrig_Wolf_Area_Six takes nothing returns nothing
set gg_trg_Wolf_Area_Six=CreateTrigger()
call TriggerRegisterLeaveRectSimple(gg_trg_Wolf_Area_Six,gg_rct_Wolf_Area_Six)
call TriggerAddCondition(gg_trg_Wolf_Area_Six,Condition(function Trig_Wolf_Area_Six_Conditions))
call TriggerAddAction(gg_trg_Wolf_Area_Six,function Trig_Wolf_Area_Six_Actions)
endfunction
function Trig_Wolf_Area_Seven_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='nwwg'))then
return false
endif
return true
endfunction
function Trig_Wolf_Area_Seven_Actions takes nothing returns nothing
call IssuePointOrderLoc(GetTriggerUnit(),"move",GetRandomLocInRect(gg_rct_Wolf_Area_Seven))
endfunction
function InitTrig_Wolf_Area_Seven takes nothing returns nothing
set gg_trg_Wolf_Area_Seven=CreateTrigger()
call TriggerRegisterLeaveRectSimple(gg_trg_Wolf_Area_Seven,gg_rct_Wolf_Area_Seven)
call TriggerAddCondition(gg_trg_Wolf_Area_Seven,Condition(function Trig_Wolf_Area_Seven_Conditions))
call TriggerAddAction(gg_trg_Wolf_Area_Seven,function Trig_Wolf_Area_Seven_Actions)
endfunction
function Trig_Wolf_Area_Eight_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='nwwg'))then
return false
endif
return true
endfunction
function Trig_Wolf_Area_Eight_Actions takes nothing returns nothing
call IssuePointOrderLoc(GetTriggerUnit(),"move",GetRandomLocInRect(gg_rct_Wolf_Area_Eight))
endfunction
function InitTrig_Wolf_Area_Eight takes nothing returns nothing
set gg_trg_Wolf_Area_Eight=CreateTrigger()
call TriggerRegisterLeaveRectSimple(gg_trg_Wolf_Area_Eight,gg_rct_Wolf_Area_Eight)
call TriggerAddCondition(gg_trg_Wolf_Area_Eight,Condition(function Trig_Wolf_Area_Eight_Conditions))
call TriggerAddAction(gg_trg_Wolf_Area_Eight,function Trig_Wolf_Area_Eight_Actions)
endfunction
function Trig_Wolf_Area_Nine_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='nwwg'))then
return false
endif
return true
endfunction
function Trig_Wolf_Area_Nine_Actions takes nothing returns nothing
call IssuePointOrderLoc(GetTriggerUnit(),"move",GetRandomLocInRect(gg_rct_Wofl_Area_Nine))
endfunction
function InitTrig_Wolf_Area_Nine takes nothing returns nothing
set gg_trg_Wolf_Area_Nine=CreateTrigger()
call TriggerRegisterLeaveRectSimple(gg_trg_Wolf_Area_Nine,gg_rct_Wofl_Area_Nine)
call TriggerAddCondition(gg_trg_Wolf_Area_Nine,Condition(function Trig_Wolf_Area_Nine_Conditions))
call TriggerAddAction(gg_trg_Wolf_Area_Nine,function Trig_Wolf_Area_Nine_Actions)
endfunction
function Trig_Wolf_Area_Ten_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='nwwg'))then
return false
endif
return true
endfunction
function Trig_Wolf_Area_Ten_Actions takes nothing returns nothing
call IssuePointOrderLoc(GetTriggerUnit(),"move",GetRandomLocInRect(gg_rct_Wolf_Area_Ten))
endfunction
function InitTrig_Wolf_Area_Ten takes nothing returns nothing
set gg_trg_Wolf_Area_Ten=CreateTrigger()
call TriggerRegisterLeaveRectSimple(gg_trg_Wolf_Area_Ten,gg_rct_Wolf_Area_Ten)
call TriggerAddCondition(gg_trg_Wolf_Area_Ten,Condition(function Trig_Wolf_Area_Ten_Conditions))
call TriggerAddAction(gg_trg_Wolf_Area_Ten,function Trig_Wolf_Area_Ten_Actions)
endfunction
function Trig_Wolf_Area_Eleven_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='nwwg'))then
return false
endif
return true
endfunction
function Trig_Wolf_Area_Eleven_Actions takes nothing returns nothing
call IssuePointOrderLoc(GetTriggerUnit(),"move",GetRandomLocInRect(gg_rct_Wofl_Area_Eleven))
endfunction
function InitTrig_Wolf_Area_Eleven takes nothing returns nothing
set gg_trg_Wolf_Area_Eleven=CreateTrigger()
call TriggerRegisterLeaveRectSimple(gg_trg_Wolf_Area_Eleven,gg_rct_Wofl_Area_Eleven)
call TriggerAddCondition(gg_trg_Wolf_Area_Eleven,Condition(function Trig_Wolf_Area_Eleven_Conditions))
call TriggerAddAction(gg_trg_Wolf_Area_Eleven,function Trig_Wolf_Area_Eleven_Actions)
endfunction
function Trig_Wolf_Area_Twelve_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='nwwg'))then
return false
endif
return true
endfunction
function Trig_Wolf_Area_Twelve_Actions takes nothing returns nothing
call IssuePointOrderLoc(GetTriggerUnit(),"move",GetRandomLocInRect(gg_rct_Wolf_Area_Twelve))
endfunction
function InitTrig_Wolf_Area_Twelve takes nothing returns nothing
set gg_trg_Wolf_Area_Twelve=CreateTrigger()
call TriggerRegisterLeaveRectSimple(gg_trg_Wolf_Area_Twelve,gg_rct_Wolf_Area_Twelve)
call TriggerAddCondition(gg_trg_Wolf_Area_Twelve,Condition(function Trig_Wolf_Area_Twelve_Conditions))
call TriggerAddAction(gg_trg_Wolf_Area_Twelve,function Trig_Wolf_Area_Twelve_Actions)
endfunction
function Trig_Wolf_Area_Thirteen_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='nwwg'))then
return false
endif
return true
endfunction
function Trig_Wolf_Area_Thirteen_Actions takes nothing returns nothing
call IssuePointOrderLoc(GetTriggerUnit(),"move",GetRandomLocInRect(gg_rct_Wolf_Area_Thirteen))
endfunction
function InitTrig_Wolf_Area_Thirteen takes nothing returns nothing
set gg_trg_Wolf_Area_Thirteen=CreateTrigger()
call TriggerRegisterLeaveRectSimple(gg_trg_Wolf_Area_Thirteen,gg_rct_Wolf_Area_Thirteen)
call TriggerAddCondition(gg_trg_Wolf_Area_Thirteen,Condition(function Trig_Wolf_Area_Thirteen_Conditions))
call TriggerAddAction(gg_trg_Wolf_Area_Thirteen,function Trig_Wolf_Area_Thirteen_Actions)
endfunction
function Trig_Wolf_Area_Fourteen_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='nwwg'))then
return false
endif
return true
endfunction
function Trig_Wolf_Area_Fourteen_Actions takes nothing returns nothing
call IssuePointOrderLoc(GetTriggerUnit(),"move",GetRandomLocInRect(gg_rct_Wolf_Area_Fourteen))
endfunction
function InitTrig_Wolf_Area_Fourteen takes nothing returns nothing
set gg_trg_Wolf_Area_Fourteen=CreateTrigger()
call TriggerRegisterLeaveRectSimple(gg_trg_Wolf_Area_Fourteen,gg_rct_Wolf_Area_Fourteen)
call TriggerAddCondition(gg_trg_Wolf_Area_Fourteen,Condition(function Trig_Wolf_Area_Fourteen_Conditions))
call TriggerAddAction(gg_trg_Wolf_Area_Fourteen,function Trig_Wolf_Area_Fourteen_Actions)
endfunction
function Trig_Wolf_Area_Fifteen_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='nwwg'))then
return false
endif
return true
endfunction
function Trig_Wolf_Area_Fifteen_Actions takes nothing returns nothing
call IssuePointOrderLoc(GetTriggerUnit(),"move",GetRandomLocInRect(gg_rct_Wolf_Area_Fifteen))
endfunction
function InitTrig_Wolf_Area_Fifteen takes nothing returns nothing
set gg_trg_Wolf_Area_Fifteen=CreateTrigger()
call TriggerRegisterLeaveRectSimple(gg_trg_Wolf_Area_Fifteen,gg_rct_Wolf_Area_Fifteen)
call TriggerAddCondition(gg_trg_Wolf_Area_Fifteen,Condition(function Trig_Wolf_Area_Fifteen_Conditions))
call TriggerAddAction(gg_trg_Wolf_Area_Fifteen,function Trig_Wolf_Area_Fifteen_Actions)
endfunction
function Trig_Spawn_Func002Func002001001002 takes nothing returns boolean
return(GetUnitUserData(GetFilterUnit())==udg_activeItem)
endfunction
function Trig_Spawn_Func002C takes nothing returns boolean
if(not(IsItemOwned(udg_currentItems[udg_activeItem])==false))then
return false
endif
return true
endfunction
function Trig_Spawn_Func004001 takes nothing returns boolean
return(udg_count<=100)
endfunction
function Trig_Spawn_Func005001 takes nothing returns boolean
return(udg_count<=98)
endfunction
function Trig_Spawn_Func006001 takes nothing returns boolean
return(udg_count<=95)
endfunction
function Trig_Spawn_Func007001 takes nothing returns boolean
return(udg_count<=92)
endfunction
function Trig_Spawn_Func008001 takes nothing returns boolean
return(udg_count<=89)
endfunction
function Trig_Spawn_Func009001 takes nothing returns boolean
return(udg_count<=86)
endfunction
function Trig_Spawn_Func010001 takes nothing returns boolean
return(udg_count<=80)
endfunction
function Trig_Spawn_Func011001 takes nothing returns boolean
return(udg_count<=70)
endfunction
function Trig_Spawn_Func012001 takes nothing returns boolean
return(udg_count<=60)
endfunction
function Trig_Spawn_Func013001 takes nothing returns boolean
return(udg_count<=40)
endfunction
function Trig_Spawn_Func014001 takes nothing returns boolean
return(udg_count<=20)
endfunction
function Trig_Spawn_Actions takes nothing returns nothing
set udg_activeItem=(ModuloInteger(udg_activeItem,6)+1)
if(Trig_Spawn_Func002C())then
call RemoveUnit(GroupPickRandomUnit(GetUnitsOfPlayerMatching(Player(PLAYER_NEUTRAL_PASSIVE),Condition(function Trig_Spawn_Func002Func002001001002))))
call RemoveItem(udg_currentItems[udg_activeItem])
else
call DoNothing()
endif
set udg_count=GetRandomInt(1,100)
if(Trig_Spawn_Func004001())then
set udg_toDrop='tkno'
else
call DoNothing()
endif
if(Trig_Spawn_Func005001())then
set udg_toDrop='texp'
else
call DoNothing()
endif
if(Trig_Spawn_Func006001())then
set udg_toDrop='I000'
else
call DoNothing()
endif
if(Trig_Spawn_Func007001())then
set udg_toDrop='I001'
else
call DoNothing()
endif
if(Trig_Spawn_Func008001())then
set udg_toDrop='I002'
else
call DoNothing()
endif
if(Trig_Spawn_Func009001())then
set udg_toDrop='I003'
else
call DoNothing()
endif
if(Trig_Spawn_Func010001())then
set udg_toDrop='penr'
else
call DoNothing()
endif
if(Trig_Spawn_Func011001())then
set udg_toDrop='rwiz'
else
call DoNothing()
endif
if(Trig_Spawn_Func012001())then
set udg_toDrop='bspd'
else
call DoNothing()
endif
if(Trig_Spawn_Func013001())then
set udg_toDrop='pspd'
else
call DoNothing()
endif
if(Trig_Spawn_Func014001())then
set udg_toDrop='pman'
else
call DoNothing()
endif
call CreateNUnitsAtLoc(1,'n00C',Player(PLAYER_NEUTRAL_PASSIVE),GetRandomLocInRect(GetPlayableMapRect()),bj_UNIT_FACING)
call SetUnitUserData(GetLastCreatedUnit(),udg_activeItem)
call CreateItemLoc(udg_toDrop,GetUnitLoc(GetLastCreatedUnit()))
set udg_currentItems[udg_activeItem]=GetLastCreatedItem()
endfunction
function InitTrig_Spawn takes nothing returns nothing
set gg_trg_Spawn=CreateTrigger()
call TriggerRegisterTimerEventPeriodic(gg_trg_Spawn,5.00)
call TriggerAddAction(gg_trg_Spawn,function Trig_Spawn_Actions)
endfunction
function Trig_Collect_1_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='n00C'))then
return false
endif
return true
endfunction
function Trig_Collect_1_Actions takes nothing returns nothing
call UnitAddItemSwapped(udg_currentItems[GetUnitUserData(GetTriggerUnit())],gg_unit_E000_0001)
call RemoveUnit(GetTriggerUnit())
endfunction
function InitTrig_Collect_1 takes nothing returns nothing
set gg_trg_Collect_1=CreateTrigger()
call TriggerRegisterUnitInRangeSimple(gg_trg_Collect_1,70.00,gg_unit_E000_0001)
call TriggerAddCondition(gg_trg_Collect_1,Condition(function Trig_Collect_1_Conditions))
call TriggerAddAction(gg_trg_Collect_1,function Trig_Collect_1_Actions)
endfunction
function Trig_Collect_2_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='n00C'))then
return false
endif
return true
endfunction
function Trig_Collect_2_Actions takes nothing returns nothing
call UnitAddItemSwapped(udg_currentItems[GetUnitUserData(GetTriggerUnit())],gg_unit_E000_0002)
call RemoveUnit(GetTriggerUnit())
endfunction
function InitTrig_Collect_2 takes nothing returns nothing
set gg_trg_Collect_2=CreateTrigger()
call TriggerRegisterUnitInRangeSimple(gg_trg_Collect_2,70.00,gg_unit_E000_0002)
call TriggerAddCondition(gg_trg_Collect_2,Condition(function Trig_Collect_2_Conditions))
call TriggerAddAction(gg_trg_Collect_2,function Trig_Collect_2_Actions)
endfunction
function Trig_Collect_3_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='n00C'))then
return false
endif
return true
endfunction
function Trig_Collect_3_Actions takes nothing returns nothing
call UnitAddItemSwapped(udg_currentItems[GetUnitUserData(GetTriggerUnit())],gg_unit_E000_0003)
call RemoveUnit(GetTriggerUnit())
endfunction
function InitTrig_Collect_3 takes nothing returns nothing
set gg_trg_Collect_3=CreateTrigger()
call TriggerRegisterUnitInRangeSimple(gg_trg_Collect_3,70.00,gg_unit_E000_0003)
call TriggerAddCondition(gg_trg_Collect_3,Condition(function Trig_Collect_3_Conditions))
call TriggerAddAction(gg_trg_Collect_3,function Trig_Collect_3_Actions)
endfunction
function Trig_Collect_4_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='n00C'))then
return false
endif
return true
endfunction
function Trig_Collect_4_Actions takes nothing returns nothing
call UnitAddItemSwapped(udg_currentItems[GetUnitUserData(GetTriggerUnit())],gg_unit_E000_0004)
call RemoveUnit(GetTriggerUnit())
endfunction
function InitTrig_Collect_4 takes nothing returns nothing
set gg_trg_Collect_4=CreateTrigger()
call TriggerRegisterUnitInRangeSimple(gg_trg_Collect_4,70.00,gg_unit_E000_0004)
call TriggerAddCondition(gg_trg_Collect_4,Condition(function Trig_Collect_4_Conditions))
call TriggerAddAction(gg_trg_Collect_4,function Trig_Collect_4_Actions)
endfunction
function Trig_Collect_5_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='n00C'))then
return false
endif
return true
endfunction
function Trig_Collect_5_Actions takes nothing returns nothing
call UnitAddItemSwapped(udg_currentItems[GetUnitUserData(GetTriggerUnit())],gg_unit_E000_0005)
call RemoveUnit(GetTriggerUnit())
endfunction
function InitTrig_Collect_5 takes nothing returns nothing
set gg_trg_Collect_5=CreateTrigger()
call TriggerRegisterUnitInRangeSimple(gg_trg_Collect_5,70.00,gg_unit_E000_0005)
call TriggerAddCondition(gg_trg_Collect_5,Condition(function Trig_Collect_5_Conditions))
call TriggerAddAction(gg_trg_Collect_5,function Trig_Collect_5_Actions)
endfunction
function Trig_Collect_6_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='n00C'))then
return false
endif
return true
endfunction
function Trig_Collect_6_Actions takes nothing returns nothing
call UnitAddItemSwapped(udg_currentItems[GetUnitUserData(GetTriggerUnit())],gg_unit_E000_0006)
call RemoveUnit(GetTriggerUnit())
endfunction
function InitTrig_Collect_6 takes nothing returns nothing
set gg_trg_Collect_6=CreateTrigger()
call TriggerRegisterUnitInRangeSimple(gg_trg_Collect_6,70.00,gg_unit_E000_0006)
call TriggerAddCondition(gg_trg_Collect_6,Condition(function Trig_Collect_6_Conditions))
call TriggerAddAction(gg_trg_Collect_6,function Trig_Collect_6_Actions)
endfunction
function Trig_Collect_7_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='n00C'))then
return false
endif
return true
endfunction
function Trig_Collect_7_Actions takes nothing returns nothing
call UnitAddItemSwapped(udg_currentItems[GetUnitUserData(GetTriggerUnit())],gg_unit_E000_0007)
call RemoveUnit(GetTriggerUnit())
endfunction
function InitTrig_Collect_7 takes nothing returns nothing
set gg_trg_Collect_7=CreateTrigger()
call TriggerRegisterUnitInRangeSimple(gg_trg_Collect_7,70.00,gg_unit_E000_0007)
call TriggerAddCondition(gg_trg_Collect_7,Condition(function Trig_Collect_7_Conditions))
call TriggerAddAction(gg_trg_Collect_7,function Trig_Collect_7_Actions)
endfunction
function Trig_Collect_8_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='n00C'))then
return false
endif
return true
endfunction
function Trig_Collect_8_Actions takes nothing returns nothing
call UnitAddItemSwapped(udg_currentItems[GetUnitUserData(GetTriggerUnit())],gg_unit_E000_0008)
call RemoveUnit(GetTriggerUnit())
endfunction
function InitTrig_Collect_8 takes nothing returns nothing
set gg_trg_Collect_8=CreateTrigger()
call TriggerRegisterUnitInRangeSimple(gg_trg_Collect_8,70.00,gg_unit_E000_0008)
call TriggerAddCondition(gg_trg_Collect_8,Condition(function Trig_Collect_8_Conditions))
call TriggerAddAction(gg_trg_Collect_8,function Trig_Collect_8_Actions)
endfunction
function Trig_Collect_9_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='n00C'))then
return false
endif
return true
endfunction
function Trig_Collect_9_Actions takes nothing returns nothing
call UnitAddItemSwapped(udg_currentItems[GetUnitUserData(GetTriggerUnit())],gg_unit_E000_0009)
call RemoveUnit(GetTriggerUnit())
endfunction
function InitTrig_Collect_9 takes nothing returns nothing
set gg_trg_Collect_9=CreateTrigger()
call TriggerRegisterUnitInRangeSimple(gg_trg_Collect_9,70.00,gg_unit_E000_0009)
call TriggerAddCondition(gg_trg_Collect_9,Condition(function Trig_Collect_9_Conditions))
call TriggerAddAction(gg_trg_Collect_9,function Trig_Collect_9_Actions)
endfunction
function Trig_Collect_10_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='n00C'))then
return false
endif
return true
endfunction
function Trig_Collect_10_Actions takes nothing returns nothing
call UnitAddItemSwapped(udg_currentItems[GetUnitUserData(GetTriggerUnit())],gg_unit_E000_0010)
call RemoveUnit(GetTriggerUnit())
endfunction
function InitTrig_Collect_10 takes nothing returns nothing
set gg_trg_Collect_10=CreateTrigger()
call TriggerRegisterUnitInRangeSimple(gg_trg_Collect_10,70.00,gg_unit_E000_0010)
call TriggerAddCondition(gg_trg_Collect_10,Condition(function Trig_Collect_10_Conditions))
call TriggerAddAction(gg_trg_Collect_10,function Trig_Collect_10_Actions)
endfunction
function Trig_Collect_11_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='n00C'))then
return false
endif
return true
endfunction
function Trig_Collect_11_Actions takes nothing returns nothing
call UnitAddItemSwapped(udg_currentItems[GetUnitUserData(GetTriggerUnit())],gg_unit_E000_0011)
call RemoveUnit(GetTriggerUnit())
endfunction
function InitTrig_Collect_11 takes nothing returns nothing
set gg_trg_Collect_11=CreateTrigger()
call TriggerRegisterUnitInRangeSimple(gg_trg_Collect_11,70.00,gg_unit_E000_0011)
call TriggerAddCondition(gg_trg_Collect_11,Condition(function Trig_Collect_11_Conditions))
call TriggerAddAction(gg_trg_Collect_11,function Trig_Collect_11_Actions)
endfunction
function Trig_SideGuardTop1_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='E000'))then
return false
endif
return true
endfunction
function Trig_SideGuardTop1_Func001C takes nothing returns boolean
if(not(GetUnitFacing(GetTriggerUnit())>90.00))then
return false
endif
if(not(GetUnitFacing(GetTriggerUnit())<270.00))then
return false
endif
return true
endfunction
function Trig_SideGuardTop1_Actions takes nothing returns nothing
if(Trig_SideGuardTop1_Func001C())then
set udg_angle=180.00
else
set udg_angle=0.00
endif
call SetUnitPositionLocFacingBJ(GetTriggerUnit(),GetUnitLoc(GetTriggerUnit()),udg_angle)
call SetUnitFacingTimed(GetTriggerUnit(),udg_angle,0)
endfunction
function InitTrig_SideGuardTop1 takes nothing returns nothing
set gg_trg_SideGuardTop1=CreateTrigger()
call TriggerRegisterEnterRectSimple(gg_trg_SideGuardTop1,gg_rct_SideGuardTop1)
call TriggerAddCondition(gg_trg_SideGuardTop1,Condition(function Trig_SideGuardTop1_Conditions))
call TriggerAddAction(gg_trg_SideGuardTop1,function Trig_SideGuardTop1_Actions)
endfunction
function Trig_SideGuardTop2_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='E000'))then
return false
endif
return true
endfunction
function Trig_SideGuardTop2_Func001C takes nothing returns boolean
if(not(GetUnitFacing(GetTriggerUnit())>90.00))then
return false
endif
if(not(GetUnitFacing(GetTriggerUnit())<270.00))then
return false
endif
return true
endfunction
function Trig_SideGuardTop2_Actions takes nothing returns nothing
if(Trig_SideGuardTop2_Func001C())then
set udg_angle=180.00
else
set udg_angle=0.00
endif
call SetUnitPositionLocFacingBJ(GetTriggerUnit(),GetUnitLoc(GetTriggerUnit()),udg_angle)
call SetUnitFacingTimed(GetTriggerUnit(),udg_angle,0)
endfunction
function InitTrig_SideGuardTop2 takes nothing returns nothing
set gg_trg_SideGuardTop2=CreateTrigger()
call TriggerRegisterEnterRectSimple(gg_trg_SideGuardTop2,gg_rct_SideGuardTop2)
call TriggerAddCondition(gg_trg_SideGuardTop2,Condition(function Trig_SideGuardTop2_Conditions))
call TriggerAddAction(gg_trg_SideGuardTop2,function Trig_SideGuardTop2_Actions)
endfunction
function Trig_SideGuardTop3_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='E000'))then
return false
endif
return true
endfunction
function Trig_SideGuardTop3_Func001C takes nothing returns boolean
if(not(GetUnitFacing(GetTriggerUnit())>90.00))then
return false
endif
if(not(GetUnitFacing(GetTriggerUnit())<270.00))then
return false
endif
return true
endfunction
function Trig_SideGuardTop3_Actions takes nothing returns nothing
if(Trig_SideGuardTop3_Func001C())then
set udg_angle=180.00
else
set udg_angle=0.00
endif
call SetUnitPositionLocFacingBJ(GetTriggerUnit(),GetUnitLoc(GetTriggerUnit()),udg_angle)
call SetUnitFacingTimed(GetTriggerUnit(),udg_angle,0)
endfunction
function InitTrig_SideGuardTop3 takes nothing returns nothing
set gg_trg_SideGuardTop3=CreateTrigger()
call TriggerRegisterEnterRectSimple(gg_trg_SideGuardTop3,gg_rct_SideGuardTop3)
call TriggerAddCondition(gg_trg_SideGuardTop3,Condition(function Trig_SideGuardTop3_Conditions))
call TriggerAddAction(gg_trg_SideGuardTop3,function Trig_SideGuardTop3_Actions)
endfunction
function Trig_SideGuardTop4_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='E000'))then
return false
endif
return true
endfunction
function Trig_SideGuardTop4_Func001C takes nothing returns boolean
if(not(GetUnitFacing(GetTriggerUnit())>90.00))then
return false
endif
if(not(GetUnitFacing(GetTriggerUnit())<270.00))then
return false
endif
return true
endfunction
function Trig_SideGuardTop4_Actions takes nothing returns nothing
if(Trig_SideGuardTop4_Func001C())then
set udg_angle=180.00
else
set udg_angle=0.00
endif
call SetUnitPositionLocFacingBJ(GetTriggerUnit(),GetUnitLoc(GetTriggerUnit()),udg_angle)
call SetUnitFacingTimed(GetTriggerUnit(),udg_angle,0)
endfunction
function InitTrig_SideGuardTop4 takes nothing returns nothing
set gg_trg_SideGuardTop4=CreateTrigger()
call TriggerRegisterEnterRectSimple(gg_trg_SideGuardTop4,gg_rct_SideGuardTop4)
call TriggerAddCondition(gg_trg_SideGuardTop4,Condition(function Trig_SideGuardTop4_Conditions))
call TriggerAddAction(gg_trg_SideGuardTop4,function Trig_SideGuardTop4_Actions)
endfunction
function Trig_SideGuardTop5_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='E000'))then
return false
endif
return true
endfunction
function Trig_SideGuardTop5_Func001C takes nothing returns boolean
if(not(GetUnitFacing(GetTriggerUnit())>90.00))then
return false
endif
if(not(GetUnitFacing(GetTriggerUnit())<270.00))then
return false
endif
return true
endfunction
function Trig_SideGuardTop5_Actions takes nothing returns nothing
if(Trig_SideGuardTop5_Func001C())then
set udg_angle=180.00
else
set udg_angle=0.00
endif
call SetUnitPositionLocFacingBJ(GetTriggerUnit(),GetUnitLoc(GetTriggerUnit()),udg_angle)
call SetUnitFacingTimed(GetTriggerUnit(),udg_angle,0)
endfunction
function InitTrig_SideGuardTop5 takes nothing returns nothing
set gg_trg_SideGuardTop5=CreateTrigger()
call TriggerRegisterEnterRectSimple(gg_trg_SideGuardTop5,gg_rct_SideGuardTop5)
call TriggerAddCondition(gg_trg_SideGuardTop5,Condition(function Trig_SideGuardTop5_Conditions))
call TriggerAddAction(gg_trg_SideGuardTop5,function Trig_SideGuardTop5_Actions)
endfunction
function Trig_SideGuardTop6_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='E000'))then
return false
endif
return true
endfunction
function Trig_SideGuardTop6_Func001C takes nothing returns boolean
if(not(GetUnitFacing(GetTriggerUnit())>90.00))then
return false
endif
if(not(GetUnitFacing(GetTriggerUnit())<270.00))then
return false
endif
return true
endfunction
function Trig_SideGuardTop6_Actions takes nothing returns nothing
if(Trig_SideGuardTop6_Func001C())then
set udg_angle=180.00
else
set udg_angle=0.00
endif
call SetUnitPositionLocFacingBJ(GetTriggerUnit(),GetUnitLoc(GetTriggerUnit()),udg_angle)
call SetUnitFacingTimed(GetTriggerUnit(),udg_angle,0)
endfunction
function InitTrig_SideGuardTop6 takes nothing returns nothing
set gg_trg_SideGuardTop6=CreateTrigger()
call TriggerRegisterEnterRectSimple(gg_trg_SideGuardTop6,gg_rct_SideGuardTop6)
call TriggerAddCondition(gg_trg_SideGuardTop6,Condition(function Trig_SideGuardTop6_Conditions))
call TriggerAddAction(gg_trg_SideGuardTop6,function Trig_SideGuardTop6_Actions)
endfunction
function Trig_SideGuardTop7_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='E000'))then
return false
endif
return true
endfunction
function Trig_SideGuardTop7_Func001C takes nothing returns boolean
if(not(GetUnitFacing(GetTriggerUnit())>90.00))then
return false
endif
if(not(GetUnitFacing(GetTriggerUnit())<270.00))then
return false
endif
return true
endfunction
function Trig_SideGuardTop7_Actions takes nothing returns nothing
if(Trig_SideGuardTop7_Func001C())then
set udg_angle=180.00
else
set udg_angle=0.00
endif
call SetUnitPositionLocFacingBJ(GetTriggerUnit(),GetUnitLoc(GetTriggerUnit()),udg_angle)
call SetUnitFacingTimed(GetTriggerUnit(),udg_angle,0)
endfunction
function InitTrig_SideGuardTop7 takes nothing returns nothing
set gg_trg_SideGuardTop7=CreateTrigger()
call TriggerRegisterEnterRectSimple(gg_trg_SideGuardTop7,gg_rct_SideGuardTop7)
call TriggerAddCondition(gg_trg_SideGuardTop7,Condition(function Trig_SideGuardTop7_Conditions))
call TriggerAddAction(gg_trg_SideGuardTop7,function Trig_SideGuardTop7_Actions)
endfunction
function Trig_SideGuardTop8_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='E000'))then
return false
endif
return true
endfunction
function Trig_SideGuardTop8_Func001C takes nothing returns boolean
if(not(GetUnitFacing(GetTriggerUnit())>90.00))then
return false
endif
if(not(GetUnitFacing(GetTriggerUnit())<270.00))then
return false
endif
return true
endfunction
function Trig_SideGuardTop8_Actions takes nothing returns nothing
if(Trig_SideGuardTop8_Func001C())then
set udg_angle=180.00
else
set udg_angle=0.00
endif
call SetUnitPositionLocFacingBJ(GetTriggerUnit(),GetUnitLoc(GetTriggerUnit()),udg_angle)
call SetUnitFacingTimed(GetTriggerUnit(),udg_angle,0)
endfunction
function InitTrig_SideGuardTop8 takes nothing returns nothing
set gg_trg_SideGuardTop8=CreateTrigger()
call TriggerRegisterEnterRectSimple(gg_trg_SideGuardTop8,gg_rct_SideGuardTop8)
call TriggerAddCondition(gg_trg_SideGuardTop8,Condition(function Trig_SideGuardTop8_Conditions))
call TriggerAddAction(gg_trg_SideGuardTop8,function Trig_SideGuardTop8_Actions)
endfunction
function Trig_SideGuardBottom1_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='E000'))then
return false
endif
return true
endfunction
function Trig_SideGuardBottom1_Func001C takes nothing returns boolean
if(not(GetUnitFacing(GetTriggerUnit())>90.00))then
return false
endif
if(not(GetUnitFacing(GetTriggerUnit())<270.00))then
return false
endif
return true
endfunction
function Trig_SideGuardBottom1_Actions takes nothing returns nothing
if(Trig_SideGuardBottom1_Func001C())then
set udg_angle=180.00
else
set udg_angle=0.00
endif
call SetUnitPositionLocFacingBJ(GetTriggerUnit(),GetUnitLoc(GetTriggerUnit()),udg_angle)
call SetUnitFacingTimed(GetTriggerUnit(),udg_angle,0)
endfunction
function InitTrig_SideGuardBottom1 takes nothing returns nothing
set gg_trg_SideGuardBottom1=CreateTrigger()
call TriggerRegisterEnterRectSimple(gg_trg_SideGuardBottom1,gg_rct_SideGuardBottom1)
call TriggerAddCondition(gg_trg_SideGuardBottom1,Condition(function Trig_SideGuardBottom1_Conditions))
call TriggerAddAction(gg_trg_SideGuardBottom1,function Trig_SideGuardBottom1_Actions)
endfunction
function Trig_SideGuardBottom2_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='E000'))then
return false
endif
return true
endfunction
function Trig_SideGuardBottom2_Func001C takes nothing returns boolean
if(not(GetUnitFacing(GetTriggerUnit())>90.00))then
return false
endif
if(not(GetUnitFacing(GetTriggerUnit())<270.00))then
return false
endif
return true
endfunction
function Trig_SideGuardBottom2_Actions takes nothing returns nothing
if(Trig_SideGuardBottom2_Func001C())then
set udg_angle=180.00
else
set udg_angle=0.00
endif
call SetUnitPositionLocFacingBJ(GetTriggerUnit(),GetUnitLoc(GetTriggerUnit()),udg_angle)
call SetUnitFacingTimed(GetTriggerUnit(),udg_angle,0)
endfunction
function InitTrig_SideGuardBottom2 takes nothing returns nothing
set gg_trg_SideGuardBottom2=CreateTrigger()
call TriggerRegisterEnterRectSimple(gg_trg_SideGuardBottom2,gg_rct_SideGuardBottom2)
call TriggerAddCondition(gg_trg_SideGuardBottom2,Condition(function Trig_SideGuardBottom2_Conditions))
call TriggerAddAction(gg_trg_SideGuardBottom2,function Trig_SideGuardBottom2_Actions)
endfunction
function Trig_SideGuardBottom3_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='E000'))then
return false
endif
return true
endfunction
function Trig_SideGuardBottom3_Func001C takes nothing returns boolean
if(not(GetUnitFacing(GetTriggerUnit())>90.00))then
return false
endif
if(not(GetUnitFacing(GetTriggerUnit())<270.00))then
return false
endif
return true
endfunction
function Trig_SideGuardBottom3_Actions takes nothing returns nothing
if(Trig_SideGuardBottom3_Func001C())then
set udg_angle=180.00
else
set udg_angle=0.00
endif
call SetUnitPositionLocFacingBJ(GetTriggerUnit(),GetUnitLoc(GetTriggerUnit()),udg_angle)
call SetUnitFacingTimed(GetTriggerUnit(),udg_angle,0)
endfunction
function InitTrig_SideGuardBottom3 takes nothing returns nothing
set gg_trg_SideGuardBottom3=CreateTrigger()
call TriggerRegisterEnterRectSimple(gg_trg_SideGuardBottom3,gg_rct_SideGuardBottom3)
call TriggerAddCondition(gg_trg_SideGuardBottom3,Condition(function Trig_SideGuardBottom3_Conditions))
call TriggerAddAction(gg_trg_SideGuardBottom3,function Trig_SideGuardBottom3_Actions)
endfunction
function Trig_SideGuardBottom4_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='E000'))then
return false
endif
return true
endfunction
function Trig_SideGuardBottom4_Func001C takes nothing returns boolean
if(not(GetUnitFacing(GetTriggerUnit())>90.00))then
return false
endif
if(not(GetUnitFacing(GetTriggerUnit())<270.00))then
return false
endif
return true
endfunction
function Trig_SideGuardBottom4_Actions takes nothing returns nothing
if(Trig_SideGuardBottom4_Func001C())then
set udg_angle=180.00
else
set udg_angle=0.00
endif
call SetUnitPositionLocFacingBJ(GetTriggerUnit(),GetUnitLoc(GetTriggerUnit()),udg_angle)
call SetUnitFacingTimed(GetTriggerUnit(),udg_angle,0)
endfunction
function InitTrig_SideGuardBottom4 takes nothing returns nothing
set gg_trg_SideGuardBottom4=CreateTrigger()
call TriggerRegisterEnterRectSimple(gg_trg_SideGuardBottom4,gg_rct_SideGuardBottom4)
call TriggerAddCondition(gg_trg_SideGuardBottom4,Condition(function Trig_SideGuardBottom4_Conditions))
call TriggerAddAction(gg_trg_SideGuardBottom4,function Trig_SideGuardBottom4_Actions)
endfunction
function Trig_SideGuardBottom5_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='E000'))then
return false
endif
return true
endfunction
function Trig_SideGuardBottom5_Func001C takes nothing returns boolean
if(not(GetUnitFacing(GetTriggerUnit())>90.00))then
return false
endif
if(not(GetUnitFacing(GetTriggerUnit())<270.00))then
return false
endif
return true
endfunction
function Trig_SideGuardBottom5_Actions takes nothing returns nothing
if(Trig_SideGuardBottom5_Func001C())then
set udg_angle=180.00
else
set udg_angle=0.00
endif
call SetUnitPositionLocFacingBJ(GetTriggerUnit(),GetUnitLoc(GetTriggerUnit()),udg_angle)
call SetUnitFacingTimed(GetTriggerUnit(),udg_angle,0)
endfunction
function InitTrig_SideGuardBottom5 takes nothing returns nothing
set gg_trg_SideGuardBottom5=CreateTrigger()
call TriggerRegisterEnterRectSimple(gg_trg_SideGuardBottom5,gg_rct_SideGuardBottom5)
call TriggerAddCondition(gg_trg_SideGuardBottom5,Condition(function Trig_SideGuardBottom5_Conditions))
call TriggerAddAction(gg_trg_SideGuardBottom5,function Trig_SideGuardBottom5_Actions)
endfunction
function Trig_SideGuardBottom6_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='E000'))then
return false
endif
return true
endfunction
function Trig_SideGuardBottom6_Func001C takes nothing returns boolean
if(not(GetUnitFacing(GetTriggerUnit())>90.00))then
return false
endif
if(not(GetUnitFacing(GetTriggerUnit())<270.00))then
return false
endif
return true
endfunction
function Trig_SideGuardBottom6_Actions takes nothing returns nothing
if(Trig_SideGuardBottom6_Func001C())then
set udg_angle=180.00
else
set udg_angle=0.00
endif
call SetUnitPositionLocFacingBJ(GetTriggerUnit(),GetUnitLoc(GetTriggerUnit()),udg_angle)
call SetUnitFacingTimed(GetTriggerUnit(),udg_angle,0)
endfunction
function InitTrig_SideGuardBottom6 takes nothing returns nothing
set gg_trg_SideGuardBottom6=CreateTrigger()
call TriggerRegisterEnterRectSimple(gg_trg_SideGuardBottom6,gg_rct_SideGuardBottom6)
call TriggerAddCondition(gg_trg_SideGuardBottom6,Condition(function Trig_SideGuardBottom6_Conditions))
call TriggerAddAction(gg_trg_SideGuardBottom6,function Trig_SideGuardBottom6_Actions)
endfunction
function Trig_SideGuardBottom7_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='E000'))then
return false
endif
return true
endfunction
function Trig_SideGuardBottom7_Func001C takes nothing returns boolean
if(not(GetUnitFacing(GetTriggerUnit())>90.00))then
return false
endif
if(not(GetUnitFacing(GetTriggerUnit())<270.00))then
return false
endif
return true
endfunction
function Trig_SideGuardBottom7_Actions takes nothing returns nothing
if(Trig_SideGuardBottom7_Func001C())then
set udg_angle=180.00
else
set udg_angle=0.00
endif
call SetUnitPositionLocFacingBJ(GetTriggerUnit(),GetUnitLoc(GetTriggerUnit()),udg_angle)
call SetUnitFacingTimed(GetTriggerUnit(),udg_angle,0)
endfunction
function InitTrig_SideGuardBottom7 takes nothing returns nothing
set gg_trg_SideGuardBottom7=CreateTrigger()
call TriggerRegisterEnterRectSimple(gg_trg_SideGuardBottom7,gg_rct_SideGuardBottom7)
call TriggerAddCondition(gg_trg_SideGuardBottom7,Condition(function Trig_SideGuardBottom7_Conditions))
call TriggerAddAction(gg_trg_SideGuardBottom7,function Trig_SideGuardBottom7_Actions)
endfunction
function Trig_SideGuardBottom8_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='E000'))then
return false
endif
return true
endfunction
function Trig_SideGuardBottom8_Func001C takes nothing returns boolean
if(not(GetUnitFacing(GetTriggerUnit())>90.00))then
return false
endif
if(not(GetUnitFacing(GetTriggerUnit())<270.00))then
return false
endif
return true
endfunction
function Trig_SideGuardBottom8_Actions takes nothing returns nothing
if(Trig_SideGuardBottom8_Func001C())then
set udg_angle=180.00
else
set udg_angle=0.00
endif
call SetUnitPositionLocFacingBJ(GetTriggerUnit(),GetUnitLoc(GetTriggerUnit()),udg_angle)
call SetUnitFacingTimed(GetTriggerUnit(),udg_angle,0)
endfunction
function InitTrig_SideGuardBottom8 takes nothing returns nothing
set gg_trg_SideGuardBottom8=CreateTrigger()
call TriggerRegisterEnterRectSimple(gg_trg_SideGuardBottom8,gg_rct_SideGuardBottom8)
call TriggerAddCondition(gg_trg_SideGuardBottom8,Condition(function Trig_SideGuardBottom8_Conditions))
call TriggerAddAction(gg_trg_SideGuardBottom8,function Trig_SideGuardBottom8_Actions)
endfunction
function Trig_SideGuardRight1_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='E000'))then
return false
endif
return true
endfunction
function Trig_SideGuardRight1_Func001C takes nothing returns boolean
if(not(GetUnitFacing(GetTriggerUnit())>0.00))then
return false
endif
if(not(GetUnitFacing(GetTriggerUnit())<180.00))then
return false
endif
return true
endfunction
function Trig_SideGuardRight1_Actions takes nothing returns nothing
if(Trig_SideGuardRight1_Func001C())then
set udg_angle=90.00
else
set udg_angle=270.00
endif
call SetUnitPositionLocFacingBJ(GetTriggerUnit(),GetUnitLoc(GetTriggerUnit()),udg_angle)
call SetUnitFacingTimed(GetTriggerUnit(),udg_angle,0)
endfunction
function InitTrig_SideGuardRight1 takes nothing returns nothing
set gg_trg_SideGuardRight1=CreateTrigger()
call TriggerRegisterEnterRectSimple(gg_trg_SideGuardRight1,gg_rct_SideGuardRight1)
call TriggerAddCondition(gg_trg_SideGuardRight1,Condition(function Trig_SideGuardRight1_Conditions))
call TriggerAddAction(gg_trg_SideGuardRight1,function Trig_SideGuardRight1_Actions)
endfunction
function Trig_SideGuardRight2_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='E000'))then
return false
endif
return true
endfunction
function Trig_SideGuardRight2_Func001C takes nothing returns boolean
if(not(GetUnitFacing(GetTriggerUnit())>0.00))then
return false
endif
if(not(GetUnitFacing(GetTriggerUnit())<180.00))then
return false
endif
return true
endfunction
function Trig_SideGuardRight2_Actions takes nothing returns nothing
if(Trig_SideGuardRight2_Func001C())then
set udg_angle=90.00
else
set udg_angle=270.00
endif
call SetUnitPositionLocFacingBJ(GetTriggerUnit(),GetUnitLoc(GetTriggerUnit()),udg_angle)
call SetUnitFacingTimed(GetTriggerUnit(),udg_angle,0)
endfunction
function InitTrig_SideGuardRight2 takes nothing returns nothing
set gg_trg_SideGuardRight2=CreateTrigger()
call TriggerRegisterEnterRectSimple(gg_trg_SideGuardRight2,gg_rct_SideGuardRight2)
call TriggerAddCondition(gg_trg_SideGuardRight2,Condition(function Trig_SideGuardRight2_Conditions))
call TriggerAddAction(gg_trg_SideGuardRight2,function Trig_SideGuardRight2_Actions)
endfunction
function Trig_SideGuardRight3_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='E000'))then
return false
endif
return true
endfunction
function Trig_SideGuardRight3_Func001C takes nothing returns boolean
if(not(GetUnitFacing(GetTriggerUnit())>0.00))then
return false
endif
if(not(GetUnitFacing(GetTriggerUnit())<180.00))then
return false
endif
return true
endfunction
function Trig_SideGuardRight3_Actions takes nothing returns nothing
if(Trig_SideGuardRight3_Func001C())then
set udg_angle=90.00
else
set udg_angle=270.00
endif
call SetUnitPositionLocFacingBJ(GetTriggerUnit(),GetUnitLoc(GetTriggerUnit()),udg_angle)
call SetUnitFacingTimed(GetTriggerUnit(),udg_angle,0)
endfunction
function InitTrig_SideGuardRight3 takes nothing returns nothing
set gg_trg_SideGuardRight3=CreateTrigger()
call TriggerRegisterEnterRectSimple(gg_trg_SideGuardRight3,gg_rct_SideGuardRight3)
call TriggerAddCondition(gg_trg_SideGuardRight3,Condition(function Trig_SideGuardRight3_Conditions))
call TriggerAddAction(gg_trg_SideGuardRight3,function Trig_SideGuardRight3_Actions)
endfunction
function Trig_SideGuardRight4_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='E000'))then
return false
endif
return true
endfunction
function Trig_SideGuardRight4_Func001C takes nothing returns boolean
if(not(GetUnitFacing(GetTriggerUnit())>0.00))then
return false
endif
if(not(GetUnitFacing(GetTriggerUnit())<180.00))then
return false
endif
return true
endfunction
function Trig_SideGuardRight4_Actions takes nothing returns nothing
if(Trig_SideGuardRight4_Func001C())then
set udg_angle=90.00
else
set udg_angle=270.00
endif
call SetUnitPositionLocFacingBJ(GetTriggerUnit(),GetUnitLoc(GetTriggerUnit()),udg_angle)
call SetUnitFacingTimed(GetTriggerUnit(),udg_angle,0)
endfunction
function InitTrig_SideGuardRight4 takes nothing returns nothing
set gg_trg_SideGuardRight4=CreateTrigger()
call TriggerRegisterEnterRectSimple(gg_trg_SideGuardRight4,gg_rct_SideGuardRight4)
call TriggerAddCondition(gg_trg_SideGuardRight4,Condition(function Trig_SideGuardRight4_Conditions))
call TriggerAddAction(gg_trg_SideGuardRight4,function Trig_SideGuardRight4_Actions)
endfunction
function Trig_SideGuardRight5_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='E000'))then
return false
endif
return true
endfunction
function Trig_SideGuardRight5_Func001C takes nothing returns boolean
if(not(GetUnitFacing(GetTriggerUnit())>0.00))then
return false
endif
if(not(GetUnitFacing(GetTriggerUnit())<180.00))then
return false
endif
return true
endfunction
function Trig_SideGuardRight5_Actions takes nothing returns nothing
if(Trig_SideGuardRight5_Func001C())then
set udg_angle=90.00
else
set udg_angle=270.00
endif
call SetUnitPositionLocFacingBJ(GetTriggerUnit(),GetUnitLoc(GetTriggerUnit()),udg_angle)
call SetUnitFacingTimed(GetTriggerUnit(),udg_angle,0)
endfunction
function InitTrig_SideGuardRight5 takes nothing returns nothing
set gg_trg_SideGuardRight5=CreateTrigger()
call TriggerRegisterEnterRectSimple(gg_trg_SideGuardRight5,gg_rct_SideGuardRight5)
call TriggerAddCondition(gg_trg_SideGuardRight5,Condition(function Trig_SideGuardRight5_Conditions))
call TriggerAddAction(gg_trg_SideGuardRight5,function Trig_SideGuardRight5_Actions)
endfunction
function Trig_SideGuardRight6_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='E000'))then
return false
endif
return true
endfunction
function Trig_SideGuardRight6_Func001C takes nothing returns boolean
if(not(GetUnitFacing(GetTriggerUnit())>0.00))then
return false
endif
if(not(GetUnitFacing(GetTriggerUnit())<180.00))then
return false
endif
return true
endfunction
function Trig_SideGuardRight6_Actions takes nothing returns nothing
if(Trig_SideGuardRight6_Func001C())then
set udg_angle=90.00
else
set udg_angle=270.00
endif
call SetUnitPositionLocFacingBJ(GetTriggerUnit(),GetUnitLoc(GetTriggerUnit()),udg_angle)
call SetUnitFacingTimed(GetTriggerUnit(),udg_angle,0)
endfunction
function InitTrig_SideGuardRight6 takes nothing returns nothing
set gg_trg_SideGuardRight6=CreateTrigger()
call TriggerRegisterEnterRectSimple(gg_trg_SideGuardRight6,gg_rct_SideGuardRight6)
call TriggerAddCondition(gg_trg_SideGuardRight6,Condition(function Trig_SideGuardRight6_Conditions))
call TriggerAddAction(gg_trg_SideGuardRight6,function Trig_SideGuardRight6_Actions)
endfunction
function Trig_SideGuardRight7_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='E000'))then
return false
endif
return true
endfunction
function Trig_SideGuardRight7_Func001C takes nothing returns boolean
if(not(GetUnitFacing(GetTriggerUnit())>0.00))then
return false
endif
if(not(GetUnitFacing(GetTriggerUnit())<180.00))then
return false
endif
return true
endfunction
function Trig_SideGuardRight7_Actions takes nothing returns nothing
if(Trig_SideGuardRight7_Func001C())then
set udg_angle=90.00
else
set udg_angle=270.00
endif
call SetUnitPositionLocFacingBJ(GetTriggerUnit(),GetUnitLoc(GetTriggerUnit()),udg_angle)
call SetUnitFacingTimed(GetTriggerUnit(),udg_angle,0)
endfunction
function InitTrig_SideGuardRight7 takes nothing returns nothing
set gg_trg_SideGuardRight7=CreateTrigger()
call TriggerRegisterEnterRectSimple(gg_trg_SideGuardRight7,gg_rct_SideGuardRight7)
call TriggerAddCondition(gg_trg_SideGuardRight7,Condition(function Trig_SideGuardRight7_Conditions))
call TriggerAddAction(gg_trg_SideGuardRight7,function Trig_SideGuardRight7_Actions)
endfunction
function Trig_SideGuardRight8_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='E000'))then
return false
endif
return true
endfunction
function Trig_SideGuardRight8_Func001C takes nothing returns boolean
if(not(GetUnitFacing(GetTriggerUnit())>0.00))then
return false
endif
if(not(GetUnitFacing(GetTriggerUnit())<180.00))then
return false
endif
return true
endfunction
function Trig_SideGuardRight8_Actions takes nothing returns nothing
if(Trig_SideGuardRight8_Func001C())then
set udg_angle=90.00
else
set udg_angle=270.00
endif
call SetUnitPositionLocFacingBJ(GetTriggerUnit(),GetUnitLoc(GetTriggerUnit()),udg_angle)
call SetUnitFacingTimed(GetTriggerUnit(),udg_angle,0)
endfunction
function InitTrig_SideGuardRight8 takes nothing returns nothing
set gg_trg_SideGuardRight8=CreateTrigger()
call TriggerRegisterEnterRectSimple(gg_trg_SideGuardRight8,gg_rct_SideGuardTop8)
call TriggerAddCondition(gg_trg_SideGuardRight8,Condition(function Trig_SideGuardRight8_Conditions))
call TriggerAddAction(gg_trg_SideGuardRight8,function Trig_SideGuardRight8_Actions)
endfunction
function Trig_SideGuardLeft3_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='E000'))then
return false
endif
return true
endfunction
function Trig_SideGuardLeft3_Func001C takes nothing returns boolean
if(not(GetUnitFacing(GetTriggerUnit())>0.00))then
return false
endif
if(not(GetUnitFacing(GetTriggerUnit())<180.00))then
return false
endif
return true
endfunction
function Trig_SideGuardLeft3_Actions takes nothing returns nothing
if(Trig_SideGuardLeft3_Func001C())then
set udg_angle=90.00
else
set udg_angle=270.00
endif
call SetUnitPositionLocFacingBJ(GetTriggerUnit(),GetUnitLoc(GetTriggerUnit()),udg_angle)
call SetUnitFacingTimed(GetTriggerUnit(),udg_angle,0)
endfunction
function InitTrig_SideGuardLeft3 takes nothing returns nothing
set gg_trg_SideGuardLeft3=CreateTrigger()
call TriggerRegisterEnterRectSimple(gg_trg_SideGuardLeft3,gg_rct_SideGuardLeft3)
call TriggerAddCondition(gg_trg_SideGuardLeft3,Condition(function Trig_SideGuardLeft3_Conditions))
call TriggerAddAction(gg_trg_SideGuardLeft3,function Trig_SideGuardLeft3_Actions)
endfunction
function Trig_SideGuardLeft4_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='E000'))then
return false
endif
return true
endfunction
function Trig_SideGuardLeft4_Func001C takes nothing returns boolean
if(not(GetUnitFacing(GetTriggerUnit())>0.00))then
return false
endif
if(not(GetUnitFacing(GetTriggerUnit())<180.00))then
return false
endif
return true
endfunction
function Trig_SideGuardLeft4_Actions takes nothing returns nothing
if(Trig_SideGuardLeft4_Func001C())then
set udg_angle=90.00
else
set udg_angle=270.00
endif
call SetUnitPositionLocFacingBJ(GetTriggerUnit(),GetUnitLoc(GetTriggerUnit()),udg_angle)
call SetUnitFacingTimed(GetTriggerUnit(),udg_angle,0)
endfunction
function InitTrig_SideGuardLeft4 takes nothing returns nothing
set gg_trg_SideGuardLeft4=CreateTrigger()
call TriggerRegisterEnterRectSimple(gg_trg_SideGuardLeft4,gg_rct_SideGuardLeft4)
call TriggerAddCondition(gg_trg_SideGuardLeft4,Condition(function Trig_SideGuardLeft4_Conditions))
call TriggerAddAction(gg_trg_SideGuardLeft4,function Trig_SideGuardLeft4_Actions)
endfunction
function Trig_SideGuardLeft5_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='E000'))then
return false
endif
return true
endfunction
function Trig_SideGuardLeft5_Func001C takes nothing returns boolean
if(not(GetUnitFacing(GetTriggerUnit())>0.00))then
return false
endif
if(not(GetUnitFacing(GetTriggerUnit())<180.00))then
return false
endif
return true
endfunction
function Trig_SideGuardLeft5_Actions takes nothing returns nothing
if(Trig_SideGuardLeft5_Func001C())then
set udg_angle=90.00
else
set udg_angle=270.00
endif
call SetUnitPositionLocFacingBJ(GetTriggerUnit(),GetUnitLoc(GetTriggerUnit()),udg_angle)
call SetUnitFacingTimed(GetTriggerUnit(),udg_angle,0)
endfunction
function InitTrig_SideGuardLeft5 takes nothing returns nothing
set gg_trg_SideGuardLeft5=CreateTrigger()
call TriggerRegisterEnterRectSimple(gg_trg_SideGuardLeft5,gg_rct_SideGuardLeft5)
call TriggerAddCondition(gg_trg_SideGuardLeft5,Condition(function Trig_SideGuardLeft5_Conditions))
call TriggerAddAction(gg_trg_SideGuardLeft5,function Trig_SideGuardLeft5_Actions)
endfunction
function Trig_SideGuardLeft6_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='E000'))then
return false
endif
return true
endfunction
function Trig_SideGuardLeft6_Func001C takes nothing returns boolean
if(not(GetUnitFacing(GetTriggerUnit())>0.00))then
return false
endif
if(not(GetUnitFacing(GetTriggerUnit())<180.00))then
return false
endif
return true
endfunction
function Trig_SideGuardLeft6_Actions takes nothing returns nothing
if(Trig_SideGuardLeft6_Func001C())then
set udg_angle=90.00
else
set udg_angle=270.00
endif
call SetUnitPositionLocFacingBJ(GetTriggerUnit(),GetUnitLoc(GetTriggerUnit()),udg_angle)
call SetUnitFacingTimed(GetTriggerUnit(),udg_angle,0)
endfunction
function InitTrig_SideGuardLeft6 takes nothing returns nothing
set gg_trg_SideGuardLeft6=CreateTrigger()
call TriggerRegisterEnterRectSimple(gg_trg_SideGuardLeft6,gg_rct_SideGuardLeft6)
call TriggerAddCondition(gg_trg_SideGuardLeft6,Condition(function Trig_SideGuardLeft6_Conditions))
call TriggerAddAction(gg_trg_SideGuardLeft6,function Trig_SideGuardLeft6_Actions)
endfunction
function Trig_SideGuardLeft7_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='E000'))then
return false
endif
return true
endfunction
function Trig_SideGuardLeft7_Func001C takes nothing returns boolean
if(not(GetUnitFacing(GetTriggerUnit())>0.00))then
return false
endif
if(not(GetUnitFacing(GetTriggerUnit())<180.00))then
return false
endif
return true
endfunction
function Trig_SideGuardLeft7_Actions takes nothing returns nothing
if(Trig_SideGuardLeft7_Func001C())then
set udg_angle=90.00
else
set udg_angle=270.00
endif
call SetUnitPositionLocFacingBJ(GetTriggerUnit(),GetUnitLoc(GetTriggerUnit()),udg_angle)
call SetUnitFacingTimed(GetTriggerUnit(),udg_angle,0)
endfunction
function InitTrig_SideGuardLeft7 takes nothing returns nothing
set gg_trg_SideGuardLeft7=CreateTrigger()
call TriggerRegisterEnterRectSimple(gg_trg_SideGuardLeft7,gg_rct_SideGuardLeft7)
call TriggerAddCondition(gg_trg_SideGuardLeft7,Condition(function Trig_SideGuardLeft7_Conditions))
call TriggerAddAction(gg_trg_SideGuardLeft7,function Trig_SideGuardLeft7_Actions)
endfunction
function Trig_SideGuardLeft8_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='E000'))then
return false
endif
return true
endfunction
function Trig_SideGuardLeft8_Func001C takes nothing returns boolean
if(not(GetUnitFacing(GetTriggerUnit())>0.00))then
return false
endif
if(not(GetUnitFacing(GetTriggerUnit())<180.00))then
return false
endif
return true
endfunction
function Trig_SideGuardLeft8_Actions takes nothing returns nothing
if(Trig_SideGuardLeft8_Func001C())then
set udg_angle=90.00
else
set udg_angle=270.00
endif
call SetUnitPositionLocFacingBJ(GetTriggerUnit(),GetUnitLoc(GetTriggerUnit()),udg_angle)
call SetUnitFacingTimed(GetTriggerUnit(),udg_angle,0)
endfunction
function InitTrig_SideGuardLeft8 takes nothing returns nothing
set gg_trg_SideGuardLeft8=CreateTrigger()
call TriggerRegisterEnterRectSimple(gg_trg_SideGuardLeft8,gg_rct_SideGuardLeft8)
call TriggerAddCondition(gg_trg_SideGuardLeft8,Condition(function Trig_SideGuardLeft8_Conditions))
call TriggerAddAction(gg_trg_SideGuardLeft8,function Trig_SideGuardLeft8_Actions)
endfunction
function Trig_Lvl1_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='E000'))then
return false
endif
if(not(GetUnitUserData(GetTriggerUnit())<1))then
return false
endif
return true
endfunction
function Trig_Lvl1_Actions takes nothing returns nothing
call AddHeroXPSwapped(R2I((150.00*Pow(1.08,I2R(udg_Score[GetConvertedPlayerId(GetTriggerPlayer())])))),GetTriggerUnit(),true)
call SetUnitUserData(GetTriggerUnit(),1)
endfunction
function InitTrig_Lvl1 takes nothing returns nothing
set gg_trg_Lvl1=CreateTrigger()
call TriggerRegisterEnterRectSimple(gg_trg_Lvl1,gg_rct_Lvl1)
call TriggerAddCondition(gg_trg_Lvl1,Condition(function Trig_Lvl1_Conditions))
call TriggerAddAction(gg_trg_Lvl1,function Trig_Lvl1_Actions)
endfunction
function Trig_Lvl2_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='E000'))then
return false
endif
if(not(GetUnitUserData(GetTriggerUnit())<2))then
return false
endif
return true
endfunction
function Trig_Lvl2_Actions takes nothing returns nothing
call AddHeroXPSwapped(R2I((150.00*Pow(1.08,I2R(udg_Score[GetConvertedPlayerId(GetTriggerPlayer())])))),GetTriggerUnit(),true)
call SetUnitUserData(GetTriggerUnit(),2)
endfunction
function InitTrig_Lvl2 takes nothing returns nothing
set gg_trg_Lvl2=CreateTrigger()
call TriggerRegisterEnterRectSimple(gg_trg_Lvl2,gg_rct_Lvl2)
call TriggerAddCondition(gg_trg_Lvl2,Condition(function Trig_Lvl2_Conditions))
call TriggerAddAction(gg_trg_Lvl2,function Trig_Lvl2_Actions)
endfunction
function Trig_Lvl3_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='E000'))then
return false
endif
if(not(GetUnitUserData(GetTriggerUnit())<3))then
return false
endif
return true
endfunction
function Trig_Lvl3_Actions takes nothing returns nothing
call AddHeroXPSwapped(R2I((150.00*Pow(1.08,I2R(udg_Score[GetConvertedPlayerId(GetTriggerPlayer())])))),GetTriggerUnit(),true)
call SetUnitUserData(GetTriggerUnit(),3)
endfunction
function InitTrig_Lvl3 takes nothing returns nothing
set gg_trg_Lvl3=CreateTrigger()
call TriggerRegisterEnterRectSimple(gg_trg_Lvl3,gg_rct_Lvl3)
call TriggerAddCondition(gg_trg_Lvl3,Condition(function Trig_Lvl3_Conditions))
call TriggerAddAction(gg_trg_Lvl3,function Trig_Lvl3_Actions)
endfunction
function Trig_Lvl4_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='E000'))then
return false
endif
if(not(GetUnitUserData(GetTriggerUnit())<4))then
return false
endif
return true
endfunction
function Trig_Lvl4_Actions takes nothing returns nothing
call AddHeroXPSwapped(R2I((150.00*Pow(1.08,I2R(udg_Score[GetConvertedPlayerId(GetTriggerPlayer())])))),GetTriggerUnit(),true)
call SetUnitUserData(GetTriggerUnit(),4)
endfunction
function InitTrig_Lvl4 takes nothing returns nothing
set gg_trg_Lvl4=CreateTrigger()
call TriggerRegisterEnterRectSimple(gg_trg_Lvl4,gg_rct_Lvl4)
call TriggerAddCondition(gg_trg_Lvl4,Condition(function Trig_Lvl4_Conditions))
call TriggerAddAction(gg_trg_Lvl4,function Trig_Lvl4_Actions)
endfunction
function Trig_Lvl5_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='E000'))then
return false
endif
if(not(GetUnitUserData(GetTriggerUnit())<5))then
return false
endif
return true
endfunction
function Trig_Lvl5_Actions takes nothing returns nothing
call AddHeroXPSwapped(R2I((150.00*Pow(1.08,I2R(udg_Score[GetConvertedPlayerId(GetTriggerPlayer())])))),GetTriggerUnit(),true)
call SetUnitUserData(GetTriggerUnit(),5)
endfunction
function InitTrig_Lvl5 takes nothing returns nothing
set gg_trg_Lvl5=CreateTrigger()
call TriggerRegisterEnterRectSimple(gg_trg_Lvl5,gg_rct_Lvl5)
call TriggerAddCondition(gg_trg_Lvl5,Condition(function Trig_Lvl5_Conditions))
call TriggerAddAction(gg_trg_Lvl5,function Trig_Lvl5_Actions)
endfunction
function Trig_Lvl6_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='E000'))then
return false
endif
if(not(GetUnitUserData(GetTriggerUnit())<6))then
return false
endif
return true
endfunction
function Trig_Lvl6_Actions takes nothing returns nothing
call AddHeroXPSwapped(R2I((150.00*Pow(1.08,I2R(udg_Score[GetConvertedPlayerId(GetTriggerPlayer())])))),GetTriggerUnit(),true)
call SetUnitUserData(GetTriggerUnit(),6)
endfunction
function InitTrig_Lvl6 takes nothing returns nothing
set gg_trg_Lvl6=CreateTrigger()
call TriggerRegisterEnterRectSimple(gg_trg_Lvl6,gg_rct_Lvl6)
call TriggerAddCondition(gg_trg_Lvl6,Condition(function Trig_Lvl6_Conditions))
call TriggerAddAction(gg_trg_Lvl6,function Trig_Lvl6_Actions)
endfunction
function Trig_Lvl7_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='E000'))then
return false
endif
if(not(GetUnitUserData(GetTriggerUnit())<7))then
return false
endif
return true
endfunction
function Trig_Lvl7_Actions takes nothing returns nothing
call AddHeroXPSwapped(R2I((150.00*Pow(1.08,I2R(udg_Score[GetConvertedPlayerId(GetTriggerPlayer())])))),GetTriggerUnit(),true)
call SetUnitUserData(GetTriggerUnit(),7)
endfunction
function InitTrig_Lvl7 takes nothing returns nothing
set gg_trg_Lvl7=CreateTrigger()
call TriggerRegisterEnterRectSimple(gg_trg_Lvl7,gg_rct_Lvl7)
call TriggerAddCondition(gg_trg_Lvl7,Condition(function Trig_Lvl7_Conditions))
call TriggerAddAction(gg_trg_Lvl7,function Trig_Lvl7_Actions)
endfunction
function Trig_Lvl8_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='E000'))then
return false
endif
if(not(GetUnitUserData(GetTriggerUnit())<8))then
return false
endif
return true
endfunction
function Trig_Lvl8_Actions takes nothing returns nothing
call AddHeroXPSwapped(R2I((150.00*Pow(1.08,I2R(udg_Score[GetConvertedPlayerId(GetTriggerPlayer())])))),GetTriggerUnit(),true)
call SetUnitUserData(GetTriggerUnit(),8)
endfunction
function InitTrig_Lvl8 takes nothing returns nothing
set gg_trg_Lvl8=CreateTrigger()
call TriggerRegisterEnterRectSimple(gg_trg_Lvl8,gg_rct_Lvl8)
call TriggerAddCondition(gg_trg_Lvl8,Condition(function Trig_Lvl8_Conditions))
call TriggerAddAction(gg_trg_Lvl8,function Trig_Lvl8_Actions)
endfunction
function Trig_Lvl9_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='E000'))then
return false
endif
if(not(GetUnitUserData(GetTriggerUnit())<9))then
return false
endif
return true
endfunction
function Trig_Lvl9_Actions takes nothing returns nothing
call AddHeroXPSwapped(R2I((150.00*Pow(1.08,I2R(udg_Score[GetConvertedPlayerId(GetTriggerPlayer())])))),GetTriggerUnit(),true)
call SetUnitUserData(GetTriggerUnit(),9)
endfunction
function InitTrig_Lvl9 takes nothing returns nothing
set gg_trg_Lvl9=CreateTrigger()
call TriggerRegisterEnterRectSimple(gg_trg_Lvl9,gg_rct_Lvl9)
call TriggerAddCondition(gg_trg_Lvl9,Condition(function Trig_Lvl9_Conditions))
call TriggerAddAction(gg_trg_Lvl9,function Trig_Lvl9_Actions)
endfunction
function Trig_Lvl10_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='E000'))then
return false
endif
if(not(GetUnitUserData(GetTriggerUnit())<10))then
return false
endif
return true
endfunction
function Trig_Lvl10_Actions takes nothing returns nothing
call AddHeroXPSwapped(R2I((150.00*Pow(1.08,I2R(udg_Score[GetConvertedPlayerId(GetTriggerPlayer())])))),GetTriggerUnit(),true)
call SetUnitUserData(GetTriggerUnit(),10)
endfunction
function InitTrig_Lvl10 takes nothing returns nothing
set gg_trg_Lvl10=CreateTrigger()
call TriggerRegisterEnterRectSimple(gg_trg_Lvl10,gg_rct_Lvl10)
call TriggerAddCondition(gg_trg_Lvl10,Condition(function Trig_Lvl10_Conditions))
call TriggerAddAction(gg_trg_Lvl10,function Trig_Lvl10_Actions)
endfunction
function Trig_Lvl11_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='E000'))then
return false
endif
if(not(GetUnitUserData(GetTriggerUnit())<11))then
return false
endif
return true
endfunction
function Trig_Lvl11_Actions takes nothing returns nothing
call AddHeroXPSwapped(R2I((150.00*Pow(1.08,I2R(udg_Score[GetConvertedPlayerId(GetTriggerPlayer())])))),GetTriggerUnit(),true)
call SetUnitUserData(GetTriggerUnit(),11)
endfunction
function InitTrig_Lvl11 takes nothing returns nothing
set gg_trg_Lvl11=CreateTrigger()
call TriggerRegisterEnterRectSimple(gg_trg_Lvl11,gg_rct_Lvl11)
call TriggerAddCondition(gg_trg_Lvl11,Condition(function Trig_Lvl11_Conditions))
call TriggerAddAction(gg_trg_Lvl11,function Trig_Lvl11_Actions)
endfunction
function Trig_Lvl12_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='E000'))then
return false
endif
if(not(GetUnitUserData(GetTriggerUnit())<12))then
return false
endif
return true
endfunction
function Trig_Lvl12_Actions takes nothing returns nothing
call AddHeroXPSwapped(R2I((150.00*Pow(1.08,I2R(udg_Score[GetConvertedPlayerId(GetTriggerPlayer())])))),GetTriggerUnit(),true)
call SetUnitUserData(GetTriggerUnit(),12)
endfunction
function InitTrig_Lvl12 takes nothing returns nothing
set gg_trg_Lvl12=CreateTrigger()
call TriggerRegisterEnterRectSimple(gg_trg_Lvl12,gg_rct_Lvl12)
call TriggerAddCondition(gg_trg_Lvl12,Condition(function Trig_Lvl12_Conditions))
call TriggerAddAction(gg_trg_Lvl12,function Trig_Lvl12_Actions)
endfunction
function Trig_Lvl13_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='E000'))then
return false
endif
if(not(GetUnitUserData(GetTriggerUnit())<13))then
return false
endif
return true
endfunction
function Trig_Lvl13_Actions takes nothing returns nothing
call AddHeroXPSwapped(R2I((150.00*Pow(1.08,I2R(udg_Score[GetConvertedPlayerId(GetTriggerPlayer())])))),GetTriggerUnit(),true)
call SetUnitUserData(GetTriggerUnit(),13)
endfunction
function InitTrig_Lvl13 takes nothing returns nothing
set gg_trg_Lvl13=CreateTrigger()
call TriggerRegisterEnterRectSimple(gg_trg_Lvl13,gg_rct_Lvl13)
call TriggerAddCondition(gg_trg_Lvl13,Condition(function Trig_Lvl13_Conditions))
call TriggerAddAction(gg_trg_Lvl13,function Trig_Lvl13_Actions)
endfunction
function Trig_Lvl14_Conditions takes nothing returns boolean
if(not(GetUnitTypeId(GetTriggerUnit())=='E000'))then
return false
endif
if(not(GetUnitUserData(GetTriggerUnit())<14))then
return false
endif
return true
endfunction
function Trig_Lvl14_Actions takes nothing returns nothing
call AddHeroXPSwapped(R2I((150.00*Pow(1.08,I2R(udg_Score[GetConvertedPlayerId(GetTriggerPlayer())])))),GetTriggerUnit(),true)
call SetUnitUserData(GetTriggerUnit(),14)
endfunction
function InitTrig_Lvl14 takes nothing returns nothing
set gg_trg_Lvl14=CreateTrigger()
call TriggerRegisterEnterRectSimple(gg_trg_Lvl14,gg_rct_Lvl14)
call TriggerAddCondition(gg_trg_Lvl14,Condition(function Trig_Lvl14_Conditions))
call TriggerAddAction(gg_trg_Lvl14,function Trig_Lvl14_Actions)
endfunction
function Trig_JUMP_effect_1_Conditions takes nothing returns boolean
if(not(GetUnitFlyHeight(gg_unit_E000_0001)>1.00))then
return false
endif
return true
endfunction
function Trig_JUMP_effect_1_Actions takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("origin",gg_unit_E000_0001,"Abilities\\Spells\\Orc\\MirrorImage\\MirrorImageCaster.mdl")
endfunction
function InitTrig_JUMP_effect_1 takes nothing returns nothing
set gg_trg_JUMP_effect_1=CreateTrigger()
call TriggerRegisterTimerEventPeriodic(gg_trg_JUMP_effect_1,0.10)
call TriggerAddCondition(gg_trg_JUMP_effect_1,Condition(function Trig_JUMP_effect_1_Conditions))
call TriggerAddAction(gg_trg_JUMP_effect_1,function Trig_JUMP_effect_1_Actions)
endfunction
function Trig_JUMP_effect_2_Conditions takes nothing returns boolean
if(not(GetUnitFlyHeight(gg_unit_E000_0002)>1.00))then
return false
endif
return true
endfunction
function Trig_JUMP_effect_2_Actions takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("origin",gg_unit_E000_0002,"Abilities\\Spells\\Orc\\MirrorImage\\MirrorImageCaster.mdl")
endfunction
function InitTrig_JUMP_effect_2 takes nothing returns nothing
set gg_trg_JUMP_effect_2=CreateTrigger()
call TriggerRegisterTimerEventPeriodic(gg_trg_JUMP_effect_2,0.10)
call TriggerAddCondition(gg_trg_JUMP_effect_2,Condition(function Trig_JUMP_effect_2_Conditions))
call TriggerAddAction(gg_trg_JUMP_effect_2,function Trig_JUMP_effect_2_Actions)
endfunction
function Trig_JUMP_effect_3_Conditions takes nothing returns boolean
if(not(GetUnitFlyHeight(gg_unit_E000_0003)>1.00))then
return false
endif
return true
endfunction
function Trig_JUMP_effect_3_Actions takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("origin",gg_unit_E000_0003,"Abilities\\Spells\\Orc\\MirrorImage\\MirrorImageCaster.mdl")
endfunction
function InitTrig_JUMP_effect_3 takes nothing returns nothing
set gg_trg_JUMP_effect_3=CreateTrigger()
call TriggerRegisterTimerEventPeriodic(gg_trg_JUMP_effect_3,0.10)
call TriggerAddCondition(gg_trg_JUMP_effect_3,Condition(function Trig_JUMP_effect_3_Conditions))
call TriggerAddAction(gg_trg_JUMP_effect_3,function Trig_JUMP_effect_3_Actions)
endfunction
function Trig_JUMP_effect_4_Conditions takes nothing returns boolean
if(not(GetUnitFlyHeight(gg_unit_E000_0004)>1.00))then
return false
endif
return true
endfunction
function Trig_JUMP_effect_4_Actions takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("origin",gg_unit_E000_0004,"Abilities\\Spells\\Orc\\MirrorImage\\MirrorImageCaster.mdl")
endfunction
function InitTrig_JUMP_effect_4 takes nothing returns nothing
set gg_trg_JUMP_effect_4=CreateTrigger()
call TriggerRegisterTimerEventPeriodic(gg_trg_JUMP_effect_4,0.10)
call TriggerAddCondition(gg_trg_JUMP_effect_4,Condition(function Trig_JUMP_effect_4_Conditions))
call TriggerAddAction(gg_trg_JUMP_effect_4,function Trig_JUMP_effect_4_Actions)
endfunction
function Trig_JUMP_effect_5_Conditions takes nothing returns boolean
if(not(GetUnitFlyHeight(gg_unit_E000_0005)>1.00))then
return false
endif
return true
endfunction
function Trig_JUMP_effect_5_Actions takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("origin",gg_unit_E000_0005,"Abilities\\Spells\\Orc\\MirrorImage\\MirrorImageCaster.mdl")
endfunction
function InitTrig_JUMP_effect_5 takes nothing returns nothing
set gg_trg_JUMP_effect_5=CreateTrigger()
call TriggerRegisterTimerEventPeriodic(gg_trg_JUMP_effect_5,0.10)
call TriggerAddCondition(gg_trg_JUMP_effect_5,Condition(function Trig_JUMP_effect_5_Conditions))
call TriggerAddAction(gg_trg_JUMP_effect_5,function Trig_JUMP_effect_5_Actions)
endfunction
function Trig_JUMP_effect_6_Conditions takes nothing returns boolean
if(not(GetUnitFlyHeight(gg_unit_E000_0006)>1.00))then
return false
endif
return true
endfunction
function Trig_JUMP_effect_6_Actions takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("origin",gg_unit_E000_0006,"Abilities\\Spells\\Orc\\MirrorImage\\MirrorImageCaster.mdl")
endfunction
function InitTrig_JUMP_effect_6 takes nothing returns nothing
set gg_trg_JUMP_effect_6=CreateTrigger()
call TriggerRegisterTimerEventPeriodic(gg_trg_JUMP_effect_6,0.10)
call TriggerAddCondition(gg_trg_JUMP_effect_6,Condition(function Trig_JUMP_effect_6_Conditions))
call TriggerAddAction(gg_trg_JUMP_effect_6,function Trig_JUMP_effect_6_Actions)
endfunction
function Trig_JUMP_effect_7_Conditions takes nothing returns boolean
if(not(GetUnitFlyHeight(gg_unit_E000_0007)>1.00))then
return false
endif
return true
endfunction
function Trig_JUMP_effect_7_Actions takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("origin",gg_unit_E000_0007,"Abilities\\Spells\\Orc\\MirrorImage\\MirrorImageCaster.mdl")
endfunction
function InitTrig_JUMP_effect_7 takes nothing returns nothing
set gg_trg_JUMP_effect_7=CreateTrigger()
call TriggerRegisterTimerEventPeriodic(gg_trg_JUMP_effect_7,0.10)
call TriggerAddCondition(gg_trg_JUMP_effect_7,Condition(function Trig_JUMP_effect_7_Conditions))
call TriggerAddAction(gg_trg_JUMP_effect_7,function Trig_JUMP_effect_7_Actions)
endfunction
function Trig_JUMP_effect_8_Conditions takes nothing returns boolean
if(not(GetUnitFlyHeight(gg_unit_E000_0008)>1.00))then
return false
endif
return true
endfunction
function Trig_JUMP_effect_8_Actions takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("origin",gg_unit_E000_0008,"Abilities\\Spells\\Orc\\MirrorImage\\MirrorImageCaster.mdl")
endfunction
function InitTrig_JUMP_effect_8 takes nothing returns nothing
set gg_trg_JUMP_effect_8=CreateTrigger()
call TriggerRegisterTimerEventPeriodic(gg_trg_JUMP_effect_8,0.10)
call TriggerAddCondition(gg_trg_JUMP_effect_8,Condition(function Trig_JUMP_effect_8_Conditions))
call TriggerAddAction(gg_trg_JUMP_effect_8,function Trig_JUMP_effect_8_Actions)
endfunction
function Trig_JUMP_effect_9_Conditions takes nothing returns boolean
if(not(GetUnitFlyHeight(gg_unit_E000_0009)>1.00))then
return false
endif
return true
endfunction
function Trig_JUMP_effect_9_Actions takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("origin",gg_unit_E000_0009,"Abilities\\Spells\\Orc\\MirrorImage\\MirrorImageCaster.mdl")
endfunction
function InitTrig_JUMP_effect_9 takes nothing returns nothing
set gg_trg_JUMP_effect_9=CreateTrigger()
call TriggerRegisterTimerEventPeriodic(gg_trg_JUMP_effect_9,0.10)
call TriggerAddCondition(gg_trg_JUMP_effect_9,Condition(function Trig_JUMP_effect_9_Conditions))
call TriggerAddAction(gg_trg_JUMP_effect_9,function Trig_JUMP_effect_9_Actions)
endfunction
function Trig_JUMP_effect_10_Conditions takes nothing returns boolean
if(not(GetUnitFlyHeight(gg_unit_E000_0010)>1.00))then
return false
endif
return true
endfunction
function Trig_JUMP_effect_10_Actions takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("origin",gg_unit_E000_0010,"Abilities\\Spells\\Orc\\MirrorImage\\MirrorImageCaster.mdl")
endfunction
function InitTrig_JUMP_effect_10 takes nothing returns nothing
set gg_trg_JUMP_effect_10=CreateTrigger()
call TriggerRegisterTimerEventPeriodic(gg_trg_JUMP_effect_10,0.10)
call TriggerAddCondition(gg_trg_JUMP_effect_10,Condition(function Trig_JUMP_effect_10_Conditions))
call TriggerAddAction(gg_trg_JUMP_effect_10,function Trig_JUMP_effect_10_Actions)
endfunction
function Trig_JUMP_effect_11_Conditions takes nothing returns boolean
if(not(GetUnitFlyHeight(gg_unit_E000_0011)>1.00))then
return false
endif
return true
endfunction
function Trig_JUMP_effect_11_Actions takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("origin",gg_unit_E000_0011,"Abilities\\Spells\\Orc\\MirrorImage\\MirrorImageCaster.mdl")
endfunction
function InitTrig_JUMP_effect_11 takes nothing returns nothing
set gg_trg_JUMP_effect_11=CreateTrigger()
call TriggerRegisterTimerEventPeriodic(gg_trg_JUMP_effect_11,0.10)
call TriggerAddCondition(gg_trg_JUMP_effect_11,Condition(function Trig_JUMP_effect_11_Conditions))
call TriggerAddAction(gg_trg_JUMP_effect_11,function Trig_JUMP_effect_11_Actions)
endfunction
function Trig_LeapOfFaith_Func003C takes nothing returns boolean
if(not(GetUnitAbilityLevelSwapped('A001',GetTriggerUnit())==1))then
return false
endif
return true
endfunction
function Trig_LeapOfFaith_Func004C takes nothing returns boolean
if(not(GetUnitAbilityLevelSwapped('A001',GetTriggerUnit())==2))then
return false
endif
return true
endfunction
function Trig_LeapOfFaith_Func005C takes nothing returns boolean
if(not(GetUnitAbilityLevelSwapped('A001',GetTriggerUnit())==3))then
return false
endif
return true
endfunction
function Trig_LeapOfFaith_Func008Func001C takes nothing returns boolean
if(not(RectContainsLoc(udg_LeapRegions[GetForLoopIndexA()],udg_teleportPoints[GetConvertedPlayerId(GetTriggerPlayer())])==true))then
return false
endif
if(not(RectContainsLoc(udg_LeapRegions[GetForLoopIndexA()],udg_tempPoint1)==true))then
return false
endif
return true
endfunction
function Trig_LeapOfFaith_Func011C takes nothing returns boolean
if(not(udg_loopGuard==true))then
return false
endif
return true
endfunction
function Trig_LeapOfFaith_Actions takes nothing returns nothing
set udg_tempPoint1=GetUnitLoc(GetTriggerUnit())
set udg_count=GetConvertedPlayerId(GetTriggerPlayer())
if(Trig_LeapOfFaith_Func003C())then
set udg_teleportSize=400.00
set udg_minTeleport=0.00
else
call DoNothing()
endif
if(Trig_LeapOfFaith_Func004C())then
set udg_teleportSize=600.00
set udg_minTeleport=100.00
else
call DoNothing()
endif
if(Trig_LeapOfFaith_Func005C())then
set udg_teleportSize=900.00
set udg_minTeleport=300.00
else
call DoNothing()
endif
set udg_teleportPoints[GetConvertedPlayerId(GetTriggerPlayer())]=PolarProjectionBJ(udg_tempPoint1,GetRandomReal(udg_minTeleport,udg_teleportSize),GetUnitFacing(GetTriggerUnit()))
set udg_loopGuard=false
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=14
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(Trig_LeapOfFaith_Func008Func001C())then
set udg_loopGuard=true
else
call DoNothing()
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call RemoveLocation(udg_tempPoint1)
call ShowUnitHide(GetTriggerUnit())
if(Trig_LeapOfFaith_Func011C())then
call SetUnitPositionLoc(GetTriggerUnit(),udg_kittyStartingPoints[GetConvertedPlayerId(GetTriggerPlayer())])
call AddSpecialEffectLocBJ(udg_teleportPoints[GetConvertedPlayerId(GetTriggerPlayer())],"Abilities\\Spells\\Human\\MassTeleport\\MassTeleportTo.mdl")
call PolledWait(1.00)
call SetUnitPositionLoc(GetTriggerUnit(),udg_teleportPoints[GetConvertedPlayerId(GetTriggerPlayer())])
call ShowUnitShow(GetTriggerUnit())
call SelectUnitForPlayerSingle(GetTriggerUnit(),GetOwningPlayer(GetTriggerUnit()))
call DestroyEffect(GetLastCreatedEffectBJ())
else
call ShowUnitShow(GetTriggerUnit())
call DisplayTextToForce(GetForceOfPlayer(GetOwningPlayer(GetTriggerUnit())),"TRIGSTR_122")
endif
set udg_count=GetConvertedPlayerId(GetTriggerPlayer())
call RemoveLocation(udg_teleportPoints[udg_count])
endfunction
function InitTrig_LeapOfFaith takes nothing returns nothing
set gg_trg_LeapOfFaith=CreateTrigger()
call DisableTrigger(gg_trg_LeapOfFaith)
call TriggerRegisterAnyUnitEventBJ(gg_trg_LeapOfFaith,EVENT_PLAYER_UNIT_SPELL_CAST)
call TriggerAddAction(gg_trg_LeapOfFaith,function Trig_LeapOfFaith_Actions)
endfunction
function Trig_JUMp1_Conditions takes nothing returns boolean
if(not(GetSpellAbilityId()=='A001'))then
return false
endif
if(not(GetSpellAbilityUnit()==gg_unit_E000_0001))then
return false
endif
return true
endfunction
function Trig_JUMp1_Actions takes nothing returns nothing
call PlaySoundBJ(gg_snd_Audio_wma)
call SetSoundVolumeBJ(gg_snd_Audio_wma,100)
call AddSpecialEffectTargetUnitBJ("origin",gg_unit_E000_0001,"Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile_mini.mdl")
set udg_leftSE1[0]=GetLastCreatedEffectBJ()
call UnitAddAbilityBJ('Amrf',gg_unit_E000_0001)
call UnitRemoveAbilityBJ('Amrf',gg_unit_E000_0001)
call SetUnitFlyHeightBJ(gg_unit_E000_0001,600.00,800.00)
call TriggerSleepAction((I2R(GetUnitAbilityLevelSwapped('A001',gg_unit_E000_0001))/ 6.00))
call SetUnitFlyHeightBJ(gg_unit_E000_0001,1.00,500.00)
call TriggerSleepAction((I2R(GetUnitAbilityLevelSwapped('A001',gg_unit_E000_0001))/ 6.00))
call SetUnitFlyHeightBJ(gg_unit_E000_0001,0.00,800.00)
call DestroyEffect(udg_leftSE1[0])
endfunction
function InitTrig_JUMp1 takes nothing returns nothing
set gg_trg_JUMp1=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_JUMp1,EVENT_PLAYER_UNIT_SPELL_CAST)
call TriggerAddCondition(gg_trg_JUMp1,Condition(function Trig_JUMp1_Conditions))
call TriggerAddAction(gg_trg_JUMp1,function Trig_JUMp1_Actions)
endfunction
function Trig_JUMp2_Conditions takes nothing returns boolean
if(not(GetSpellAbilityId()=='A001'))then
return false
endif
if(not(GetSpellAbilityUnit()==gg_unit_E000_0002))then
return false
endif
return true
endfunction
function Trig_JUMp2_Actions takes nothing returns nothing
call PlaySoundBJ(gg_snd_Audio_wma)
call SetSoundVolumeBJ(gg_snd_Audio_wma,100)
call AddSpecialEffectTargetUnitBJ("origin",gg_unit_E000_0002,"Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile_mini.mdl")
set udg_leftSE1[1]=GetLastCreatedEffectBJ()
call UnitAddAbilityBJ('Amrf',gg_unit_E000_0002)
call UnitRemoveAbilityBJ('Amrf',gg_unit_E000_0002)
call SetUnitFlyHeightBJ(gg_unit_E000_0002,600.00,800.00)
call TriggerSleepAction((I2R(GetUnitAbilityLevelSwapped('A001',gg_unit_E000_0002))/ 6.00))
call SetUnitFlyHeightBJ(gg_unit_E000_0002,1.00,500.00)
call TriggerSleepAction((I2R(GetUnitAbilityLevelSwapped('A001',gg_unit_E000_0002))/ 6.00))
call SetUnitFlyHeightBJ(gg_unit_E000_0002,0.00,800.00)
call DestroyEffect(udg_leftSE1[1])
endfunction
function InitTrig_JUMp2 takes nothing returns nothing
set gg_trg_JUMp2=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_JUMp2,EVENT_PLAYER_UNIT_SPELL_CAST)
call TriggerAddCondition(gg_trg_JUMp2,Condition(function Trig_JUMp2_Conditions))
call TriggerAddAction(gg_trg_JUMp2,function Trig_JUMp2_Actions)
endfunction
function Trig_JUMp3_Conditions takes nothing returns boolean
if(not(GetSpellAbilityId()=='A001'))then
return false
endif
if(not(GetSpellAbilityUnit()==gg_unit_E000_0003))then
return false
endif
return true
endfunction
function Trig_JUMp3_Actions takes nothing returns nothing
call PlaySoundBJ(gg_snd_Audio_wma)
call SetSoundVolumeBJ(gg_snd_Audio_wma,100)
call AddSpecialEffectTargetUnitBJ("origin",gg_unit_E000_0003,"Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile_mini.mdl")
set udg_leftSE1[2]=GetLastCreatedEffectBJ()
call UnitAddAbilityBJ('Amrf',gg_unit_E000_0003)
call UnitRemoveAbilityBJ('Amrf',gg_unit_E000_0003)
call SetUnitFlyHeightBJ(gg_unit_E000_0003,600.00,800.00)
call TriggerSleepAction((I2R(GetUnitAbilityLevelSwapped('A001',gg_unit_E000_0003))/ 6.00))
call SetUnitFlyHeightBJ(gg_unit_E000_0003,1.00,500.00)
call TriggerSleepAction((I2R(GetUnitAbilityLevelSwapped('A001',gg_unit_E000_0003))/ 6.00))
call SetUnitFlyHeightBJ(gg_unit_E000_0003,0.00,800.00)
call DestroyEffect(udg_leftSE1[2])
endfunction
function InitTrig_JUMp3 takes nothing returns nothing
set gg_trg_JUMp3=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_JUMp3,EVENT_PLAYER_UNIT_SPELL_CAST)
call TriggerAddCondition(gg_trg_JUMp3,Condition(function Trig_JUMp3_Conditions))
call TriggerAddAction(gg_trg_JUMp3,function Trig_JUMp3_Actions)
endfunction
function Trig_JUMp4_Conditions takes nothing returns boolean
if(not(GetSpellAbilityId()=='A001'))then
return false
endif
if(not(GetSpellAbilityUnit()==gg_unit_E000_0004))then
return false
endif
return true
endfunction
function Trig_JUMp4_Actions takes nothing returns nothing
call PlaySoundBJ(gg_snd_Audio_wma)
call SetSoundVolumeBJ(gg_snd_Audio_wma,100)
call AddSpecialEffectTargetUnitBJ("origin",gg_unit_E000_0004,"Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile_mini.mdl")
set udg_leftSE1[3]=GetLastCreatedEffectBJ()
call UnitAddAbilityBJ('Amrf',gg_unit_E000_0004)
call UnitRemoveAbilityBJ('Amrf',gg_unit_E000_0004)
call SetUnitFlyHeightBJ(gg_unit_E000_0004,600.00,800.00)
call TriggerSleepAction((I2R(GetUnitAbilityLevelSwapped('A001',gg_unit_E000_0004))/ 6.00))
call SetUnitFlyHeightBJ(gg_unit_E000_0004,1.00,500.00)
call TriggerSleepAction((I2R(GetUnitAbilityLevelSwapped('A001',gg_unit_E000_0004))/ 6.00))
call SetUnitFlyHeightBJ(gg_unit_E000_0004,0.00,800.00)
call DestroyEffect(udg_leftSE1[3])
endfunction
function InitTrig_JUMp4 takes nothing returns nothing
set gg_trg_JUMp4=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_JUMp4,EVENT_PLAYER_UNIT_SPELL_CAST)
call TriggerAddCondition(gg_trg_JUMp4,Condition(function Trig_JUMp4_Conditions))
call TriggerAddAction(gg_trg_JUMp4,function Trig_JUMp4_Actions)
endfunction
function Trig_JUMp5_Conditions takes nothing returns boolean
if(not(GetSpellAbilityId()=='A001'))then
return false
endif
if(not(GetSpellAbilityUnit()==gg_unit_E000_0005))then
return false
endif
return true
endfunction
function Trig_JUMp5_Actions takes nothing returns nothing
call PlaySoundBJ(gg_snd_Audio_wma)
call SetSoundVolumeBJ(gg_snd_Audio_wma,100)
call AddSpecialEffectTargetUnitBJ("origin",gg_unit_E000_0005,"Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile_mini.mdl")
set udg_leftSE1[4]=GetLastCreatedEffectBJ()
call UnitAddAbilityBJ('Amrf',gg_unit_E000_0005)
call UnitRemoveAbilityBJ('Amrf',gg_unit_E000_0005)
call SetUnitFlyHeightBJ(gg_unit_E000_0005,600.00,800.00)
call TriggerSleepAction((I2R(GetUnitAbilityLevelSwapped('A001',gg_unit_E000_0005))/ 6.00))
call SetUnitFlyHeightBJ(gg_unit_E000_0005,1.00,500.00)
call TriggerSleepAction((I2R(GetUnitAbilityLevelSwapped('A001',gg_unit_E000_0005))/ 6.00))
call SetUnitFlyHeightBJ(gg_unit_E000_0005,0.00,800.00)
call DestroyEffect(udg_leftSE1[4])
endfunction
function InitTrig_JUMp5 takes nothing returns nothing
set gg_trg_JUMp5=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_JUMp5,EVENT_PLAYER_UNIT_SPELL_CAST)
call TriggerAddCondition(gg_trg_JUMp5,Condition(function Trig_JUMp5_Conditions))
call TriggerAddAction(gg_trg_JUMp5,function Trig_JUMp5_Actions)
endfunction
function Trig_JUMp6_Conditions takes nothing returns boolean
if(not(GetSpellAbilityId()=='A001'))then
return false
endif
if(not(GetSpellAbilityUnit()==gg_unit_E000_0006))then
return false
endif
return true
endfunction
function Trig_JUMp6_Actions takes nothing returns nothing
call PlaySoundBJ(gg_snd_Audio_wma)
call SetSoundVolumeBJ(gg_snd_Audio_wma,100)
call AddSpecialEffectTargetUnitBJ("origin",gg_unit_E000_0006,"Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile_mini.mdl")
set udg_leftSE1[5]=GetLastCreatedEffectBJ()
call UnitAddAbilityBJ('Amrf',gg_unit_E000_0006)
call UnitRemoveAbilityBJ('Amrf',gg_unit_E000_0006)
call SetUnitFlyHeightBJ(gg_unit_E000_0006,600.00,800.00)
call TriggerSleepAction((I2R(GetUnitAbilityLevelSwapped('A001',gg_unit_E000_0006))/ 6.00))
call SetUnitFlyHeightBJ(gg_unit_E000_0006,1.00,500.00)
call TriggerSleepAction((I2R(GetUnitAbilityLevelSwapped('A001',gg_unit_E000_0006))/ 6.00))
call SetUnitFlyHeightBJ(gg_unit_E000_0006,0.00,800.00)
call DestroyEffect(udg_leftSE1[5])
endfunction
function InitTrig_JUMp6 takes nothing returns nothing
set gg_trg_JUMp6=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_JUMp6,EVENT_PLAYER_UNIT_SPELL_CAST)
call TriggerAddCondition(gg_trg_JUMp6,Condition(function Trig_JUMp6_Conditions))
call TriggerAddAction(gg_trg_JUMp6,function Trig_JUMp6_Actions)
endfunction
function Trig_JUMp7_Conditions takes nothing returns boolean
if(not(GetSpellAbilityId()=='A001'))then
return false
endif
if(not(GetSpellAbilityUnit()==gg_unit_E000_0007))then
return false
endif
return true
endfunction
function Trig_JUMp7_Actions takes nothing returns nothing
call PlaySoundBJ(gg_snd_Audio_wma)
call SetSoundVolumeBJ(gg_snd_Audio_wma,100)
call AddSpecialEffectTargetUnitBJ("origin",gg_unit_E000_0007,"Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile_mini.mdl")
set udg_leftSE1[6]=GetLastCreatedEffectBJ()
call UnitAddAbilityBJ('Amrf',gg_unit_E000_0007)
call UnitRemoveAbilityBJ('Amrf',gg_unit_E000_0007)
call SetUnitFlyHeightBJ(gg_unit_E000_0007,600.00,800.00)
call TriggerSleepAction((I2R(GetUnitAbilityLevelSwapped('A001',gg_unit_E000_0007))/ 6.00))
call SetUnitFlyHeightBJ(gg_unit_E000_0007,1.00,500.00)
call TriggerSleepAction((I2R(GetUnitAbilityLevelSwapped('A001',gg_unit_E000_0007))/ 6.00))
call SetUnitFlyHeightBJ(gg_unit_E000_0007,0.00,800.00)
call DestroyEffect(udg_leftSE1[6])
endfunction
function InitTrig_JUMp7 takes nothing returns nothing
set gg_trg_JUMp7=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_JUMp7,EVENT_PLAYER_UNIT_SPELL_CAST)
call TriggerAddCondition(gg_trg_JUMp7,Condition(function Trig_JUMp7_Conditions))
call TriggerAddAction(gg_trg_JUMp7,function Trig_JUMp7_Actions)
endfunction
function Trig_JUMp8_Conditions takes nothing returns boolean
if(not(GetSpellAbilityId()=='A001'))then
return false
endif
if(not(GetSpellAbilityUnit()==gg_unit_E000_0008))then
return false
endif
return true
endfunction
function Trig_JUMp8_Actions takes nothing returns nothing
call PlaySoundBJ(gg_snd_Audio_wma)
call SetSoundVolumeBJ(gg_snd_Audio_wma,100)
call AddSpecialEffectTargetUnitBJ("origin",gg_unit_E000_0008,"Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile_mini.mdl")
set udg_leftSE1[7]=GetLastCreatedEffectBJ()
call UnitAddAbilityBJ('Amrf',gg_unit_E000_0008)
call UnitRemoveAbilityBJ('Amrf',gg_unit_E000_0008)
call SetUnitFlyHeightBJ(gg_unit_E000_0008,600.00,800.00)
call TriggerSleepAction((I2R(GetUnitAbilityLevelSwapped('A001',gg_unit_E000_0008))/ 6.00))
call SetUnitFlyHeightBJ(gg_unit_E000_0008,1.00,500.00)
call TriggerSleepAction((I2R(GetUnitAbilityLevelSwapped('A001',gg_unit_E000_0008))/ 6.00))
call SetUnitFlyHeightBJ(gg_unit_E000_0008,0.00,800.00)
call DestroyEffect(udg_leftSE1[7])
endfunction
function InitTrig_JUMp8 takes nothing returns nothing
set gg_trg_JUMp8=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_JUMp8,EVENT_PLAYER_UNIT_SPELL_CAST)
call TriggerAddCondition(gg_trg_JUMp8,Condition(function Trig_JUMp8_Conditions))
call TriggerAddAction(gg_trg_JUMp8,function Trig_JUMp8_Actions)
endfunction
function Trig_JUMp9_Conditions takes nothing returns boolean
if(not(GetSpellAbilityId()=='A001'))then
return false
endif
if(not(GetSpellAbilityUnit()==gg_unit_E000_0009))then
return false
endif
return true
endfunction
function Trig_JUMp9_Actions takes nothing returns nothing
call PlaySoundBJ(gg_snd_Audio_wma)
call SetSoundVolumeBJ(gg_snd_Audio_wma,100)
call AddSpecialEffectTargetUnitBJ("origin",gg_unit_E000_0009,"Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile_mini.mdl")
set udg_leftSE1[8]=GetLastCreatedEffectBJ()
call UnitAddAbilityBJ('Amrf',gg_unit_E000_0009)
call UnitRemoveAbilityBJ('Amrf',gg_unit_E000_0009)
call SetUnitFlyHeightBJ(gg_unit_E000_0009,600.00,800.00)
call TriggerSleepAction((I2R(GetUnitAbilityLevelSwapped('A001',gg_unit_E000_0009))/ 6.00))
call SetUnitFlyHeightBJ(gg_unit_E000_0009,1.00,500.00)
call TriggerSleepAction((I2R(GetUnitAbilityLevelSwapped('A001',gg_unit_E000_0009))/ 6.00))
call SetUnitFlyHeightBJ(gg_unit_E000_0009,0.00,800.00)
call DestroyEffect(udg_leftSE1[8])
endfunction
function InitTrig_JUMp9 takes nothing returns nothing
set gg_trg_JUMp9=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_JUMp9,EVENT_PLAYER_UNIT_SPELL_CAST)
call TriggerAddCondition(gg_trg_JUMp9,Condition(function Trig_JUMp9_Conditions))
call TriggerAddAction(gg_trg_JUMp9,function Trig_JUMp9_Actions)
endfunction
function Trig_JUMp10_Conditions takes nothing returns boolean
if(not(GetSpellAbilityId()=='A001'))then
return false
endif
if(not(GetSpellAbilityUnit()==gg_unit_E000_0010))then
return false
endif
return true
endfunction
function Trig_JUMp10_Actions takes nothing returns nothing
call PlaySoundBJ(gg_snd_Audio_wma)
call SetSoundVolumeBJ(gg_snd_Audio_wma,100)
call AddSpecialEffectTargetUnitBJ("origin",gg_unit_E000_0010,"Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile_mini.mdl")
set udg_leftSE1[9]=GetLastCreatedEffectBJ()
call UnitAddAbilityBJ('Amrf',gg_unit_E000_0010)
call UnitRemoveAbilityBJ('Amrf',gg_unit_E000_0010)
call SetUnitFlyHeightBJ(gg_unit_E000_0010,600.00,800.00)
call TriggerSleepAction((I2R(GetUnitAbilityLevelSwapped('A001',gg_unit_E000_0010))/ 6.00))
call SetUnitFlyHeightBJ(gg_unit_E000_0010,1.00,500.00)
call TriggerSleepAction((I2R(GetUnitAbilityLevelSwapped('A001',gg_unit_E000_0010))/ 6.00))
call SetUnitFlyHeightBJ(gg_unit_E000_0010,0.00,800.00)
call DestroyEffect(udg_leftSE1[9])
endfunction
function InitTrig_JUMp10 takes nothing returns nothing
set gg_trg_JUMp10=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_JUMp10,EVENT_PLAYER_UNIT_SPELL_CAST)
call TriggerAddCondition(gg_trg_JUMp10,Condition(function Trig_JUMp10_Conditions))
call TriggerAddAction(gg_trg_JUMp10,function Trig_JUMp10_Actions)
endfunction
function Trig_JUMp11_Conditions takes nothing returns boolean
if(not(GetSpellAbilityId()=='A001'))then
return false
endif
if(not(GetSpellAbilityUnit()==gg_unit_E000_0011))then
return false
endif
return true
endfunction
function Trig_JUMp11_Actions takes nothing returns nothing
call PlaySoundBJ(gg_snd_Audio_wma)
call SetSoundVolumeBJ(gg_snd_Audio_wma,100)
call AddSpecialEffectTargetUnitBJ("origin",gg_unit_E000_0011,"Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile_mini.mdl")
set udg_leftSE1[10]=GetLastCreatedEffectBJ()
call UnitAddAbilityBJ('Amrf',gg_unit_E000_0011)
call UnitRemoveAbilityBJ('Amrf',gg_unit_E000_0011)
call SetUnitFlyHeightBJ(gg_unit_E000_0011,600.00,800.00)
call TriggerSleepAction((I2R(GetUnitAbilityLevelSwapped('A001',gg_unit_E000_0011))/ 6.00))
call SetUnitFlyHeightBJ(gg_unit_E000_0011,1.00,500.00)
call TriggerSleepAction((I2R(GetUnitAbilityLevelSwapped('A001',gg_unit_E000_0011))/ 6.00))
call SetUnitFlyHeightBJ(gg_unit_E000_0011,0.00,800.00)
call DestroyEffect(udg_leftSE1[10])
endfunction
function InitTrig_JUMp11 takes nothing returns nothing
set gg_trg_JUMp11=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_JUMp11,EVENT_PLAYER_UNIT_SPELL_CAST)
call TriggerAddCondition(gg_trg_JUMp11,Condition(function Trig_JUMp11_Conditions))
call TriggerAddAction(gg_trg_JUMp11,function Trig_JUMp11_Actions)
endfunction
function Trig_Thaw_Conditions takes nothing returns boolean
if(not(GetSpellAbilityId()=='A000'))then
return false
endif
return true
endfunction
function Trig_Thaw_Func007001 takes nothing returns boolean
return(GetUnitAbilityLevelSwapped(GetSpellAbilityId(),GetTriggerUnit())==1)
endfunction
function Trig_Thaw_Func008001 takes nothing returns boolean
return(GetUnitAbilityLevelSwapped(GetSpellAbilityId(),GetTriggerUnit())==2)
endfunction
function Trig_Thaw_Func009001 takes nothing returns boolean
return(GetUnitAbilityLevelSwapped(GetSpellAbilityId(),GetTriggerUnit())==3)
endfunction
function Trig_Thaw_Actions takes nothing returns nothing
set udg_terrainPoints[GetConvertedPlayerId(GetTriggerPlayer())]=GetSpellTargetLoc()
set udg_originalTerrain[GetConvertedPlayerId(GetTriggerPlayer())]=GetTerrainTypeBJ(udg_terrainPoints[GetConvertedPlayerId(GetTriggerPlayer())])
call PolledWait(1.00)
call SetTerrainTypeBJ(udg_terrainPoints[GetConvertedPlayerId(GetTriggerPlayer())],'Nrck',-1,1,1)
call AddSpecialEffectLocBJ(udg_terrainPoints[GetConvertedPlayerId(GetTriggerPlayer())],"Abilities\\Spells\\NightElf\\Tranquility\\Tranquility.mdl")
set udg_EFECT=GetLastCreatedEffectBJ()
if(Trig_Thaw_Func007001())then
call PolledWait(6.00)
else
call DoNothing()
endif
if(Trig_Thaw_Func008001())then
call PolledWait(14.00)
else
call DoNothing()
endif
if(Trig_Thaw_Func009001())then
call PolledWait(29.00)
else
call DoNothing()
endif
call AddSpecialEffectLocBJ(udg_terrainPoints[GetConvertedPlayerId(GetTriggerPlayer())],"Abilities\\Spells\\Undead\\ReplenishMana\\ReplenishManaCasterOverhead.mdl")
call PolledWait(1.00)
call SetTerrainTypeBJ(udg_terrainPoints[GetConvertedPlayerId(GetTriggerPlayer())],udg_originalTerrain[GetConvertedPlayerId(GetTriggerPlayer())],-1,1,1)
call DestroyEffect(GetLastCreatedEffectBJ())
call DestroyEffect(udg_EFECT)
endfunction
function InitTrig_Thaw takes nothing returns nothing
set gg_trg_Thaw=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_Thaw,EVENT_PLAYER_UNIT_SPELL_EFFECT)
call TriggerAddCondition(gg_trg_Thaw,Condition(function Trig_Thaw_Conditions))
call TriggerAddAction(gg_trg_Thaw,function Trig_Thaw_Actions)
endfunction
function Trig_Drift1_Conditions takes nothing returns boolean
if(not(GetSpellAbilityId()=='A003'))then
return false
endif
if(not(GetSpellAbilityUnit()==gg_unit_E000_0001))then
return false
endif
return true
endfunction
function Trig_Drift1_Actions takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("origin",gg_unit_E000_0001,"Abilities\\Spells\\Orc\\Shockwave\\ShockwaveMissile.mdl")
set udg_rightSE[0]=GetLastCreatedEffectBJ()
set udg_REALSPD1=(udg_REALSPD1+1.25)
call TriggerSleepAction(1.50)
set udg_REALSPD1=1.00
call DestroyEffect(udg_rightSE[0])
endfunction
function InitTrig_Drift1 takes nothing returns nothing
set gg_trg_Drift1=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_Drift1,EVENT_PLAYER_UNIT_SPELL_CAST)
call TriggerAddCondition(gg_trg_Drift1,Condition(function Trig_Drift1_Conditions))
call TriggerAddAction(gg_trg_Drift1,function Trig_Drift1_Actions)
endfunction
function Trig_driftefect1_Conditions takes nothing returns boolean
if(not(udg_REALSPD1>1.00))then
return false
endif
return true
endfunction
function Trig_driftefect1_Actions takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("origin",gg_unit_E000_0001,"Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl")
endfunction
function InitTrig_driftefect1 takes nothing returns nothing
set gg_trg_driftefect1=CreateTrigger()
call TriggerRegisterTimerEventPeriodic(gg_trg_driftefect1,0.10)
call TriggerAddCondition(gg_trg_driftefect1,Condition(function Trig_driftefect1_Conditions))
call TriggerAddAction(gg_trg_driftefect1,function Trig_driftefect1_Actions)
endfunction
function Trig_driftefect2_Conditions takes nothing returns boolean
if(not(udg_REALSPD2>1.00))then
return false
endif
return true
endfunction
function Trig_driftefect2_Actions takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("origin",gg_unit_E000_0002,"Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl")
endfunction
function InitTrig_driftefect2 takes nothing returns nothing
set gg_trg_driftefect2=CreateTrigger()
call TriggerRegisterTimerEventPeriodic(gg_trg_driftefect2,0.10)
call TriggerAddCondition(gg_trg_driftefect2,Condition(function Trig_driftefect2_Conditions))
call TriggerAddAction(gg_trg_driftefect2,function Trig_driftefect2_Actions)
endfunction
function Trig_driftefect3_Conditions takes nothing returns boolean
if(not(udg_REALSPD3>1.00))then
return false
endif
return true
endfunction
function Trig_driftefect3_Actions takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("origin",gg_unit_E000_0003,"Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl")
endfunction
function InitTrig_driftefect3 takes nothing returns nothing
set gg_trg_driftefect3=CreateTrigger()
call TriggerRegisterTimerEventPeriodic(gg_trg_driftefect3,0.10)
call TriggerAddCondition(gg_trg_driftefect3,Condition(function Trig_driftefect3_Conditions))
call TriggerAddAction(gg_trg_driftefect3,function Trig_driftefect3_Actions)
endfunction
function Trig_driftefect4_Conditions takes nothing returns boolean
if(not(udg_REALSPD4>1.00))then
return false
endif
return true
endfunction
function Trig_driftefect4_Actions takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("origin",gg_unit_E000_0004,"Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl")
endfunction
function InitTrig_driftefect4 takes nothing returns nothing
set gg_trg_driftefect4=CreateTrigger()
call TriggerRegisterTimerEventPeriodic(gg_trg_driftefect4,0.10)
call TriggerAddCondition(gg_trg_driftefect4,Condition(function Trig_driftefect4_Conditions))
call TriggerAddAction(gg_trg_driftefect4,function Trig_driftefect4_Actions)
endfunction
function Trig_driftefect5_Conditions takes nothing returns boolean
if(not(udg_REALSPD5>1.00))then
return false
endif
return true
endfunction
function Trig_driftefect5_Actions takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("origin",gg_unit_E000_0005,"Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl")
endfunction
function InitTrig_driftefect5 takes nothing returns nothing
set gg_trg_driftefect5=CreateTrigger()
call TriggerRegisterTimerEventPeriodic(gg_trg_driftefect5,0.10)
call TriggerAddCondition(gg_trg_driftefect5,Condition(function Trig_driftefect5_Conditions))
call TriggerAddAction(gg_trg_driftefect5,function Trig_driftefect5_Actions)
endfunction
function Trig_driftefect6_Conditions takes nothing returns boolean
if(not(udg_REALSPD6>1.00))then
return false
endif
return true
endfunction
function Trig_driftefect6_Actions takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("origin",gg_unit_E000_0006,"Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl")
endfunction
function InitTrig_driftefect6 takes nothing returns nothing
set gg_trg_driftefect6=CreateTrigger()
call TriggerRegisterTimerEventPeriodic(gg_trg_driftefect6,0.10)
call TriggerAddCondition(gg_trg_driftefect6,Condition(function Trig_driftefect6_Conditions))
call TriggerAddAction(gg_trg_driftefect6,function Trig_driftefect6_Actions)
endfunction
function Trig_driftefect7_Conditions takes nothing returns boolean
if(not(udg_REALSPD7>1.00))then
return false
endif
return true
endfunction
function Trig_driftefect7_Actions takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("origin",gg_unit_E000_0007,"Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl")
endfunction
function InitTrig_driftefect7 takes nothing returns nothing
set gg_trg_driftefect7=CreateTrigger()
call TriggerRegisterTimerEventPeriodic(gg_trg_driftefect7,0.10)
call TriggerAddCondition(gg_trg_driftefect7,Condition(function Trig_driftefect7_Conditions))
call TriggerAddAction(gg_trg_driftefect7,function Trig_driftefect7_Actions)
endfunction
function Trig_driftefect8_Conditions takes nothing returns boolean
if(not(udg_REALSPD8>1.00))then
return false
endif
return true
endfunction
function Trig_driftefect8_Actions takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("origin",gg_unit_E000_0008,"Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl")
endfunction
function InitTrig_driftefect8 takes nothing returns nothing
set gg_trg_driftefect8=CreateTrigger()
call TriggerRegisterTimerEventPeriodic(gg_trg_driftefect8,0.10)
call TriggerAddCondition(gg_trg_driftefect8,Condition(function Trig_driftefect8_Conditions))
call TriggerAddAction(gg_trg_driftefect8,function Trig_driftefect8_Actions)
endfunction
function Trig_driftefect9_Conditions takes nothing returns boolean
if(not(udg_REALSPD9>1.00))then
return false
endif
return true
endfunction
function Trig_driftefect9_Actions takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("origin",gg_unit_E000_0009,"Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl")
endfunction
function InitTrig_driftefect9 takes nothing returns nothing
set gg_trg_driftefect9=CreateTrigger()
call TriggerRegisterTimerEventPeriodic(gg_trg_driftefect9,0.10)
call TriggerAddCondition(gg_trg_driftefect9,Condition(function Trig_driftefect9_Conditions))
call TriggerAddAction(gg_trg_driftefect9,function Trig_driftefect9_Actions)
endfunction
function Trig_driftefect10_Conditions takes nothing returns boolean
if(not(udg_REALSPD10>1.00))then
return false
endif
return true
endfunction
function Trig_driftefect10_Actions takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("origin",gg_unit_E000_0010,"Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl")
endfunction
function InitTrig_driftefect10 takes nothing returns nothing
set gg_trg_driftefect10=CreateTrigger()
call TriggerRegisterTimerEventPeriodic(gg_trg_driftefect10,0.10)
call TriggerAddCondition(gg_trg_driftefect10,Condition(function Trig_driftefect10_Conditions))
call TriggerAddAction(gg_trg_driftefect10,function Trig_driftefect10_Actions)
endfunction
function Trig_driftefect11_Conditions takes nothing returns boolean
if(not(udg_REALSPD11>1.00))then
return false
endif
return true
endfunction
function Trig_driftefect11_Actions takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("origin",gg_unit_E000_0011,"Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl")
endfunction
function InitTrig_driftefect11 takes nothing returns nothing
set gg_trg_driftefect11=CreateTrigger()
call TriggerRegisterTimerEventPeriodic(gg_trg_driftefect11,0.10)
call TriggerAddCondition(gg_trg_driftefect11,Condition(function Trig_driftefect11_Conditions))
call TriggerAddAction(gg_trg_driftefect11,function Trig_driftefect11_Actions)
endfunction
function Trig_Drift2_Conditions takes nothing returns boolean
if(not(GetSpellAbilityId()=='A003'))then
return false
endif
if(not(GetSpellAbilityUnit()==gg_unit_E000_0002))then
return false
endif
return true
endfunction
function Trig_Drift2_Actions takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("origin",gg_unit_E000_0002,"Abilities\\Spells\\Orc\\Shockwave\\ShockwaveMissile.mdl")
set udg_rightSE[1]=GetLastCreatedEffectBJ()
set udg_REALSPD2=(udg_REALSPD2+1.25)
call TriggerSleepAction(1.50)
set udg_REALSPD2=1.00
call DestroyEffect(udg_rightSE[1])
endfunction
function InitTrig_Drift2 takes nothing returns nothing
set gg_trg_Drift2=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_Drift2,EVENT_PLAYER_UNIT_SPELL_CAST)
call TriggerAddCondition(gg_trg_Drift2,Condition(function Trig_Drift2_Conditions))
call TriggerAddAction(gg_trg_Drift2,function Trig_Drift2_Actions)
endfunction
function Trig_Drift3_Conditions takes nothing returns boolean
if(not(GetSpellAbilityId()=='A003'))then
return false
endif
if(not(GetSpellAbilityUnit()==gg_unit_E000_0003))then
return false
endif
return true
endfunction
function Trig_Drift3_Actions takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("origin",gg_unit_E000_0003,"Abilities\\Spells\\Orc\\Shockwave\\ShockwaveMissile.mdl")
set udg_rightSE[2]=GetLastCreatedEffectBJ()
set udg_REALSPD3=(udg_REALSPD3+1.25)
call TriggerSleepAction(1.50)
set udg_REALSPD3=1.00
call DestroyEffect(udg_rightSE[2])
endfunction
function InitTrig_Drift3 takes nothing returns nothing
set gg_trg_Drift3=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_Drift3,EVENT_PLAYER_UNIT_SPELL_CAST)
call TriggerAddCondition(gg_trg_Drift3,Condition(function Trig_Drift3_Conditions))
call TriggerAddAction(gg_trg_Drift3,function Trig_Drift3_Actions)
endfunction
function Trig_Drift4_Conditions takes nothing returns boolean
if(not(GetSpellAbilityId()=='A003'))then
return false
endif
if(not(GetSpellAbilityUnit()==gg_unit_E000_0004))then
return false
endif
return true
endfunction
function Trig_Drift4_Actions takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("origin",gg_unit_E000_0004,"Abilities\\Spells\\Orc\\Shockwave\\ShockwaveMissile.mdl")
set udg_rightSE[3]=GetLastCreatedEffectBJ()
set udg_REALSPD4=(udg_REALSPD4+1.25)
call TriggerSleepAction(1.50)
set udg_REALSPD4=1.00
call DestroyEffect(udg_rightSE[3])
endfunction
function InitTrig_Drift4 takes nothing returns nothing
set gg_trg_Drift4=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_Drift4,EVENT_PLAYER_UNIT_SPELL_CAST)
call TriggerAddCondition(gg_trg_Drift4,Condition(function Trig_Drift4_Conditions))
call TriggerAddAction(gg_trg_Drift4,function Trig_Drift4_Actions)
endfunction
function Trig_Drift5_Conditions takes nothing returns boolean
if(not(GetSpellAbilityId()=='A003'))then
return false
endif
if(not(GetSpellAbilityUnit()==gg_unit_E000_0005))then
return false
endif
return true
endfunction
function Trig_Drift5_Actions takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("origin",gg_unit_E000_0005,"Abilities\\Spells\\Orc\\Shockwave\\ShockwaveMissile.mdl")
set udg_rightSE[4]=GetLastCreatedEffectBJ()
set udg_REALSPD5=(udg_REALSPD5+1.25)
call TriggerSleepAction(1.50)
set udg_REALSPD5=1.00
call DestroyEffect(udg_rightSE[4])
endfunction
function InitTrig_Drift5 takes nothing returns nothing
set gg_trg_Drift5=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_Drift5,EVENT_PLAYER_UNIT_SPELL_CAST)
call TriggerAddCondition(gg_trg_Drift5,Condition(function Trig_Drift5_Conditions))
call TriggerAddAction(gg_trg_Drift5,function Trig_Drift5_Actions)
endfunction
function Trig_Drift6_Conditions takes nothing returns boolean
if(not(GetSpellAbilityId()=='A003'))then
return false
endif
if(not(GetSpellAbilityUnit()==gg_unit_E000_0006))then
return false
endif
return true
endfunction
function Trig_Drift6_Actions takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("origin",gg_unit_E000_0006,"Abilities\\Spells\\Orc\\Shockwave\\ShockwaveMissile.mdl")
set udg_rightSE[5]=GetLastCreatedEffectBJ()
set udg_REALSPD6=(udg_REALSPD6+1.25)
call TriggerSleepAction(1.50)
set udg_REALSPD6=1.00
call DestroyEffect(udg_rightSE[5])
endfunction
function InitTrig_Drift6 takes nothing returns nothing
set gg_trg_Drift6=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_Drift6,EVENT_PLAYER_UNIT_SPELL_CAST)
call TriggerAddCondition(gg_trg_Drift6,Condition(function Trig_Drift6_Conditions))
call TriggerAddAction(gg_trg_Drift6,function Trig_Drift6_Actions)
endfunction
function Trig_Drift7_Conditions takes nothing returns boolean
if(not(GetSpellAbilityId()=='A003'))then
return false
endif
if(not(GetSpellAbilityUnit()==gg_unit_E000_0007))then
return false
endif
return true
endfunction
function Trig_Drift7_Actions takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("origin",gg_unit_E000_0007,"Abilities\\Spells\\Orc\\Shockwave\\ShockwaveMissile.mdl")
set udg_rightSE[6]=GetLastCreatedEffectBJ()
set udg_REALSPD7=(udg_REALSPD7+1.25)
call TriggerSleepAction(1.50)
set udg_REALSPD7=1.00
call DestroyEffect(udg_rightSE[6])
endfunction
function InitTrig_Drift7 takes nothing returns nothing
set gg_trg_Drift7=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_Drift7,EVENT_PLAYER_UNIT_SPELL_CAST)
call TriggerAddCondition(gg_trg_Drift7,Condition(function Trig_Drift7_Conditions))
call TriggerAddAction(gg_trg_Drift7,function Trig_Drift7_Actions)
endfunction
function Trig_Drift8_Conditions takes nothing returns boolean
if(not(GetSpellAbilityId()=='A003'))then
return false
endif
if(not(GetSpellAbilityUnit()==gg_unit_E000_0008))then
return false
endif
return true
endfunction
function Trig_Drift8_Actions takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("origin",gg_unit_E000_0008,"Abilities\\Spells\\Orc\\Shockwave\\ShockwaveMissile.mdl")
set udg_rightSE[7]=GetLastCreatedEffectBJ()
set udg_REALSPD8=(udg_REALSPD8+1.25)
call TriggerSleepAction(1.50)
set udg_REALSPD8=1.00
call DestroyEffect(udg_rightSE[7])
endfunction
function InitTrig_Drift8 takes nothing returns nothing
set gg_trg_Drift8=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_Drift8,EVENT_PLAYER_UNIT_SPELL_CAST)
call TriggerAddCondition(gg_trg_Drift8,Condition(function Trig_Drift8_Conditions))
call TriggerAddAction(gg_trg_Drift8,function Trig_Drift8_Actions)
endfunction
function Trig_Drift9_Conditions takes nothing returns boolean
if(not(GetSpellAbilityId()=='A003'))then
return false
endif
if(not(GetSpellAbilityUnit()==gg_unit_E000_0009))then
return false
endif
return true
endfunction
function Trig_Drift9_Actions takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("origin",gg_unit_E000_0009,"Abilities\\Spells\\Orc\\Shockwave\\ShockwaveMissile.mdl")
set udg_rightSE[8]=GetLastCreatedEffectBJ()
set udg_REALSPD9=(udg_REALSPD9+1.25)
call TriggerSleepAction(1.50)
set udg_REALSPD9=1.00
call DestroyEffect(udg_rightSE[8])
endfunction
function InitTrig_Drift9 takes nothing returns nothing
set gg_trg_Drift9=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_Drift9,EVENT_PLAYER_UNIT_SPELL_CAST)
call TriggerAddCondition(gg_trg_Drift9,Condition(function Trig_Drift9_Conditions))
call TriggerAddAction(gg_trg_Drift9,function Trig_Drift9_Actions)
endfunction
function Trig_Drift10_Conditions takes nothing returns boolean
if(not(GetSpellAbilityId()=='A003'))then
return false
endif
if(not(GetSpellAbilityUnit()==gg_unit_E000_0010))then
return false
endif
return true
endfunction
function Trig_Drift10_Actions takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("origin",gg_unit_E000_0010,"Abilities\\Spells\\Orc\\Shockwave\\ShockwaveMissile.mdl")
set udg_rightSE[9]=GetLastCreatedEffectBJ()
set udg_REALSPD10=(udg_REALSPD10+1.25)
call TriggerSleepAction(1.50)
set udg_REALSPD10=1.00
call DestroyEffect(udg_rightSE[9])
endfunction
function InitTrig_Drift10 takes nothing returns nothing
set gg_trg_Drift10=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_Drift10,EVENT_PLAYER_UNIT_SPELL_CAST)
call TriggerAddCondition(gg_trg_Drift10,Condition(function Trig_Drift10_Conditions))
call TriggerAddAction(gg_trg_Drift10,function Trig_Drift10_Actions)
endfunction
function Trig_Drift11_Conditions takes nothing returns boolean
if(not(GetSpellAbilityId()=='A003'))then
return false
endif
if(not(GetSpellAbilityUnit()==gg_unit_E000_0011))then
return false
endif
return true
endfunction
function Trig_Drift11_Actions takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("origin",gg_unit_E000_0011,"Abilities\\Spells\\Orc\\Shockwave\\ShockwaveMissile.mdl")
set udg_rightSE[10]=GetLastCreatedEffectBJ()
set udg_REALSPD11=(udg_REALSPD11+1.25)
call TriggerSleepAction(1.50)
set udg_REALSPD11=1.00
call DestroyEffect(udg_rightSE[10])
endfunction
function InitTrig_Drift11 takes nothing returns nothing
set gg_trg_Drift11=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_Drift11,EVENT_PLAYER_UNIT_SPELL_CAST)
call TriggerAddCondition(gg_trg_Drift11,Condition(function Trig_Drift11_Conditions))
call TriggerAddAction(gg_trg_Drift11,function Trig_Drift11_Actions)
endfunction
function InitCustomTriggers takes nothing returns nothing
call InitTrig_Kick2()
call InitTrig_Kick3()
call InitTrig_Kick4()
call InitTrig_Kick5()
call InitTrig_Kich6()
call InitTrig_Kick7()
call InitTrig_Kick8()
call InitTrig_Kick9()
call InitTrig_Kick10()
call InitTrig_Kick11()
call InitTrig_SATART()
call InitTrig_Game_End_Dbl_Chk()
call InitTrig_Leaderboard()
call InitTrig_Set_level()
call InitTrig_Trigger_Next_Round()
call InitTrig_Win()
call InitTrig_Remove()
call InitTrig_Game_Over()
call InitTrig_Not_here()
call InitTrig_Next_Round()
call InitTrig_PlayerLeaves()
call InitTrig_PlayerLeft()
call InitTrig_Starting_Gold()
call InitTrig_TimeofDay()
call InitTrig_Master_Slide()
call InitTrig_Master_Turn_Point()
call InitTrig_Master_Turn_Unit()
call InitTrig_Master_Turn_Item()
call InitTrig_P1_Slide()
call InitTrig_P2_Slide()
call InitTrig_P3_Slide()
call InitTrig_P4_Slide()
call InitTrig_P5_Slide()
call InitTrig_P6_Slide()
call InitTrig_P7_Slide()
call InitTrig_P8_Slide()
call InitTrig_P9_Slide()
call InitTrig_P10_Slide()
call InitTrig_P11_Slide()
call InitTrig_P1_Revive()
call InitTrig_P2_Revive()
call InitTrig_P3_Revive()
call InitTrig_P4_Revive()
call InitTrig_P5_Revive()
call InitTrig_P6_Revive()
call InitTrig_P7_Revive()
call InitTrig_P8_Revive()
call InitTrig_P9_Revive()
call InitTrig_P10_Revive()
call InitTrig_P11_Revive()
call InitTrig_P1()
call InitTrig_P2()
call InitTrig_P3()
call InitTrig_P4()
call InitTrig_P5()
call InitTrig_P6()
call InitTrig_P7()
call InitTrig_P8()
call InitTrig_P9()
call InitTrig_P10()
call InitTrig_P11()
call InitTrig_Untitled_Trigger_001()
call InitTrig_Axel_F()
call InitTrig_Wolf_Area_One()
call InitTrig_Wolf_Area_Two()
call InitTrig_Wolf_Area_Three()
call InitTrig_Wolf_Area_Four()
call InitTrig_Wolf_Area_Five()
call InitTrig_Wolf_Area_Six()
call InitTrig_Wolf_Area_Seven()
call InitTrig_Wolf_Area_Eight()
call InitTrig_Wolf_Area_Nine()
call InitTrig_Wolf_Area_Ten()
call InitTrig_Wolf_Area_Eleven()
call InitTrig_Wolf_Area_Twelve()
call InitTrig_Wolf_Area_Thirteen()
call InitTrig_Wolf_Area_Fourteen()
call InitTrig_Wolf_Area_Fifteen()
call InitTrig_Spawn()
call InitTrig_Collect_1()
call InitTrig_Collect_2()
call InitTrig_Collect_3()
call InitTrig_Collect_4()
call InitTrig_Collect_5()
call InitTrig_Collect_6()
call InitTrig_Collect_7()
call InitTrig_Collect_8()
call InitTrig_Collect_9()
call InitTrig_Collect_10()
call InitTrig_Collect_11()
call InitTrig_SideGuardTop1()
call InitTrig_SideGuardTop2()
call InitTrig_SideGuardTop3()
call InitTrig_SideGuardTop4()
call InitTrig_SideGuardTop5()
call InitTrig_SideGuardTop6()
call InitTrig_SideGuardTop7()
call InitTrig_SideGuardTop8()
call InitTrig_SideGuardBottom1()
call InitTrig_SideGuardBottom2()
call InitTrig_SideGuardBottom3()
call InitTrig_SideGuardBottom4()
call InitTrig_SideGuardBottom5()
call InitTrig_SideGuardBottom6()
call InitTrig_SideGuardBottom7()
call InitTrig_SideGuardBottom8()
call InitTrig_SideGuardRight1()
call InitTrig_SideGuardRight2()
call InitTrig_SideGuardRight3()
call InitTrig_SideGuardRight4()
call InitTrig_SideGuardRight5()
call InitTrig_SideGuardRight6()
call InitTrig_SideGuardRight7()
call InitTrig_SideGuardRight8()
call InitTrig_SideGuardLeft3()
call InitTrig_SideGuardLeft4()
call InitTrig_SideGuardLeft5()
call InitTrig_SideGuardLeft6()
call InitTrig_SideGuardLeft7()
call InitTrig_SideGuardLeft8()
call InitTrig_Lvl1()
call InitTrig_Lvl2()
call InitTrig_Lvl3()
call InitTrig_Lvl4()
call InitTrig_Lvl5()
call InitTrig_Lvl6()
call InitTrig_Lvl7()
call InitTrig_Lvl8()
call InitTrig_Lvl9()
call InitTrig_Lvl10()
call InitTrig_Lvl11()
call InitTrig_Lvl12()
call InitTrig_Lvl13()
call InitTrig_Lvl14()
call InitTrig_JUMP_effect_1()
call InitTrig_JUMP_effect_2()
call InitTrig_JUMP_effect_3()
call InitTrig_JUMP_effect_4()
call InitTrig_JUMP_effect_5()
call InitTrig_JUMP_effect_6()
call InitTrig_JUMP_effect_7()
call InitTrig_JUMP_effect_8()
call InitTrig_JUMP_effect_9()
call InitTrig_JUMP_effect_10()
call InitTrig_JUMP_effect_11()
call InitTrig_LeapOfFaith()
call InitTrig_JUMp1()
call InitTrig_JUMp2()
call InitTrig_JUMp3()
call InitTrig_JUMp4()
call InitTrig_JUMp5()
call InitTrig_JUMp6()
call InitTrig_JUMp7()
call InitTrig_JUMp8()
call InitTrig_JUMp9()
call InitTrig_JUMp10()
call InitTrig_JUMp11()
call InitTrig_Thaw()
call InitTrig_Drift1()
call InitTrig_driftefect1()
call InitTrig_driftefect2()
call InitTrig_driftefect3()
call InitTrig_driftefect4()
call InitTrig_driftefect5()
call InitTrig_driftefect6()
call InitTrig_driftefect7()
call InitTrig_driftefect8()
call InitTrig_driftefect9()
call InitTrig_driftefect10()
call InitTrig_driftefect11()
call InitTrig_Drift2()
call InitTrig_Drift3()
call InitTrig_Drift4()
call InitTrig_Drift5()
call InitTrig_Drift6()
call InitTrig_Drift7()
call InitTrig_Drift8()
call InitTrig_Drift9()
call InitTrig_Drift10()
call InitTrig_Drift11()
endfunction
function RunInitializationTriggers takes nothing returns nothing
call ConditionalTriggerExecute(gg_trg_SATART)
call ConditionalTriggerExecute(gg_trg_Not_here)
call ConditionalTriggerExecute(gg_trg_Starting_Gold)
endfunction
function InitCustomPlayerSlots takes nothing returns nothing
call SetPlayerStartLocation(Player(0),0)
call ForcePlayerStartLocation(Player(0),0)
call SetPlayerColor(Player(0),ConvertPlayerColor(0))
call SetPlayerRacePreference(Player(0),RACE_PREF_HUMAN)
call SetPlayerRaceSelectable(Player(0),false)
call SetPlayerController(Player(0),MAP_CONTROL_USER)
call SetPlayerStartLocation(Player(1),1)
call ForcePlayerStartLocation(Player(1),1)
call SetPlayerColor(Player(1),ConvertPlayerColor(1))
call SetPlayerRacePreference(Player(1),RACE_PREF_HUMAN)
call SetPlayerRaceSelectable(Player(1),false)
call SetPlayerController(Player(1),MAP_CONTROL_USER)
call SetPlayerStartLocation(Player(2),2)
call ForcePlayerStartLocation(Player(2),2)
call SetPlayerColor(Player(2),ConvertPlayerColor(2))
call SetPlayerRacePreference(Player(2),RACE_PREF_HUMAN)
call SetPlayerRaceSelectable(Player(2),false)
call SetPlayerController(Player(2),MAP_CONTROL_USER)
call SetPlayerStartLocation(Player(3),3)
call ForcePlayerStartLocation(Player(3),3)
call SetPlayerColor(Player(3),ConvertPlayerColor(3))
call SetPlayerRacePreference(Player(3),RACE_PREF_HUMAN)
call SetPlayerRaceSelectable(Player(3),false)
call SetPlayerController(Player(3),MAP_CONTROL_USER)
call SetPlayerStartLocation(Player(4),4)
call ForcePlayerStartLocation(Player(4),4)
call SetPlayerColor(Player(4),ConvertPlayerColor(4))
call SetPlayerRacePreference(Player(4),RACE_PREF_HUMAN)
call SetPlayerRaceSelectable(Player(4),false)
call SetPlayerController(Player(4),MAP_CONTROL_USER)
call SetPlayerStartLocation(Player(5),5)
call ForcePlayerStartLocation(Player(5),5)
call SetPlayerColor(Player(5),ConvertPlayerColor(5))
call SetPlayerRacePreference(Player(5),RACE_PREF_HUMAN)
call SetPlayerRaceSelectable(Player(5),false)
call SetPlayerController(Player(5),MAP_CONTROL_USER)
call SetPlayerStartLocation(Player(6),6)
call ForcePlayerStartLocation(Player(6),6)
call SetPlayerColor(Player(6),ConvertPlayerColor(6))
call SetPlayerRacePreference(Player(6),RACE_PREF_HUMAN)
call SetPlayerRaceSelectable(Player(6),false)
call SetPlayerController(Player(6),MAP_CONTROL_USER)
call SetPlayerStartLocation(Player(7),7)
call ForcePlayerStartLocation(Player(7),7)
call SetPlayerColor(Player(7),ConvertPlayerColor(7))
call SetPlayerRacePreference(Player(7),RACE_PREF_HUMAN)
call SetPlayerRaceSelectable(Player(7),false)
call SetPlayerController(Player(7),MAP_CONTROL_USER)
call SetPlayerStartLocation(Player(8),8)
call ForcePlayerStartLocation(Player(8),8)
call SetPlayerColor(Player(8),ConvertPlayerColor(8))
call SetPlayerRacePreference(Player(8),RACE_PREF_HUMAN)
call SetPlayerRaceSelectable(Player(8),false)
call SetPlayerController(Player(8),MAP_CONTROL_USER)
call SetPlayerStartLocation(Player(9),9)
call ForcePlayerStartLocation(Player(9),9)
call SetPlayerColor(Player(9),ConvertPlayerColor(9))
call SetPlayerRacePreference(Player(9),RACE_PREF_HUMAN)
call SetPlayerRaceSelectable(Player(9),false)
call SetPlayerController(Player(9),MAP_CONTROL_USER)
call SetPlayerStartLocation(Player(10),10)
call ForcePlayerStartLocation(Player(10),10)
call SetPlayerColor(Player(10),ConvertPlayerColor(10))
call SetPlayerRacePreference(Player(10),RACE_PREF_HUMAN)
call SetPlayerRaceSelectable(Player(10),false)
call SetPlayerController(Player(10),MAP_CONTROL_USER)
call SetPlayerStartLocation(Player(11),11)
call ForcePlayerStartLocation(Player(11),11)
call SetPlayerColor(Player(11),ConvertPlayerColor(11))
call SetPlayerRacePreference(Player(11),RACE_PREF_NIGHTELF)
call SetPlayerRaceSelectable(Player(11),false)
call SetPlayerController(Player(11),MAP_CONTROL_COMPUTER)
endfunction
function InitCustomTeams takes nothing returns nothing
call SetPlayerTeam(Player(0),0)
call SetPlayerState(Player(0),PLAYER_STATE_ALLIED_VICTORY,1)
call SetPlayerTeam(Player(1),0)
call SetPlayerState(Player(1),PLAYER_STATE_ALLIED_VICTORY,1)
call SetPlayerTeam(Player(2),0)
call SetPlayerState(Player(2),PLAYER_STATE_ALLIED_VICTORY,1)
call SetPlayerTeam(Player(3),0)
call SetPlayerState(Player(3),PLAYER_STATE_ALLIED_VICTORY,1)
call SetPlayerTeam(Player(4),0)
call SetPlayerState(Player(4),PLAYER_STATE_ALLIED_VICTORY,1)
call SetPlayerTeam(Player(5),0)
call SetPlayerState(Player(5),PLAYER_STATE_ALLIED_VICTORY,1)
call SetPlayerTeam(Player(6),0)
call SetPlayerState(Player(6),PLAYER_STATE_ALLIED_VICTORY,1)
call SetPlayerTeam(Player(7),0)
call SetPlayerState(Player(7),PLAYER_STATE_ALLIED_VICTORY,1)
call SetPlayerTeam(Player(8),0)
call SetPlayerState(Player(8),PLAYER_STATE_ALLIED_VICTORY,1)
call SetPlayerTeam(Player(9),0)
call SetPlayerState(Player(9),PLAYER_STATE_ALLIED_VICTORY,1)
call SetPlayerTeam(Player(10),0)
call SetPlayerState(Player(10),PLAYER_STATE_ALLIED_VICTORY,1)
call SetPlayerAllianceStateAllyBJ(Player(0),Player(1),true)
call SetPlayerAllianceStateAllyBJ(Player(0),Player(2),true)
call SetPlayerAllianceStateAllyBJ(Player(0),Player(3),true)
call SetPlayerAllianceStateAllyBJ(Player(0),Player(4),true)
call SetPlayerAllianceStateAllyBJ(Player(0),Player(5),true)
call SetPlayerAllianceStateAllyBJ(Player(0),Player(6),true)
call SetPlayerAllianceStateAllyBJ(Player(0),Player(7),true)
call SetPlayerAllianceStateAllyBJ(Player(0),Player(8),true)
call SetPlayerAllianceStateAllyBJ(Player(0),Player(9),true)
call SetPlayerAllianceStateAllyBJ(Player(0),Player(10),true)
call SetPlayerAllianceStateAllyBJ(Player(1),Player(0),true)
call SetPlayerAllianceStateAllyBJ(Player(1),Player(2),true)
call SetPlayerAllianceStateAllyBJ(Player(1),Player(3),true)
call SetPlayerAllianceStateAllyBJ(Player(1),Player(4),true)
call SetPlayerAllianceStateAllyBJ(Player(1),Player(5),true)
call SetPlayerAllianceStateAllyBJ(Player(1),Player(6),true)
call SetPlayerAllianceStateAllyBJ(Player(1),Player(7),true)
call SetPlayerAllianceStateAllyBJ(Player(1),Player(8),true)
call SetPlayerAllianceStateAllyBJ(Player(1),Player(9),true)
call SetPlayerAllianceStateAllyBJ(Player(1),Player(10),true)
call SetPlayerAllianceStateAllyBJ(Player(2),Player(0),true)
call SetPlayerAllianceStateAllyBJ(Player(2),Player(1),true)
call SetPlayerAllianceStateAllyBJ(Player(2),Player(3),true)
call SetPlayerAllianceStateAllyBJ(Player(2),Player(4),true)
call SetPlayerAllianceStateAllyBJ(Player(2),Player(5),true)
call SetPlayerAllianceStateAllyBJ(Player(2),Player(6),true)
call SetPlayerAllianceStateAllyBJ(Player(2),Player(7),true)
call SetPlayerAllianceStateAllyBJ(Player(2),Player(8),true)
call SetPlayerAllianceStateAllyBJ(Player(2),Player(9),true)
call SetPlayerAllianceStateAllyBJ(Player(2),Player(10),true)
call SetPlayerAllianceStateAllyBJ(Player(3),Player(0),true)
call SetPlayerAllianceStateAllyBJ(Player(3),Player(1),true)
call SetPlayerAllianceStateAllyBJ(Player(3),Player(2),true)
call SetPlayerAllianceStateAllyBJ(Player(3),Player(4),true)
call SetPlayerAllianceStateAllyBJ(Player(3),Player(5),true)
call SetPlayerAllianceStateAllyBJ(Player(3),Player(6),true)
call SetPlayerAllianceStateAllyBJ(Player(3),Player(7),true)
call SetPlayerAllianceStateAllyBJ(Player(3),Player(8),true)
call SetPlayerAllianceStateAllyBJ(Player(3),Player(9),true)
call SetPlayerAllianceStateAllyBJ(Player(3),Player(10),true)
call SetPlayerAllianceStateAllyBJ(Player(4),Player(0),true)
call SetPlayerAllianceStateAllyBJ(Player(4),Player(1),true)
call SetPlayerAllianceStateAllyBJ(Player(4),Player(2),true)
call SetPlayerAllianceStateAllyBJ(Player(4),Player(3),true)
call SetPlayerAllianceStateAllyBJ(Player(4),Player(5),true)
call SetPlayerAllianceStateAllyBJ(Player(4),Player(6),true)
call SetPlayerAllianceStateAllyBJ(Player(4),Player(7),true)
call SetPlayerAllianceStateAllyBJ(Player(4),Player(8),true)
call SetPlayerAllianceStateAllyBJ(Player(4),Player(9),true)
call SetPlayerAllianceStateAllyBJ(Player(4),Player(10),true)
call SetPlayerAllianceStateAllyBJ(Player(5),Player(0),true)
call SetPlayerAllianceStateAllyBJ(Player(5),Player(1),true)
call SetPlayerAllianceStateAllyBJ(Player(5),Player(2),true)
call SetPlayerAllianceStateAllyBJ(Player(5),Player(3),true)
call SetPlayerAllianceStateAllyBJ(Player(5),Player(4),true)
call SetPlayerAllianceStateAllyBJ(Player(5),Player(6),true)
call SetPlayerAllianceStateAllyBJ(Player(5),Player(7),true)
call SetPlayerAllianceStateAllyBJ(Player(5),Player(8),true)
call SetPlayerAllianceStateAllyBJ(Player(5),Player(9),true)
call SetPlayerAllianceStateAllyBJ(Player(5),Player(10),true)
call SetPlayerAllianceStateAllyBJ(Player(6),Player(0),true)
call SetPlayerAllianceStateAllyBJ(Player(6),Player(1),true)
call SetPlayerAllianceStateAllyBJ(Player(6),Player(2),true)
call SetPlayerAllianceStateAllyBJ(Player(6),Player(3),true)
call SetPlayerAllianceStateAllyBJ(Player(6),Player(4),true)
call SetPlayerAllianceStateAllyBJ(Player(6),Player(5),true)
call SetPlayerAllianceStateAllyBJ(Player(6),Player(7),true)
call SetPlayerAllianceStateAllyBJ(Player(6),Player(8),true)
call SetPlayerAllianceStateAllyBJ(Player(6),Player(9),true)
call SetPlayerAllianceStateAllyBJ(Player(6),Player(10),true)
call SetPlayerAllianceStateAllyBJ(Player(7),Player(0),true)
call SetPlayerAllianceStateAllyBJ(Player(7),Player(1),true)
call SetPlayerAllianceStateAllyBJ(Player(7),Player(2),true)
call SetPlayerAllianceStateAllyBJ(Player(7),Player(3),true)
call SetPlayerAllianceStateAllyBJ(Player(7),Player(4),true)
call SetPlayerAllianceStateAllyBJ(Player(7),Player(5),true)
call SetPlayerAllianceStateAllyBJ(Player(7),Player(6),true)
call SetPlayerAllianceStateAllyBJ(Player(7),Player(8),true)
call SetPlayerAllianceStateAllyBJ(Player(7),Player(9),true)
call SetPlayerAllianceStateAllyBJ(Player(7),Player(10),true)
call SetPlayerAllianceStateAllyBJ(Player(8),Player(0),true)
call SetPlayerAllianceStateAllyBJ(Player(8),Player(1),true)
call SetPlayerAllianceStateAllyBJ(Player(8),Player(2),true)
call SetPlayerAllianceStateAllyBJ(Player(8),Player(3),true)
call SetPlayerAllianceStateAllyBJ(Player(8),Player(4),true)
call SetPlayerAllianceStateAllyBJ(Player(8),Player(5),true)
call SetPlayerAllianceStateAllyBJ(Player(8),Player(6),true)
call SetPlayerAllianceStateAllyBJ(Player(8),Player(7),true)
call SetPlayerAllianceStateAllyBJ(Player(8),Player(9),true)
call SetPlayerAllianceStateAllyBJ(Player(8),Player(10),true)
call SetPlayerAllianceStateAllyBJ(Player(9),Player(0),true)
call SetPlayerAllianceStateAllyBJ(Player(9),Player(1),true)
call SetPlayerAllianceStateAllyBJ(Player(9),Player(2),true)
call SetPlayerAllianceStateAllyBJ(Player(9),Player(3),true)
call SetPlayerAllianceStateAllyBJ(Player(9),Player(4),true)
call SetPlayerAllianceStateAllyBJ(Player(9),Player(5),true)
call SetPlayerAllianceStateAllyBJ(Player(9),Player(6),true)
call SetPlayerAllianceStateAllyBJ(Player(9),Player(7),true)
call SetPlayerAllianceStateAllyBJ(Player(9),Player(8),true)
call SetPlayerAllianceStateAllyBJ(Player(9),Player(10),true)
call SetPlayerAllianceStateAllyBJ(Player(10),Player(0),true)
call SetPlayerAllianceStateAllyBJ(Player(10),Player(1),true)
call SetPlayerAllianceStateAllyBJ(Player(10),Player(2),true)
call SetPlayerAllianceStateAllyBJ(Player(10),Player(3),true)
call SetPlayerAllianceStateAllyBJ(Player(10),Player(4),true)
call SetPlayerAllianceStateAllyBJ(Player(10),Player(5),true)
call SetPlayerAllianceStateAllyBJ(Player(10),Player(6),true)
call SetPlayerAllianceStateAllyBJ(Player(10),Player(7),true)
call SetPlayerAllianceStateAllyBJ(Player(10),Player(8),true)
call SetPlayerAllianceStateAllyBJ(Player(10),Player(9),true)
call SetPlayerAllianceStateVisionBJ(Player(0),Player(1),true)
call SetPlayerAllianceStateVisionBJ(Player(0),Player(2),true)
call SetPlayerAllianceStateVisionBJ(Player(0),Player(3),true)
call SetPlayerAllianceStateVisionBJ(Player(0),Player(4),true)
call SetPlayerAllianceStateVisionBJ(Player(0),Player(5),true)
call SetPlayerAllianceStateVisionBJ(Player(0),Player(6),true)
call SetPlayerAllianceStateVisionBJ(Player(0),Player(7),true)
call SetPlayerAllianceStateVisionBJ(Player(0),Player(8),true)
call SetPlayerAllianceStateVisionBJ(Player(0),Player(9),true)
call SetPlayerAllianceStateVisionBJ(Player(0),Player(10),true)
call SetPlayerAllianceStateVisionBJ(Player(1),Player(0),true)
call SetPlayerAllianceStateVisionBJ(Player(1),Player(2),true)
call SetPlayerAllianceStateVisionBJ(Player(1),Player(3),true)
call SetPlayerAllianceStateVisionBJ(Player(1),Player(4),true)
call SetPlayerAllianceStateVisionBJ(Player(1),Player(5),true)
call SetPlayerAllianceStateVisionBJ(Player(1),Player(6),true)
call SetPlayerAllianceStateVisionBJ(Player(1),Player(7),true)
call SetPlayerAllianceStateVisionBJ(Player(1),Player(8),true)
call SetPlayerAllianceStateVisionBJ(Player(1),Player(9),true)
call SetPlayerAllianceStateVisionBJ(Player(1),Player(10),true)
call SetPlayerAllianceStateVisionBJ(Player(2),Player(0),true)
call SetPlayerAllianceStateVisionBJ(Player(2),Player(1),true)
call SetPlayerAllianceStateVisionBJ(Player(2),Player(3),true)
call SetPlayerAllianceStateVisionBJ(Player(2),Player(4),true)
call SetPlayerAllianceStateVisionBJ(Player(2),Player(5),true)
call SetPlayerAllianceStateVisionBJ(Player(2),Player(6),true)
call SetPlayerAllianceStateVisionBJ(Player(2),Player(7),true)
call SetPlayerAllianceStateVisionBJ(Player(2),Player(8),true)
call SetPlayerAllianceStateVisionBJ(Player(2),Player(9),true)
call SetPlayerAllianceStateVisionBJ(Player(2),Player(10),true)
call SetPlayerAllianceStateVisionBJ(Player(3),Player(0),true)
call SetPlayerAllianceStateVisionBJ(Player(3),Player(1),true)
call SetPlayerAllianceStateVisionBJ(Player(3),Player(2),true)
call SetPlayerAllianceStateVisionBJ(Player(3),Player(4),true)
call SetPlayerAllianceStateVisionBJ(Player(3),Player(5),true)
call SetPlayerAllianceStateVisionBJ(Player(3),Player(6),true)
call SetPlayerAllianceStateVisionBJ(Player(3),Player(7),true)
call SetPlayerAllianceStateVisionBJ(Player(3),Player(8),true)
call SetPlayerAllianceStateVisionBJ(Player(3),Player(9),true)
call SetPlayerAllianceStateVisionBJ(Player(3),Player(10),true)
call SetPlayerAllianceStateVisionBJ(Player(4),Player(0),true)
call SetPlayerAllianceStateVisionBJ(Player(4),Player(1),true)
call SetPlayerAllianceStateVisionBJ(Player(4),Player(2),true)
call SetPlayerAllianceStateVisionBJ(Player(4),Player(3),true)
call SetPlayerAllianceStateVisionBJ(Player(4),Player(5),true)
call SetPlayerAllianceStateVisionBJ(Player(4),Player(6),true)
call SetPlayerAllianceStateVisionBJ(Player(4),Player(7),true)
call SetPlayerAllianceStateVisionBJ(Player(4),Player(8),true)
call SetPlayerAllianceStateVisionBJ(Player(4),Player(9),true)
call SetPlayerAllianceStateVisionBJ(Player(4),Player(10),true)
call SetPlayerAllianceStateVisionBJ(Player(5),Player(0),true)
call SetPlayerAllianceStateVisionBJ(Player(5),Player(1),true)
call SetPlayerAllianceStateVisionBJ(Player(5),Player(2),true)
call SetPlayerAllianceStateVisionBJ(Player(5),Player(3),true)
call SetPlayerAllianceStateVisionBJ(Player(5),Player(4),true)
call SetPlayerAllianceStateVisionBJ(Player(5),Player(6),true)
call SetPlayerAllianceStateVisionBJ(Player(5),Player(7),true)
call SetPlayerAllianceStateVisionBJ(Player(5),Player(8),true)
call SetPlayerAllianceStateVisionBJ(Player(5),Player(9),true)
call SetPlayerAllianceStateVisionBJ(Player(5),Player(10),true)
call SetPlayerAllianceStateVisionBJ(Player(6),Player(0),true)
call SetPlayerAllianceStateVisionBJ(Player(6),Player(1),true)
call SetPlayerAllianceStateVisionBJ(Player(6),Player(2),true)
call SetPlayerAllianceStateVisionBJ(Player(6),Player(3),true)
call SetPlayerAllianceStateVisionBJ(Player(6),Player(4),true)
call SetPlayerAllianceStateVisionBJ(Player(6),Player(5),true)
call SetPlayerAllianceStateVisionBJ(Player(6),Player(7),true)
call SetPlayerAllianceStateVisionBJ(Player(6),Player(8),true)
call SetPlayerAllianceStateVisionBJ(Player(6),Player(9),true)
call SetPlayerAllianceStateVisionBJ(Player(6),Player(10),true)
call SetPlayerAllianceStateVisionBJ(Player(7),Player(0),true)
call SetPlayerAllianceStateVisionBJ(Player(7),Player(1),true)
call SetPlayerAllianceStateVisionBJ(Player(7),Player(2),true)
call SetPlayerAllianceStateVisionBJ(Player(7),Player(3),true)
call SetPlayerAllianceStateVisionBJ(Player(7),Player(4),true)
call SetPlayerAllianceStateVisionBJ(Player(7),Player(5),true)
call SetPlayerAllianceStateVisionBJ(Player(7),Player(6),true)
call SetPlayerAllianceStateVisionBJ(Player(7),Player(8),true)
call SetPlayerAllianceStateVisionBJ(Player(7),Player(9),true)
call SetPlayerAllianceStateVisionBJ(Player(7),Player(10),true)
call SetPlayerAllianceStateVisionBJ(Player(8),Player(0),true)
call SetPlayerAllianceStateVisionBJ(Player(8),Player(1),true)
call SetPlayerAllianceStateVisionBJ(Player(8),Player(2),true)
call SetPlayerAllianceStateVisionBJ(Player(8),Player(3),true)
call SetPlayerAllianceStateVisionBJ(Player(8),Player(4),true)
call SetPlayerAllianceStateVisionBJ(Player(8),Player(5),true)
call SetPlayerAllianceStateVisionBJ(Player(8),Player(6),true)
call SetPlayerAllianceStateVisionBJ(Player(8),Player(7),true)
call SetPlayerAllianceStateVisionBJ(Player(8),Player(9),true)
call SetPlayerAllianceStateVisionBJ(Player(8),Player(10),true)
call SetPlayerAllianceStateVisionBJ(Player(9),Player(0),true)
call SetPlayerAllianceStateVisionBJ(Player(9),Player(1),true)
call SetPlayerAllianceStateVisionBJ(Player(9),Player(2),true)
call SetPlayerAllianceStateVisionBJ(Player(9),Player(3),true)
call SetPlayerAllianceStateVisionBJ(Player(9),Player(4),true)
call SetPlayerAllianceStateVisionBJ(Player(9),Player(5),true)
call SetPlayerAllianceStateVisionBJ(Player(9),Player(6),true)
call SetPlayerAllianceStateVisionBJ(Player(9),Player(7),true)
call SetPlayerAllianceStateVisionBJ(Player(9),Player(8),true)
call SetPlayerAllianceStateVisionBJ(Player(9),Player(10),true)
call SetPlayerAllianceStateVisionBJ(Player(10),Player(0),true)
call SetPlayerAllianceStateVisionBJ(Player(10),Player(1),true)
call SetPlayerAllianceStateVisionBJ(Player(10),Player(2),true)
call SetPlayerAllianceStateVisionBJ(Player(10),Player(3),true)
call SetPlayerAllianceStateVisionBJ(Player(10),Player(4),true)
call SetPlayerAllianceStateVisionBJ(Player(10),Player(5),true)
call SetPlayerAllianceStateVisionBJ(Player(10),Player(6),true)
call SetPlayerAllianceStateVisionBJ(Player(10),Player(7),true)
call SetPlayerAllianceStateVisionBJ(Player(10),Player(8),true)
call SetPlayerAllianceStateVisionBJ(Player(10),Player(9),true)
call SetPlayerTeam(Player(11),1)
endfunction
function InitAllyPriorities takes nothing returns nothing
call SetStartLocPrioCount(0,10)
call SetStartLocPrio(0,0,1,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(0,1,2,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(0,2,3,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(0,3,4,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(0,4,5,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(0,5,6,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(0,6,7,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(0,7,8,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(0,8,9,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(0,9,10,MAP_LOC_PRIO_HIGH)
call SetStartLocPrioCount(1,10)
call SetStartLocPrio(1,0,0,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(1,1,2,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(1,2,3,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(1,3,4,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(1,4,5,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(1,5,6,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(1,6,7,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(1,7,8,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(1,8,9,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(1,9,10,MAP_LOC_PRIO_HIGH)
call SetStartLocPrioCount(2,10)
call SetStartLocPrio(2,0,0,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(2,1,1,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(2,2,3,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(2,3,4,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(2,4,5,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(2,5,6,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(2,6,7,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(2,7,8,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(2,8,9,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(2,9,10,MAP_LOC_PRIO_HIGH)
call SetStartLocPrioCount(3,10)
call SetStartLocPrio(3,0,0,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(3,1,1,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(3,2,2,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(3,3,4,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(3,4,5,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(3,5,6,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(3,6,7,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(3,7,8,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(3,8,9,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(3,9,10,MAP_LOC_PRIO_HIGH)
call SetStartLocPrioCount(4,10)
call SetStartLocPrio(4,0,0,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(4,1,1,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(4,2,2,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(4,3,3,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(4,4,5,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(4,5,6,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(4,6,7,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(4,7,8,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(4,8,9,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(4,9,10,MAP_LOC_PRIO_HIGH)
call SetStartLocPrioCount(5,10)
call SetStartLocPrio(5,0,0,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(5,1,1,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(5,2,2,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(5,3,3,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(5,4,4,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(5,5,6,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(5,6,7,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(5,7,8,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(5,8,9,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(5,9,10,MAP_LOC_PRIO_HIGH)
call SetStartLocPrioCount(6,10)
call SetStartLocPrio(6,0,0,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(6,1,1,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(6,2,2,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(6,3,3,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(6,4,4,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(6,5,5,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(6,6,7,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(6,7,8,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(6,8,9,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(6,9,10,MAP_LOC_PRIO_HIGH)
call SetStartLocPrioCount(7,10)
call SetStartLocPrio(7,0,0,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(7,1,1,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(7,2,2,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(7,3,3,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(7,4,4,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(7,5,5,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(7,6,6,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(7,7,8,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(7,8,9,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(7,9,10,MAP_LOC_PRIO_HIGH)
call SetStartLocPrioCount(8,10)
call SetStartLocPrio(8,0,0,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(8,1,1,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(8,2,2,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(8,3,3,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(8,4,4,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(8,5,5,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(8,6,6,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(8,7,7,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(8,8,9,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(8,9,10,MAP_LOC_PRIO_HIGH)
call SetStartLocPrioCount(9,10)
call SetStartLocPrio(9,0,0,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(9,1,1,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(9,2,2,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(9,3,3,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(9,4,4,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(9,5,5,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(9,6,6,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(9,7,7,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(9,8,8,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(9,9,10,MAP_LOC_PRIO_HIGH)
call SetStartLocPrioCount(10,10)
call SetStartLocPrio(10,0,0,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(10,1,1,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(10,2,2,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(10,3,3,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(10,4,4,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(10,5,5,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(10,6,6,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(10,7,7,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(10,8,8,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(10,9,9,MAP_LOC_PRIO_HIGH)
call SetStartLocPrioCount(11,9)
call SetStartLocPrio(11,0,0,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(11,1,1,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(11,2,2,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(11,3,3,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(11,4,4,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(11,5,5,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(11,6,6,MAP_LOC_PRIO_LOW)
call SetStartLocPrio(11,7,8,MAP_LOC_PRIO_HIGH)
call SetStartLocPrio(11,8,9,MAP_LOC_PRIO_HIGH)
endfunction
function main takes nothing returns nothing
local weathereffect we
call SetCameraBounds(-3328.0+GetCameraMargin(CAMERA_MARGIN_LEFT),-3584.0+GetCameraMargin(CAMERA_MARGIN_BOTTOM),3328.0-GetCameraMargin(CAMERA_MARGIN_RIGHT),3072.0-GetCameraMargin(CAMERA_MARGIN_TOP),-3328.0+GetCameraMargin(CAMERA_MARGIN_LEFT),3072.0-GetCameraMargin(CAMERA_MARGIN_TOP),3328.0-GetCameraMargin(CAMERA_MARGIN_RIGHT),-3584.0+GetCameraMargin(CAMERA_MARGIN_BOTTOM))
call SetDayNightModels("Environment\\DNC\\DNCLordaeron\\DNCLordaeronTerrain\\DNCLordaeronTerrain.mdl","Environment\\DNC\\DNCLordaeron\\DNCLordaeronUnit\\DNCLordaeronUnit.mdl")
set we=AddWeatherEffect(Rect(-4096.0,-4096.0,4096.0,4096.0),'SNhs')
call EnableWeatherEffect(we,true)
call NewSoundEnvironment("Default")
call SetAmbientDaySound("NorthrendDay")
call SetAmbientNightSound("NorthrendNight")
call SetMapMusic("Music",true,0)
call InitSounds()
call CreateRegions()
call InitRandomGroups()
call CreateAllUnits()
call InitBlizzard()
call InitGlobals()
call InitCustomTriggers()
call RunInitializationTriggers()
endfunction
function config takes nothing returns nothing
call SetMapName("TRIGSTR_001")
call SetMapDescription("TRIGSTR_003")
call SetPlayers(12)
call SetTeams(12)
call SetGamePlacement(MAP_PLACEMENT_TEAMS_TOGETHER)
call DefineStartLocation(0,-3072.0,2688.0)
call DefineStartLocation(1,-3072.0,2688.0)
call DefineStartLocation(2,-3072.0,2688.0)
call DefineStartLocation(3,-3072.0,2688.0)
call DefineStartLocation(4,-3072.0,2688.0)
call DefineStartLocation(5,-3072.0,2688.0)
call DefineStartLocation(6,-3072.0,2688.0)
call DefineStartLocation(7,-3072.0,2688.0)
call DefineStartLocation(8,-3072.0,2688.0)
call DefineStartLocation(9,-3072.0,2688.0)
call DefineStartLocation(10,-3072.0,2688.0)
call DefineStartLocation(11,-3072.0,2688.0)
call InitCustomPlayerSlots()
call InitCustomTeams()
call InitAllyPriorities()
endfunction
