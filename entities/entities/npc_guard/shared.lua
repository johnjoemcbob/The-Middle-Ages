 ENT.Base = "npc_base"
 ENT.Type = "ai"
   
 ENT.PrintName = "Town Guard"
 ENT.Author = "Xystus234"
 ENT.Contact = ""
 ENT.Purpose = "For npc battles"
 ENT.Instructions = "Spawns a Guard"
 ENT.Information = "Guards the town from enemies"  
 ENT.Category = "Medieval Roleplay"
 
 ENT.AutomaticFrameAdvance = true
   
 ENT.Spawnable = true
 ENT.AdminSpawnable = true

function ENT:SetAutomaticFrameAdvance( bUsingAnim )
  self.AutomaticFrameAdvance = bUsingAnim
end 