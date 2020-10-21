local water = 100
local food = 100

--[[Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        DisplayHelp("Hunger: ~t6~"..math.ceil(food).." ~s~| Thirst: ~pa~"..math.ceil(water), 0.130, 0.943, 0.6, 0.3, true, 255, 255, 255, 255, true, 10000)
    end
end)]]--

function getThirst()
	return water
end

function getHunger()
	return food
end


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsPedRunning(PlayerPedId()) then
            food = food - 2
            water = water - 3
        elseif IsPedWalking(PlayerPedId()) then
            food = food - 0.5
            water = water - 1
        else
    		food = food - 0.5
    		water = water - 0.5
        end
		Citizen.Wait(40000)
		if food < 20 or water < 20 then
			local newhealth = GetAttributeCoreValue(PlayerPedId(), 0) - 15
			Citizen.InvokeNative(0xC6258F41D86676E0, PlayerPedId(), 0, newhealth) 
        end
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if food <= 1 or water <= 1 then
            food = 0
            water = 0
            local pl = Citizen.InvokeNative(0x217E9DC48139933D)
    		local ped = Citizen.InvokeNative(0x275F255ED201B937, pl)
        	Citizen.InvokeNative(0x697157CED63F18D4, PlayerPedId(), 500000, false, true, true)
            food = 40
            water = 40
        end
    end
end)

RegisterNetEvent('srp:drink')
AddEventHandler('srp:drink', function(v)
	water = water + tonumber(v)
	if water < 0 then
		water = 0
	end
	if water > 100 then
		water = 100
	end
end)

RegisterNetEvent('srp:eat')
AddEventHandler('srp:eat', function(v)
	food = food + tonumber(v)
	if food < 0 then
		food = 0
	end
	if food > 100 then
		food = 100
	end
end)

function DisplayHelp( _message, x, y, w, h, enableShadow, col1, col2, col3, a, centre )

	local str = CreateVarString(10, "LITERAL_STRING", _message, Citizen.ResultAsLong())

	SetTextScale(w, h)
	SetTextColor(col1, col2, col3, a)

	--SetTextCentre(centre)

	if enableShadow then
		SetTextDropshadow(1, 0, 0, 0, 255)
	end

	Citizen.InvokeNative(0xADA9255D, 10);

	DisplayText(str, x, y)

end
