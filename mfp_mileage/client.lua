	local CurrentVehicle = nil
	local PlayerIsDriver = false

	Citizen.CreateThread(function()
	    while true do
	        Citizen.Wait(240)
 	       local playerPed = PlayerPedId()
 	       local isInVehicle = IsPedInAnyVehicle(playerPed)

	        if PlayerIsDriver and not isInVehicle then
 	           PlayerIsDriver = false
 	           CurrentVehicle = nil
	        elseif not PlayerIsDriver and isInVehicle then
	           CurrentVehicle = GetVehiclePedIsIn(playerPed, false)
 	           local VehicleDriver = GetPedInVehicleSeat(CurrentVehicle, -1)
            
	            if VehicleDriver == playerPed and not NotSaveForVehicleClasses[GetVehicleClass(CurrentVehicle)] then
	                PlayerIsDriver = true
	            end
	        end
	    end
	end)
	NotSaveForVehicleClasses = {
		 [13] = "Bicycles"
		,[14] = "Boats"
		,[15] = "Helicopters"
		,[16] = "Planes"
		,[17] = "Service"
		,[21] = "Trains"
	}

	Citizen.CreateThread(function()
	    local saveInterval = math.max(1, 1000)
    
	    while true do
 	       Citizen.Wait(50)
			
 	       if PlayerIsDriver and CurrentVehicle then
 	           local playerPed = PlayerPedId()
 	           local lastPosition = GetEntityCoords(playerPed)
 	           Citizen.Wait(saveInterval)
 	           local currentPosition = GetEntityCoords(playerPed)
			
 	           if IsVehicleOnAllWheels(CurrentVehicle) then
 	               local distance = #(currentPosition - lastPosition)
				
	                if distance > 0 then
						if not Config.useGetOnly then
 	                   		TriggerServerEvent('helpscript:mfp_mileage:update', GetVehicleNumberPlateText(CurrentVehicle), distance / 1000)
						end
 	               end
 	           end
 	       end
 	   end
	end)
