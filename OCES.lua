--[[
	OneClickEnchantScroll v6.2.0.0 (r16)
	
	Copyright (c) 2010-2015, All rights reserved.
	
	This World of Warcraft User Interface AddOn is written an maintained by:
		Sará @ Festung der Stürme (EU-de) - Sara#2672 - sarafdswow@gmail.com
		
	You may use this AddOn free of monetary charge and modify this AddOn for personal use.
	You may redistribute modified versions of this AddOn, as long as you credit the original author(s).
	
	THIS ADDON IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.
]]

local TEXT = "Scroll" -- default english button text
local VZ = GetSpellInfo(7411)
local loc = GetLocale()
if loc == "deDE" then
	TEXT = "Rolle"
elseif loc == "frFR" then
	TEXT = "Parchemin"
elseif loc == "itIT" then
	TEXT = "Pergamene"
elseif (loc == "esES") or (loc == "esMX") then
	TEXT = "Pergamino"
elseif (loc == "ptBR") or (loc == "ptPT") then
	TEXT = "Pergaminho"
elseif loc == "ruRU" then
	TEXT = "Свиток"
elseif loc == "koKR" then
	TEXT = "두루마리"
elseif loc == "zhCN" then
	TEXT = "卷轴"
elseif loc == "zhTW" then
	TEXT = "卷軸"
end

local f=CreateFrame("Button","TradeSkillCreateScrollButton",TradeSkillFrame,"MagicButtonTemplate")
f:SetPoint("TOPRIGHT",TradeSkillCreateButton,"TOPLEFT")
f:SetScript("OnClick",function()
	DoTradeSkill(TradeSkillFrame.selectedSkill)
	UseItemByName(38682)
end)

local function OCES_TradeSkillFrame_SetSelection(id)
	local skillName,_,_,_,altVerb = GetTradeSkillInfo(id)
	if IsTradeSkillGuild() or IsTradeSkillLinked() then
		f:Hide()
	elseif (altVerb and CURRENT_TRADESKILL==VZ) then
		f:Show()
		local creatable = 1
		if not skillName then
			creatable = nil
		end
		local scrollnum = GetItemCount(38682)
		TradeSkillCreateScrollButton:SetText(TEXT.." ("..scrollnum..")")
		if scrollnum == 0 then
			creatable = nil
		end
		for i=1,GetTradeSkillNumReagents(id) do
			local _,_,reagentCount,playerReagentCount = GetTradeSkillReagentInfo(id,i)
			if playerReagentCount < reagentCount then
				creatable = nil
			end
		end
		if creatable then
			TradeSkillCreateScrollButton:Enable()
		else
			TradeSkillCreateScrollButton:Disable()
		end
	else
		f:Hide()
	end
end

hooksecurefunc("TradeSkillFrame_SetSelection", OCES_TradeSkillFrame_SetSelection);
