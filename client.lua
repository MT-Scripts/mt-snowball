AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        if Config.UseStaticXMASWeather == true then
            TriggerServerEvent('qb-weathersync:server:setWeather', 'XMAS')
        end
    end
end)

function LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

function PickSnowBall()
    if IsNextWeatherType('XMAS') and not IsPedInAnyVehicle(PlayerPedId(), true) and not IsPlayerFreeAiming(PlayerId()) and not IsPedSwimming(PlayerPedId()) and not IsPedSwimmingUnderWater(PlayerPedId()) and not IsPedRagdoll(PlayerPedId()) and not IsPedFalling(PlayerPedId()) and not IsPedRunning(PlayerPedId()) and not IsPedSprinting(PlayerPedId()) and GetInteriorFromEntity(PlayerPedId()) == 0 and not IsPedShooting(PlayerPedId()) and not IsPedUsingAnyScenario(PlayerPedId()) and not IsPedInCover(PlayerPedId(), 0) then
        LoadAnimDict('anim@mp_snowball')
        TaskPlayAnim(PlayerPedId(), 'anim@mp_snowball', 'pickup_snowball', 8.0, -1, -1, 0, 1, 0, 0, 0)
        Wait(2000)
        GiveWeaponToPed(PlayerPedId(), GetHashKey('WEAPON_SNOWBALL'), Config.SnowBallsAmount, false, true)
    end
end

CreateThread(function()
    while true do
        if IsControlJustReleased(0, Config.Key) then
            PickSnowBall()
        end
        Wait(0)
    end
end)