local Paladdon = CreateFrame("Frame")
Paladdon.playername = UnitName("player")
local enabled = 'true';

-- shortcut to activate / unactivate
-- raccourci pour activer / desactiver (important si tu fais du PVP avec l’addon en test...)

SLASH_PAL1 = '/pal';
local function SlashCmd(cmd,self)
	if (cmd == 'enable') then
		enabled = 'true';
		DEFAULT_CHAT_FRAME:AddMessage("Paladdon Enabled",0,1,0);
	elseif (cmd == 'disable') then
		enabled = 'false';
		DEFAULT_CHAT_FRAME:AddMessage("Paladdon Disabled",1,0,0);
	else
		DEFAULT_CHAT_FRAME:AddMessage("Type '/pal enable' to activate “Paladdon” or '/pal disable' to deactivate it.",1,0,0);
	end
end
SlashCmdList["PAL"] = SlashCmd;

-- From Daniele Alessandri’s gist
-- https://gist.github.com/nrk/31175

local function print_r ( t ) 
	local print_r_cache={}
	local function sub_print_r(t,indent)
		if (print_r_cache[tostring(t)]) then
			print(indent.."*"..tostring(t))
		else
			print_r_cache[tostring(t)]=true
			if (type(t)=="table") then
				for pos,val in pairs(t) do
					if (type(val)=="table") then
						print(indent.."["..pos.."] => "..tostring(t).." {")
						sub_print_r(val,indent..string.rep(" ",string.len(pos)+8))
						print(indent..string.rep(" ",string.len(pos)+6).."}")
					else
						print(indent.."["..pos.."] => "..tostring(val))
					end
				end
			else
				print(indent..tostring(t))
			end
		end
	end
	sub_print_r(t,"  ")
end


-- This function get called when specific events get fired
-- Cette fonction est appelée quand certains événements se produisent

Paladdon:SetScript("OnEvent",function(...)
	local args = {...}

	if (enabled == 'true') then
		DEFAULT_CHAT_FRAME:AddMessage("Event",0,1,0);
		-- Uncomment to print all event args
		-- Décommenter pour voir tous les arguments de l’évent
		--print_r(args);
		
		-- only when casted by our player
		-- seulement quand notre joueur caste
		
		if args[3] == "player" then
			if args[5] == 196840 then
				PlaySoundFile("Interface\\Addons\\CWES\\Sounds\\bitcoin-excerpt.wav", "SFX")
				DEFAULT_CHAT_FRAME:AddMessage("Givre!",0.5,0.5,1);
			end
			if args[5] == 51505 then
				DEFAULT_CHAT_FRAME:AddMessage("Lave!",1,0.3,0.3);
			end
			if args[5] == 188389 then
				PlaySoundFile("Interface\\Addons\\CWES\\Sounds\\bitcoin-excerpt.wav", "Master")
				DEFAULT_CHAT_FRAME:AddMessage("Horion feu",1,0.3,0.3);
			end
			
			--Fear^
			print(Paladdon.playername);
			print(args[4]);
			
		end
	end
end)

-- Register to successful speelcast events
-- On s’inscrit aux événements de type «incantation réussie»
Paladdon:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")

DEFAULT_CHAT_FRAME:AddMessage("Paladdon loaded, yeah!",1,0,0)