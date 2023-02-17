ESX = nil 

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('akrDigital:Buy', function(itemName, itemLabel, price, payMethod)
	local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local money = 0
    local pay = nil
    if payMethod == 1 then
        money = xPlayer.getMoney()
        pay = function(price)
            xPlayer.removeMoney(price)
        end
        if money < price then
            TriggerClientEvent('esx:showNotification', xPlayer.source, "~p~Digital Den~s~ : Vous n'avez pas assez d'argent.")
            return
        else 
            if xPlayer.canCarryItem(itemName, 1) then
                pay(price)
                xPlayer.addInventoryItem(itemName, 1)
                TriggerClientEvent('esx:showNotification', xPlayer.source, "~p~Digital Den~s~ : ~g~Vous venez d'acheter un "..itemLabel..".")
            else 
                TriggerClientEvent('esx:showNotification', xPlayer.source, "~p~Digital Den~s~ : ~r~Vous n'avez pas assez de place sur vous.")
            end
        end
    else
        money = xPlayer.getAccount("bank").money
        pay = function(price)
            xPlayer.removeAccountMoney("bank", price)
        end
        if money < price then
            TriggerClientEvent('esx:showNotification', xPlayer.source, "~p~Digital Den~s~ : Vous n'avez pas assez d'argent.")
            return
        else 
            if xPlayer.canCarryItem(itemName, 1) then
                pay(price)
                xPlayer.addInventoryItem(itemName, 1)
                TriggerClientEvent('esx:showNotification', xPlayer.source, "~p~Digital Den~s~ : ~g~Vous venez d'acheter un "..itemLabel..".")
            else 
                TriggerClientEvent('esx:showNotification', xPlayer.source, "~p~Digital Den~s~ : Vous n'avez pas assez d'argent.")
            end
        end
    end
end)