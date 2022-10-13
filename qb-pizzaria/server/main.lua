local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent("qb-pizzaria:bill:player")
AddEventHandler("qb-pizzaria:bill:player", function(playerId, amount)
        local biller = QBCore.Functions.GetPlayer(source)
        local billed = QBCore.Functions.GetPlayer(tonumber(playerId))
        local amount = tonumber(amount)
        if biller.PlayerData.job.name == 'pizzaria' then
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