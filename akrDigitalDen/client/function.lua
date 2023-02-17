Citizen.CreateThread(function()
    for k,v in pairs(Config.Blips.Pos) do
        local blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite(blip, Config.Blips.Sprite)
        SetBlipScale(blip, Config.Blips.Scale)
        SetBlipColour(blip, Config.Blips.Colour)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.Blips.Text)
        EndTextCommandSetBlipName(blip)
    end
end)

function Draw3dText(x, y, z, text, size)
    local onScreen, w, h = World3dToScreen2d(x, y, z)
	local camCoords      = GetGameplayCamCoords()
	local dist           = GetDistanceBetweenCoords(camCoords, x, y, z, true)
	local size           = size

	if size == nil then
		size = 1
	end

	local scale = (size / dist) * 2
	local fov   = (1 / GetGameplayCamFov()) * 100
	local scale = scale * fov

    SetTextScale(0.0 * scale, 0.55 * scale)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry('STRING')
    SetTextCentre(1)

    AddTextComponentString(text)
    DrawText(w, h)
end