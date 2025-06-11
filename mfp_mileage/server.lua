---------------------------------
--		    FRAMEWORK		   --
---------------------------------
if Config.Framework == 'ESX' then
    ESX = exports["es_extended"]:getSharedObject()
elseif Config.Framework == 'QBCORE' then
    QBCore = exports['qb-core']:GetCoreObject()
end

---------------------------------
--			  Script		   --
---------------------------------

function Trim(text)
    return text:gsub("^%s*(.-)%s*$", "%1")
end

local function GetCarMileage(plate, cb)
    plate = plate:upper()
    local trimmedPlate = Trim(plate)
    local query, params

    if Config.Framework == 'ESX' then
        query = "SELECT plate, milage FROM owned_vehicles WHERE (`plate` = @plate OR `plate` = @trimmedPlate)"
    elseif Config.Framework == 'QBCORE' then
        query = "SELECT plate, milage FROM player_vehicles WHERE (`plate` = @plate OR `plate` = @trimmedPlate)"
    end

    params = {["@plate"] = plate, ["@trimmedPlate"] = trimmedPlate}

    MySQL.Async.fetchAll(query, params, function(result)
        if result and #result > 0 then 
            cb(tonumber(result[1].milage) or 0, true)
        else
            cb(0, false)
        end 
    end)
end

RegisterServerEvent('helpscript:mfp_mileage:update')
AddEventHandler('helpscript:mfp_mileage:update', function(plate, mileage)
    plate = plate:upper()
    local trimmedPlate = Trim(plate)
    local query, params

    if Config.Framework == 'ESX' then
        query = "UPDATE owned_vehicles SET `milage` = milage + @milage WHERE (`plate` = @plate OR `plate` = @trimmedPlate)"
    elseif Config.Framework == 'QBCORE' then
        query = "UPDATE player_vehicles SET `milage` = milage + @milage WHERE (`plate` = @plate OR `plate` = @trimmedPlate)"
    end

    params = {["@plate"] = plate, ["@milage"] = tonumber(mileage), ["@trimmedPlate"] = trimmedPlate}
    MySQL.Async.execute(query, params)
end)

-- ESX Callback
if Config.Framework == 'ESX' then
    ESX.RegisterServerCallback('helpscript:mfp_mileage:getcarmileage', function(source, cb, plate)
        GetCarMileage(plate, cb)
    end)
end

-- QB-Core Callback
if Config.Framework == 'QBCORE' then
    QBCore.Functions.CreateCallback('helpscript:mfp_mileage:getcarmileage', function(source, cb, plate)
        GetCarMileage(plate, cb)
    end)
end
