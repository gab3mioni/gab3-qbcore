local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent("qb-burgershot:bill:player")
AddEventHandler("qb-burgershot:bill:player", function(playerId, amount)
        local biller = QBCore.Functions.GetPlayer(source)
        local billed = QBCore.Functions.GetPlayer(tonumber(playerId))
        local amount = tonumber(amount)
        if biller.PlayerData.job.name == 'burgershot' then
            if billed ~= nil then
                if biller.PlayerData.citizenid ~= billed.PlayerData.citizenid then
                    if amount > 0 then
                        exports['oxmysql']:execute('INSERT INTO phone_invoices (citizenid, amount, society, sender) VALUES (@citizenid, @amount, @society, @sender)', {
                            ['@citizenid'] = billed.PlayerData.citizenid,
                            ['@amount'] = amount,
                            ['@society'] = biller.PlayerData.job.name,
                            ['@sender'] = biller.PlayerData.charinfo.firstname
                        })
                        TriggerClientEvent('qb-phone:RefreshPhone', billed.PlayerData.source)
                        TriggerClientEvent('QBCore:Notify', source, 'Fatura Enviada com Sucesso', 'success')
                        TriggerClientEvent('QBCore:Notify', billed.PlayerData.source, 'Nova Fatura Recebida')
                    else
                        TriggerClientEvent('QBCore:Notify', source, 'O valor deve ser maior do que 0', 'error')
                    end
                else
                    TriggerClientEvent('QBCore:Notify', source, 'Você não consegue realizar uma cobrança para você mesmo', 'error')
                end
            else
                TriggerClientEvent('QBCore:Notify', source, 'Jogador não está presente', 'error')
            end
        else
            TriggerClientEvent('QBCore:Notify', source, 'Sem acesso', 'error')
        end
end)

QBCore.Functions.CreateCallback('qb-burgershot:server:get:ingredientBurger', function(source, cb)
    local src = source
    local Ply = QBCore.Functions.GetPlayer(src)
    local cheese = Ply.Functions.GetItemByName("queijo")
    local meat = Ply.Functions.GetItemByName("hcarne")
    local bun = Ply.Functions.GetItemByName("pao")
    if cheese ~= nil and meat ~= nil and bun ~= nil then
        cb(true)
    else
        cb(false)
    end
end)


QBCore.Functions.CreateCallback('qb-burgershot:server:get:ingredientBaconBurger', function(source, cb)
    local src = source
    local Ply = QBCore.Functions.GetPlayer(src)
    local meat = Ply.Functions.GetItemByName("hcarne")
    local bun = Ply.Functions.GetItemByName("pao")
    local cheese = Ply.Functions.GetItemByName("queijo")
    local bacon = Ply.Functions.GetItemByName("bacon")
    if meat ~= nil and bun ~= nil and cheese ~= nil and bacon ~= nil then
        cb(true)
    else
        cb(false)
    end
end)


QBCore.Functions.CreateCallback('qb-burgershot:server:get:ingredientChickenBurger', function(source, cb)
    local src = source
    local Ply = QBCore.Functions.GetPlayer(src)
    local bun = Ply.Functions.GetItemByName("pao")
    local tomato = Ply.Functions.GetItemByName("tomate")
    local lettuce = Ply.Functions.GetItemByName("alface")
    local chicken = Ply.Functions.GetItemByName("hfrango")
    local cheese = Ply.Functions.GetItemByName("queijo")
    if bun ~= nil and lettuce ~= nil and tomato ~= nil and chicken ~= nil and cheese ~= nil then
        cb(true)
    else
        cb(false)
    end
end)


QBCore.Functions.CreateCallback('qb-burgershot:server:get:ingredientVeganBurger', function(source, cb)
    local src = source
    local Ply = QBCore.Functions.GetPlayer(src)
    local bun = Ply.Functions.GetItemByName("pao")
    local tomato = Ply.Functions.GetItemByName("tomate")
    local lettuce = Ply.Functions.GetItemByName("alface")
    local vegan = Ply.Functions.GetItemByName("hvegan")
    if bun ~= nil and lettuce ~= nil and tomato ~= nil and vegan ~= nil then
        cb(true)
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback('qb-burgershot:server:get:ingredientFrenchFries', function(source, cb)
    local src = source
    local Ply = QBCore.Functions.GetPlayer(src)
    local potato = Ply.Functions.GetItemByName("frenchfries")
    local box = Ply.Functions.GetItemByName("caixavazia")

    if box ~= nil and potato ~= nil then
        cb(true)
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback('qb-burgershot:server:get:ingredientNuggets', function(source, cb)
    local src = source
    local Ply = QBCore.Functions.GetPlayer(src)
    local nuggets = Ply.Functions.GetItemByName("nuggets")
    local box = Ply.Functions.GetItemByName("caixavazia")

    if box ~= nil and nuggets ~= nil then
        cb(true)
    else
        cb(false)
    end
end)