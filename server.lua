local RSGCore = exports['rsg-core']:GetCoreObject()



RegisterNetEvent('donationbox:server:openStash', function(boxName)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
   
    if not Player then return end
   
    local boxExists = false
    for _, box in ipairs(Config.DonationBoxes) do
        if box.name == boxName then
            boxExists = true
            break
        end
    end
   
    if not boxExists then
        TriggerClientEvent('ox_lib:notify', src, {
            title = 'Error',
            description = 'Invalid donation box',
            type = 'error'
        })
        return
    end
   
    -- Updated to include options table for custom slots/weight
    exports['rsg-inventory']:OpenInventory(src, boxName, {
        maxweight = Config.MaxWeight,
        slots = Config.MaxSlots
    })
end)




