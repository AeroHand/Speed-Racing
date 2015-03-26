function gm()
  local i
  ggg={}
  for i=1,8,1 do
    temp=Entities:FindByName(ni,"sp"..tostring(i));
    ggg[i]=temp:GetAbsOrigin()
    GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("shuaiguai"), 
        function()
          mo=CreateUnitByName("npc_demon_"..tostring(RandomInt(1, 6))..tostring(RandomInt(1,2)),ggg[i], true, nil, nil, DOTA_TEAM_NEUTRALS)

          

          return 10
        end,0)
  end	
end

