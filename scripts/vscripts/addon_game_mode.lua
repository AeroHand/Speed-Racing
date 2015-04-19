require('generateM')
-- Generated from template
hulage=0
benti={}
pvalue=90
if jajajaGameMode == nil then
	jajajaGameMode = class({})
end
function PrecacheEveryThingFromKV( context )
  local kv_files = {"scripts/npc/npc_units_custom.txt","scripts/npc/npc_abilities_custom.txt","scripts/npc/npc_heroes_custom.txt","scripts/npc/npc_abilities_override.txt","npc_items_custom.txt"}
  for _, kv in pairs(kv_files) do
    local kvs = LoadKeyValues(kv)
    if kvs then
      print("BEGIN TO PRECACHE RESOURCE FROM: ", kv)
      PrecacheEverythingFromTable( context, kvs)
    end
  end

 local zr={
 

    }
     

    print("loading shiping")
  local t=#zr;
  for i=1,t do

      PrecacheResource( "model", zr[i], context)

    end

    print("done loading shiping")


end
function PrecacheEverythingFromTable( context, kvtable)
  for key, value in pairs(kvtable) do
    if type(value) == "table" then
      PrecacheEverythingFromTable( context, value )
    else
      if string.find(value, "vpcf") then
        PrecacheResource( "particle",  value, context)
        print("PRECACHE PARTICLE RESOURCE", value)
      end
      if string.find(value, "vmdl") then  
        PrecacheResource( "model",  value, context)
        print("PRECACHE MODEL RESOURCE", value)
      end
      if string.find(value, "vsndevts") then
        PrecacheResource( "soundfile",  value, context)
        print("PRECACHE SOUND RESOURCE", value)
      end
    end
  end

   
end
function Precache( context )
  print("BEGIN TO PRECACHE RESOURCE")
  local time = GameRules:GetGameTime()
  PrecacheEveryThingFromKV( context )
  time = time - GameRules:GetGameTime()
  print("DONE PRECACHEING IN:"..tostring(time).."Seconds")
end

-- Create the game mode when we activate
function Activate()
	GameRules.AddonTemplate = jajajaGameMode()
	GameRules.AddonTemplate:InitGameMode()
end

function jajajaGameMode:InitGameMode()
	print( "Template addon is loaded." )

    GameRules:SetPreGameTime(10)
	GameRules:GetGameModeEntity():SetThink( "OnThink", self, "GlobalThink", 2 )
  ListenToGameEvent("npc_spawned", Dynamic_Wrap(jajajaGameMode, "OnNPCSpawned"), self)
  ListenToGameEvent("entity_killed", Dynamic_Wrap(jajajaGameMode, "OnEntityKilled"), self)
    --注册英雄行走方向命令

    Convars:RegisterCommand( "UpWalking", function(name)
    --锁定发送命令的玩家
    local cmdPlayer = Convars:GetCommandClient()
    if cmdPlayer then
         
        return self:WalkingUp(cmdPlayer) 
    end
    end, "walking up", 0 )

    Convars:RegisterCommand( "DownWalking", function(name)
    --锁定发送命令的玩家
    local cmdPlayer = Convars:GetCommandClient()
    if cmdPlayer then
         
        return self:WalkingDown(cmdPlayer) 
    end
    end, "walking down", 0 )

    Convars:RegisterCommand( "LeftWalking", function(name)
    --锁定发送命令的玩家
    local cmdPlayer = Convars:GetCommandClient()
    if cmdPlayer then
         
        return self:WalkingLeft(cmdPlayer) 
    end
    end, "walking left", 0 )

    Convars:RegisterCommand( "RightWalking", function(name)
    --锁定发送命令的玩家
    local cmdPlayer = Convars:GetCommandClient()
    if cmdPlayer then
         
        return self:WalkingRight(cmdPlayer) 
    end
    end, "walking right", 0 )    

 --注册英雄行走方向结束命令

    Convars:RegisterCommand( "UpWalkingDone", function(name)
    --锁定发送命令的玩家
    local cmdPlayer = Convars:GetCommandClient()
    if cmdPlayer then
         
        return self:WalkingUpDone(cmdPlayer) 
    end
    end, "walking up Done", 0 )

    Convars:RegisterCommand( "DownWalkingDone", function(name)
    --锁定发送命令的玩家
    local cmdPlayer = Convars:GetCommandClient()
    if cmdPlayer then
         
        return self:WalkingDownDone(cmdPlayer) 
    end
    end, "walking down Done", 0 )

    Convars:RegisterCommand( "LeftWalkingDone", function(name)
    --锁定发送命令的玩家
    local cmdPlayer = Convars:GetCommandClient()
    if cmdPlayer then
         
        return self:WalkingLeftDone(cmdPlayer) 
    end
    end, "walking left Done", 0 )

    Convars:RegisterCommand( "RightWalkingDone", function(name)
    --锁定发送命令的玩家
    local cmdPlayer = Convars:GetCommandClient()
    if cmdPlayer then
         
        return self:WalkingRightDone(cmdPlayer) 
    end
    end, "walking right Done", 0 )  

    Convars:RegisterCommand( "GasolineAcc", function(name)
    --锁定发送命令的玩家
    local cmdPlayer = Convars:GetCommandClient()
    if cmdPlayer then
         
        return self:GasolineAcc(cmdPlayer) 
    end
    end, "Gasoline start", 0 )

    Convars:RegisterCommand( "GasolineAccDone", function(name)
    --锁定发送命令的玩家
    local cmdPlayer = Convars:GetCommandClient()
    if cmdPlayer then
         
        return self:GasolineAccDone(cmdPlayer) 
    end
    end, "Gasoline Done", 0 )

    GameRules:GetGameModeEntity():SetCameraDistanceOverride(500);
    GameRules:GetGameModeEntity():SetFogOfWarDisabled(true);

end

-- Evaluate the state of the game
function jajajaGameMode:OnThink()
	if hulage==0 then
       hulage=1
       FireGameEvent("console_command", {pid=0, command="dota_ability_debug 1"})
       FireGameEvent("console_command", {pid=0, command="dota_camera_pitch_max 25"})
       FireGameEvent("console_command", {pid=0, command="dota_camera_lock_lerp 0"})
       FireGameEvent("console_command", {pid=0, command="dota_camera_lock"})
      --FireGameEvent("console_command", {pid=0, command="dota_camera_pitch_max 10"});
       FireGameEvent("console_command", {pid=0, command="r_farz 6000"});
       FireGameEvent("console_command", {pid=0, command="unbindall"});
       FireGameEvent("console_command", {pid=0, command="alias \"+move_left\" \"LeftWalking\""});
       FireGameEvent("console_command", {pid=0, command="alias \"-move_left\" \"LeftWalkingDone\""});
       FireGameEvent("console_command", {pid=0, command="alias \"+move_right\" \"RightWalking\""});
       FireGameEvent("console_command", {pid=0, command="alias \"-move_right\" \"RightWalkingDone\""});
       FireGameEvent("console_command", {pid=0, command="bind leftarrow +move_left"});
       FireGameEvent("console_command", {pid=0, command="bind rightarrow +move_right"});

       FireGameEvent("console_command", {pid=0, command="alias \"+move_up\" \"UpWalking\""});
       FireGameEvent("console_command", {pid=0, command="alias \"-move_up\" \"UpWalkingDone\""});
       FireGameEvent("console_command", {pid=0, command="alias \"+move_down\" \"DownWalking\""});
       FireGameEvent("console_command", {pid=0, command="alias \"-move_down\" \"DownWalkingDone\""});
       FireGameEvent("console_command", {pid=0, command="bind uparrow +move_up"});
       FireGameEvent("console_command", {pid=0, command="bind downarrow +move_down"});
       
       FireGameEvent("console_command", {pid=0, command="alias \"+gasoline\" \"GasolineAcc\""});
       FireGameEvent("console_command", {pid=0, command="alias \"-gasoline\" \"GasolineAccDone\""});    
       FireGameEvent("console_command", {pid=0, command="bind space +gasoline"});

     --    FireGameEvent("console_command", {pid=0, command="dota_sf_hud_inventory 0"})
     --    FireGameEvent("console_command", {pid=0, command="dota_render_crop_height 0"})
        ps_init()
       -- gm()
      end

	if GameRules:State_Get() == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
		--print( "Template addon script is running." )
	elseif GameRules:State_Get() >= DOTA_GAMERULES_STATE_POST_GAME then
		return nil
	end
	return 1
end


function jajajaGameMode:GasolineAcc(player)

  ps[player:GetPlayerID()][8]=1
  --添加特效
  particleID = ParticleManager:CreateParticle("particles/econ/courier/courier_greevil_green/courier_greevil_green_ambient_3.vpcf", PATTACH_ABSORIGIN_FOLLOW,ps[player:GetPlayerID()][9])
  ParticleManager:SetParticleControl(particleID,0,ps[player:GetPlayerID()][9]:GetOrigin())
  ps[player:GetPlayerID()][4]=ps[player:GetPlayerID()][4]+300
end

function jajajaGameMode:GasolineAccDone(player)

  ps[player:GetPlayerID()][8]=0
  --删除特效
  --ps[player:GetPlayerID()][9]:RemoveModifierByName("modifier_ability_passive"})
  ParticleManager:DestroyParticle(particleID, true)
  ps[player:GetPlayerID()][4]=ps[player:GetPlayerID()][4]-300
end

--行走开始
function jajajaGameMode:WalkingUp(player)
  print("get walking up!")
  ps[player:GetPlayerID()][7]=1
end

function jajajaGameMode:WalkingDown(player)
  print("get walking down!")
 --[[ local hero=player:GetAssignedHero()
  local vec=hero:GetAbsOrigin()
  local newvec
  newvec=Vector(vec.x,vec.y-500,vec.z)
  walk(hero,newvec)]]

  ps[player:GetPlayerID()][7]=-1


end

function jajajaGameMode:WalkingLeft(player)
  print("get walking left!")
  --[[
  local hero=player:GetAssignedHero()
  local vec=hero:GetAbsOrigin()
  local newvec
  newvec=Vector(vec.x-500,vec.y,vec.z)
  walk(hero,newvec)]]
  local pid=player:GetPlayerID()
  local layer=ps[pid][6]
  --当前操作队列为左
  ps[pid][1][layer]=1
  --操作队列指针+1
  ps[pid][6]=ps[pid][6]+1
end

function jajajaGameMode:WalkingRight(player)
  print("get walking right!")
  --[[
  local hero=player:GetAssignedHero()
  local vec=hero:GetAbsOrigin()
  local newvec
  newvec=Vector(vec.x+500,vec.y,vec.z)
  walk(hero,newvec)]]
  local pid=player:GetPlayerID()
  local layer=ps[pid][6]
  ps[pid][1][layer]=2
  ps[pid][6]=ps[pid][6]+1
end

--行走结束
function jajajaGameMode:WalkingUpDone(player)

  ps[player:GetPlayerID()][7]=0
end

function jajajaGameMode:WalkingDownDone(player)

  ps[player:GetPlayerID()][7]=0
end

function jajajaGameMode:WalkingLeftDone(player)
  local pid=player:GetPlayerID()
  --获得当前操作队列指针
  ps[pid][6]=ps[pid][6]-1
  local layer=ps[pid][6]
  --查看当前操作是否为向左
  if (ps[pid][1][layer]==1) then
    ps[pid][1][layer]=0
  else
    --当前队列不为左 右向操作下移一位
    ps[pid][1][layer]=0
    ps[pid][1][layer-1]=2
  end  
end

function jajajaGameMode:WalkingRightDone(player)
  local pid=player:GetPlayerID()
  --获得当前操作队列指针
  ps[pid][6]=ps[pid][6]-1
  local layer=ps[pid][6]
  --查看当前操作是否为向右
  if (ps[pid][1][layer]==2) then
    ps[pid][1][layer]=0
  else
    --当前队列不为右 左向操作下移一位
    ps[pid][1][layer]=0
    ps[pid][1][layer-1]=1
  end  
end


--行走函数
function walk(unit,position)
  local newOrder = {
         
    UnitIndex = unit:entindex(),             
    OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,  
    TargetIndex = nil,                   
    AbilityIndex = 0,                             
    Position = position,                
    Queue = 0                       
  }
          
  ExecuteOrderFromTable(newOrder)
end

function atk(unit,position)
  
  unit:CastAbilityOnPosition(position,unit:GetAbilityByIndex(0),0)

--[[
  local newOrder = {
         
    UnitIndex = unit:entindex(),             
    OrderType = DOTA_UNIT_ORDER_CAST_POSITION,  
    TargetIndex = nil,                   
    AbilityIndex = 0,                             
    Position = position,                
    Queue = 0                       
  }
          
  ExecuteOrderFromTable(newOrder)]]
end

function jajajaGameMode:OnNPCSpawned( keys )

   local unit =  EntIndexToHScript(keys.entindex)
   
   if unit:IsHero() then                      --Èç¹ûÊÇÓ¢ÐÛ
      FireGameEvent("console_command", {pid=0, command="dota_create_item item_force_staff"})
      unit:SetAbilityPoints(0)                --È¡Ïû¼¼ÄÜµã
 
      local j=0 
      zou=0
      she=0
      for j = 0,15,1 do
        local temp1=unit:GetAbilityByIndex(j) --»ñÈ¡¼¼ÄÜÊµÌå
        if temp1 then
          temp1:SetLevel(1)                   --ÉèÖÃ¼¼ÄÜµÈ¼¶
          print(j)
          DeepPrintTable(temp1)
          if j==2 then
            temp1:CastAbility()
          end 
        end
      end

      pid=unit:GetPlayerOwnerID()
      ps[pid][9]=unit
      ps[pid][5]=unit:GetForwardVector()
      view(ps[pid][5],pid)

      unit:RemoveModifierByName("modifier_ability_passive")
      GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("moguidebufa"), 
        function()
          --unit:英雄
          --pid:playerID

          --计算现有速度buff叠加层数
          
          --如果玩家没有使用加速
          if (ps[pid][8]==0) then
            --print("gasoline accelerate done"})
            --如果之前在加速 就取消加速
            if ps[pid][4]>300 then
              ps[pid][4]=ps[pid][4]-300
            end  
          else
            --如果玩家使用了加速
            print("gasoline accelerate start")
            --如果现在不是加速状态
            if ps[pid][10]>20  then
              --如果还有油
              ps[pid][10]=ps[pid][10]-20
            end
          end
          

          ps[pid][4]=ps[pid][4]+ps[pid][7]
          
          if (ps[pid][4]<0) then
            ps[pid][4]=0
          end
          
          local tempability=unit:GetAbilityByIndex(3)
          unit:SetModifierStackCount("RapidCreature_Nocturnal_Night_Modifier",tempability,ps[pid][4])

          local vec=unit:GetAbsOrigin()
          --检测是否卡住 卡住移速buff清零
          if (vec==lastpos) then
            local tempability=unit:GetAbilityByIndex(3)
            ps[pid][4]=0
            unit:SetModifierStackCount("RapidCreature_Nocturnal_Night_Modifier",tempability,ps[pid][4])

          end
          
          --倒退
          if (ps[pid][7]==-1) and (ps[pid][4]<=0) then
            local point=unit:GetForwardVector()
            newvec=Vector(-point.x,-point.y,point.z)
            unit:SetAbsOrigin(vec+newvec*10)    
          end

          local jilu=vec
          local newvec
          local layer=ps[pid][6]-1
          zou=0
          if ps[pid][0]==0 then
            newvec=vec
          else
            zou=1
            if ps[pid][0]==1 then  --往上走
              newvec=Vector(vec.x,vec.y+30,vec.z)
             else
              newvec=Vector(vec.x,vec.y-30,vec.z)
            end
          end
          vec=newvec
          local chaoxiang=unit:GetForwardVector()
          local xincx=chaoxiang
          if ps[pid][1][layer]==0 then
            newvec=vec
          else
            zou=1
            if ps[pid][1][layer]==1 then  --往左走
              xincx=Vector(chaoxiang.x*math.cos(math.pi/180*4)-chaoxiang.y*math.sin(math.pi/180*4),chaoxiang.x*math.sin(math.pi/90)+chaoxiang.y*math.cos(math.pi/90),chaoxiang.z)
              --pvalue=pvalue+4
              --FireGameEvent("console_command", {pid=0, command="dota_camera_yaw "..tostring(pvalue-90))
             else
              --pvalue=pvalue-4
              xincx=Vector(chaoxiang.x*math.cos(math.pi/180*4)+chaoxiang.y*math.sin(math.pi/180*4),-chaoxiang.x*math.sin(math.pi/90)+chaoxiang.y*math.cos(math.pi/90),chaoxiang.z)
              --FireGameEvent("console_command", {pid=0, command="dota_camera_yaw "..tostring(pvalue-90))


            end
          end
          vec=newvec
          if zou==1 then
            if she==0 then
              unit:SetForwardVector(xincx)
            end  
          end 
          view(xincx,pid) 
          walk(unit,jilu+xincx*200)

          lastpos=unit:GetAbsOrigin()

          ps[pid][10]=ps[pid][10]+2
          if ps[pid][10]>100 then
            ps[pid][10]=100
          end  
          print("current oil")
          print(ps[pid][10])
          sendinfotoui()

          return 0.04
        end,0)


   end

end

--摄像机状态调整
function view(a,pid)
  pvalue=-math.deg(math.atan(ps[pid][5].y/ps[pid][5].x)-math.atan(a.y/a.x))

 if a.x<0  then
   pvalue=pvalue+180
 end

  FireGameEvent("console_command", {pid=pid, command="dota_camera_yaw "..tostring(pvalue)})  
end

function  ps_init()
  
  ps={}                       --行走状态
  local i
  local j
  for i=0,9 do
    --if PlayerResource:IsValidPlayer(i) then

        print("playerconnected:")
        print(i)

        ps[i]={}     --0为上下 1为左右操作队列 2为攻击上下 3为攻击左右 4为速度 5为初始朝向 6为左右操作队列指针
                     --7为速度开关 8为汽油加速开关 9为英雄本体 10为油量
                     --满油量为100 每秒+2 开启每秒-20
        ps[i][0]=0
        ps[i][1]={}
        ps[i][4]=0
        ps[i][6]=0
        ps[i][7]=0
        ps[i][8]=0
        ps[i][10]=0
        for j=2,4 do                   
          ps[i][j]=0
          ps[i][1][j-3]=0
        end
      
    --[[    
      else
        
        ps[i]=nil
      
      end]]
    end

    local temp=Entities:FindByName(nil,"zibao") --所有单位假死沉睡的最终之地 神之居所瓦尔哈拉！
    zibao=temp:GetAbsOrigin()
end

function jajajaGameMode:OnEntityKilled( keys )
        print("OnEntityKilled")
        DeepPrintTable(keys)    --详细打印传递进来的表
        local burden=EntIndexToHScript(keys.entindex_killed)
        burden:SetAbsOrigin(zibao)
end

function sendinfotoui() 

  FireGameEvent('p_update',{pp1=ps[0][10],pp2=ps[1][10],pp3=ps[2][10]})

end