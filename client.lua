local ox_target = exports.ox_target

-- Create donation box zones on resource start
CreateThread(function()
    Wait(1000)
    
    for i, box in ipairs(Config.DonationBoxes) do
        createDonationZone(box)
    end
end)

function createDonationZone(box)
    ox_target:addBoxZone({
        coords = vector3(box.coords.x, box.coords.y, box.coords.z),
        size = Config.TargetSize,
        rotation = box.coords.w,
        debug = false, -- Set to true to see the zone
        options = {
            {
                name = box.name,
                label = box.label,
                icon = 'fas fa-box-open',
                distance = Config.TargetDistance,
                onSelect = function()
                    openDonationMenu(box)
                end
            }
        }
    })
end

function openDonationMenu(box)
    lib.registerContext({
        id = 'donation_menu',
        title = box.label,
        options = {
            {
                title = 'Donate Items',
                description = 'Add food and water to help others',
                icon = 'hand-holding-heart',
                iconColor = '#32a852',
                onSelect = function()
                    TriggerServerEvent('donationbox:server:openStash', box.name)
                    lib.notify({
                        title = 'Donation Box',
                        description = 'Thank you for your generosity!',
                        type = 'success',
                        duration = 3000
                    })
                end
            },
            {
                title = 'Take Items',
                description = 'Take items if you need them',
                icon = 'hand-holding',
                iconColor = '#4287f5',
                onSelect = function()
                    TriggerServerEvent('donationbox:server:openStash', box.name)
                end
            }
        }
    })
    lib.showContext('donation_menu')
end