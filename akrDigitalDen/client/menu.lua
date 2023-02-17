local ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
end)

CreateThread(function()
    while true do
        local Timer = 500
        local plyPos = GetEntityCoords(PlayerPedId())
        for k,v in pairs(Config.PosShop) do
            local dist = #(plyPos-v)
            if dist <= Config.Marker.DrawInteract then
                Timer = 5
                DrawMarker(Config.Marker.Type, v.x, v.y, v.z-0.99, nil, nil, nil, -90, nil, nil, Config.Marker.Size.x, Config.Marker.Size.y, Config.Marker.Size.z, Config.Marker.Color.R, Config.Marker.Color.G, Config.Marker.Color.B, Config.Marker.Color.H)
                Draw3dText(v.x, v.y, v.z+0.99, "Appuyez sur ~p~E~s~ pour acheter", 0.5)
                if IsControlJustPressed(1,51) then
                    OpenDigitalDen()
                end
            end
        end 
        Wait(Timer)
    end
end)

function OpenDigitalDen()
    local main_digital = RageUI.CreateMenu("Digital Den", "MétaCity | Digital Den")
    local sub_digital = RageUI.CreateSubMenu(main_digital, "Digital Den", "MétaCity | Digital Den")

    main_digital:SetRectangleBanner(Config.ColorMenuR, Config.ColorMenuG, Config.ColorMenuB, Config.ColorMenuA)
    sub_digital:SetRectangleBanner(Config.ColorMenuR, Config.ColorMenuG, Config.ColorMenuB, Config.ColorMenuA)

    RageUI.Visible(main_digital, not RageUI.Visible(main_digital))
    while main_digital do
        Citizen.Wait(0)
        RageUI.IsVisible(main_digital, true, true, true, function()

            RageUI.Separator(" ~c~↓ ~p~Digital Den ~c~↓ ")

            for k,v in pairs(Config.Shops) do
            
                RageUI.ButtonWithStyle(v.itemLabel, nil, {RightLabel = v.price.." ~g~$"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        ItemLabelSelected = v.itemLabel
                        ItemNameSelected = v.itemName
                        PriceSelected = v.price
                    end
                end, sub_digital)

            end

        end)

        RageUI.IsVisible(sub_digital, true, true, true, function()

            RageUI.Separator(" ~c~-> ~s~Nom : ~p~"..ItemLabelSelected)

            RageUI.Separator(" ~c~-> ~s~Prix : "..PriceSelected.." ~g~$")


            RageUI.ButtonWithStyle("Paiement par ~g~Espèce~s~", nil, {RightLabel = "~c~>"}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent("akrDigital:Buy", ItemNameSelected, ItemLabelSelected, PriceSelected, 2)
                end
            end)

            RageUI.ButtonWithStyle("Paiement par ~b~Carte~s~", nil, {RightLabel = "~c~>"}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent("akrDigital:Buy", ItemNameSelected, ItemLabelSelected, PriceSelected, 1)
                end
            end)
        end)
        if not RageUI.Visible(main_digital) and not RageUI.Visible(sub_digital) then
            main_digital = RMenu:DeleteType("main_digital", true)
        end
    end
end