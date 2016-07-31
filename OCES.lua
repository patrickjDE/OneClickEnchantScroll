--[[
	OneClickEnchantScroll v7.0.3.0 (r17)
	Copyright (c) 2010-2016, All rights reserved.
	
	Written an maintained by:
		Sará @ Festung der Stürme (EU-de) - Sara#2672 - sarafdswow@gmail.com
		
	You may use this AddOn free of monetary charge and modify this AddOn for personal use.
	You may redistribute modified versions of this AddOn, as long as you credit the original author(s).
	
	THIS ADDON IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.
]]

local scrollText = "Scroll"; -- default english button text
local enchantingTradeSkillName = GetSpellInfo(7411);
local loc = GetLocale();
if loc == "deDE" then
	scrollText = "Rolle";
elseif loc == "frFR" then
	scrollText = "Parchemin";
elseif loc == "itIT" then
	scrollText = "Pergamene";
elseif (loc == "esES") or (loc == "esMX") then
	scrollText = "Pergamino";
elseif (loc == "ptBR") or (loc == "ptPT") then
	scrollText = "Pergaminho";
elseif loc == "ruRU" then
	scrollText = "Свиток";
elseif loc == "koKR" then
	scrollText = "두루마리";
elseif loc == "zhCN" then
	scrollText = "卷轴";
elseif loc == "zhTW" then
	scrollText = "卷軸";
end

local f = CreateFrame("Button", "TradeSkillCreateScrollButton", TradeSkillFrame, "MagicButtonTemplate");
f:SetPoint("TOPRIGHT", TradeSkillFrame.DetailsFrame.CreateButton, "TOPLEFT");
f:SetScript("OnClick", function()
    C_TradeSkillUI.CraftRecipe(TradeSkillFrame.DetailsFrame.selectedRecipeID);
	UseItemByName(38682);
end);
f:Hide();

local function OCES_OnRecipeButtonClicked(recipeButton, recipeInfo, mouseButton)
	if C_TradeSkillUI.IsTradeSkillGuild() or C_TradeSkillUI.IsNPCCrafting() or C_TradeSkillUI.IsTradeSkillLinked() then
		f:Hide();
	elseif recipeInfo.tradeSkillInfo.alternateVerb then
        local _, tradeSkillName = C_TradeSkillUI.GetTradeSkillLine();
        if tradeSkillName == enchantingTradeSkillName then
            f:Show();
            local numCreateable = recipeInfo.tradeSkillInfo.numAvailable;
            local numScrollsAvailable = GetItemCount(38682);
            TradeSkillCreateScrollButton:SetText(scrollText.." ("..numScrollsAvailable..")");
            if numScrollsAvailable == 0 then
                numCreateable = 0;
            end
            if numCreateable > 0 then
                TradeSkillCreateScrollButton:Enable();
            else
                TradeSkillCreateScrollButton:Disable();
            end
        else
            f:Hide();
        end
	else
		f:Hide();
	end
end

hooksecurefunc(TradeSkillFrame.RecipeList, "OnRecipeButtonClicked", OCES_OnRecipeButtonClicked);
