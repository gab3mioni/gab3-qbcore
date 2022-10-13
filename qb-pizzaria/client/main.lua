isLoggedIn = true
PlayerJob = {}

local onDuty = false
local QBCore = exports['qb-core']:GetCoreObject()

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end


RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        PlayerJob = PlayerData.job
        if PlayerData.job.onduty then
            if PlayerData.job.name == "pizzaria" then
                TriggerServerEvent("QBCore:ToggleDuty")
            end
        end
    end)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    onDuty = PlayerJob.onduty
end)

RegisterNetEvent('QBCore:Client:SetDuty')
AddEventHandler('QBCore:Client:SetDuty', function(duty)
    onDuty = duty
end)

Citizen.CreateThread(function()
    pizzaria = AddBlipForCoord(288.34, -969.61, 29.43)
    SetBlipSprite (pizzaria, 77)
    SetBlipDisplay(pizzaria, 4)
    SetBlipScale  (pizzaria, 0.5)
    SetBlipAsShortRange(pizzaria, true)
    SetBlipColour(pizzaria, 2)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Luchetti's")
    EndTextCommandSetBlipName(pizzaria)
end) 

-- EVENTOS --

RegisterNetEvent("qb-pizzaria:Mozzarella")
AddEventHandler("qb-pizzaria:Mozzarella", function()
    if onDuty then
        QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
        if HasItem then
        MakeMozzarella()
        else
            QBCore.Functions.Notify("Você não tem os ingredientes suficientes", "error")
        end
    end, 'massapizza' and 'molhotomate' and 'tomate' and 'queijo')
    else
        QBCore.Functions.Notify("Você precisa estar em serviço", "error")
    end   
end)

RegisterNetEvent("qb-pizzaria:Peperoni")
AddEventHandler("qb-pizzaria:Peperoni", function()
    if onDuty then
        QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
        if HasItem then
        MakePeperoni()
        else
            QBCore.Functions.Notify("Você não tem os ingredientes suficientes", "error")
        end
    end, 'massapizza' and 'molhotomate' and 'calabresa' and 'cebolac' and 'queijo')
    else
        QBCore.Functions.Notify("Você precisa estar em serviço", "error")
    end   
end)

RegisterNetEvent("qb-pizzaria:Broccoli")
AddEventHandler("qb-pizzaria:Broccoli", function()
    if onDuty then
        QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
        if HasItem then
        MakeBroccoli()
        else
            QBCore.Functions.Notify("Você não tem os ingredientes suficientes", "error")
        end
    end, 'massapizza' and 'molhotomate' and 'queijo' and 'brocolis')
    else
        QBCore.Functions.Notify("Você precisa estar em serviço", "error")
    end   
end)

RegisterNetEvent("qb-pizzaria:Massa")
AddEventHandler("qb-pizzaria:Massa", function()
    if onDuty then
        QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
        if HasItem then
        MakeMassa()
        else
            QBCore.Functions.Notify("Você não tem os ingredientes suficientes", "error")
        end
    end, 'farinhatrigo' and 'oleo' and 'fermento' and 'sal' and 'ovo')
    else
        QBCore.Functions.Notify("Você precisa estar em serviço", "error")
    end   
end)

RegisterNetEvent("qb-pizzaria:Vinho")
AddEventHandler("qb-pizzaria:Vinho", function()
    if onDuty then
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
        if HasItem then
           MakeVinho()
        else
            QBCore.Functions.Notify("Você não tem uma taça vazia..", "error")
        end
      end, 'taca')
    else
        QBCore.Functions.Notify("Você precisa estar em serviço", "error")
    end
end)

RegisterNetEvent("qb-pizzaria:Guarana")
AddEventHandler("qb-pizzaria:Guarana", function()
    if onDuty then
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
        if HasItem then
           MakeGuarana()
        else
            QBCore.Functions.Notify("Você não tem um copo vazio..", "error")
        end
      end, 'copo')
    else
        QBCore.Functions.Notify("Você precisa estar em serviço", "error")
    end
end)

-- ENTRAR/SAIR SERVIÇO --

RegisterNetEvent("qb-pizzaria:DutyB")
AddEventHandler("qb-pizzaria:DutyB", function()
    TriggerServerEvent("QBCore:ToggleDuty")
end)

-- ESTOQUES --

RegisterNetEvent("qb-pizzaria:Tray1")
AddEventHandler("qb-pizzaria:Tray1", function()
    TriggerEvent("inventory:client:SetCurrentStash", "pizzariatray1")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "pizzariatray1", {
        maxweight = 10000,
        slots = 6,
    })
end)

RegisterNetEvent("qb-pizzaria:Tray2")
AddEventHandler("qb-pizzaria:Tray2", function()
    TriggerEvent("inventory:client:SetCurrentStash", "pizzariatray2")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "pizzariatray2", {
        maxweight = 10000,
        slots = 6,
    })
end)

RegisterNetEvent("qb-pizzaria:Storage")
AddEventHandler("qb-pizzaria:Storage", function()
    TriggerEvent("inventory:client:SetCurrentStash", "pizzariaestoque")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "pizzariaestoque", {
        maxweight = 2500000,
        slots = 40,
    })
end)

-- FUNÇÕES --

function MakeMozzarella()

    TriggerServerEvent('QBCore:Server:RemoveItem', "massapizza", 1)
    TriggerServerEvent('QBCore:Server:RemoveItem', "molhotomate", 1)
    TriggerServerEvent('QBCore:Server:RemoveItem', "tomate", 1)
    TriggerServerEvent('QBCore:Server:RemoveItem', "queijo", 1)
    QBCore.Functions.Progressbar("pickup_sla", "Montando Pizza", 20000, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = false,
    }, {
        animDict = "mp_common",
        anim = "givetake1_a",
        flags = 8,        
    }
)
    Citizen.Wait(20000)
    TriggerServerEvent('QBCore:Server:AddItem', "pnapolitana", 1)
    QBCore.Functions.Notify("Você montou uma Mozzarella", "success")
end 

function MakePeperoni()

    TriggerServerEvent('QBCore:Server:RemoveItem', "massapizza", 1)
    TriggerServerEvent('QBCore:Server:RemoveItem', "molhotomate", 1)
    TriggerServerEvent('QBCore:Server:RemoveItem', "calabresa", 1)
    TriggerServerEvent('QBCore:Server:RemoveItem', "cebolac", 1)
    TriggerServerEvent('QBCore:Server:RemoveItem', "queijo", 1)
    QBCore.Functions.Progressbar("pickup_sla", "Montando Pizza", 20000, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = false,
    }, {
        animDict = "mp_common",
        anim = "givetake1_a",
        flags = 8,        
    }
)
    Citizen.Wait(20000)
    TriggerServerEvent('QBCore:Server:AddItem', "pcalabresa", 1)
    QBCore.Functions.Notify("Você montou uma Peperoni", "success")
end

function MakeBroccoli()

    TriggerServerEvent('QBCore:Server:RemoveItem', "massapizza", 1)
    TriggerServerEvent('QBCore:Server:RemoveItem', "molhotomate", 1)
    TriggerServerEvent('QBCore:Server:RemoveItem', "brocolis", 1)
    TriggerServerEvent('QBCore:Server:RemoveItem', "queijo", 1)
    QBCore.Functions.Progressbar("pickup_sla", "Montando Pizza", 20000, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = false,
    }, {
        animDict = "mp_common",
        anim = "givetake1_a",
        flags = 8,        
    }
)
    Citizen.Wait(20000)
    TriggerServerEvent('QBCore:Server:AddItem', "pbrocolis", 1)
    QBCore.Functions.Notify("Você montou uma Broccoli", "success")
end

function MakeMassa()

    TriggerServerEvent('QBCore:Server:RemoveItem', "farinhatrigo", 1)
    TriggerServerEvent('QBCore:Server:RemoveItem', "oleo", 1)
    TriggerServerEvent('QBCore:Server:RemoveItem', "fermento", 1)
    TriggerServerEvent('QBCore:Server:RemoveItem', "sal", 1)
    TriggerServerEvent('QBCore:Server:RemoveItem', "ovo", 1)  
    QBCore.Functions.Progressbar("pickup_sla", "Sovando Massa", 15000, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = false,
    }, {
        animDict = "mp_common",
        anim = "givetake1_a",
        flags = 8,        
    }
)
    Citizen.Wait(15000)
    TriggerServerEvent('QBCore:Server:AddItem', "massapizza", 1)
    QBCore.Functions.Notify("Você sovou com sucesso a massa de pizza.", "success")
end

function MakeGuarana()

    TriggerServerEvent('QBCore:Server:RemoveItem', "copo", 1)
    QBCore.Functions.Progressbar("pickup", "Enchendo o copo..", 10000, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = false,
    })
    Citizen.Wait(10000)
    TriggerServerEvent('QBCore:Server:AddItem', "guarana", 1)
    QBCore.Functions.Notify("Você encheu o copo com Guarana", "success")
    end  


function MakeVinho()

    TriggerServerEvent('QBCore:Server:RemoveItem', "taca", 1)
    QBCore.Functions.Progressbar("pickup", "Enchendo a taça..", 10000, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = false,
    })
    Citizen.Wait(10000)
    TriggerServerEvent('QBCore:Server:AddItem', "tacavinho", 1)
    QBCore.Functions.Notify("Você encheu a taça com vinho tinto", "success")
    end  
   

-- bt target -

Citizen.CreateThread(function()
    

    exports['qb-target']:AddBoxZone("Duty", vector3(291.82, -981.03, 29.43), 1, 1.2, {
        name = "Duty",
        heading = 11,
        debugPoly = false,
        minZ=29.0,
        maxZ=30.0,
    }, {
        options = {
            {  
                event = "qb-pizzaria:DutyB",
                icon = "far fa-clipboard",
                label = "Entrar/Sair de Serviço",
                job = "pizzaria",
            },
        },
        distance = 1.5
    })

    exports['qb-target']:AddBoxZone("burger_tray_1", vector3(289.67, -977.42, 29.43), 1.05, 1.0, {
        name = "burger_tray_1",
        heading = 35.0,
        debugPoly = false,
        minZ=29.0, 
        maxZ=30.0,
    }, {
        options = {
            {
                event = "qb-pizzaria:Tray1",
                icon = "far fa-clipboard",
                label = "Balcão 1",
            },
        },
        distance = 1.5
    })

    exports['qb-target']:AddBoxZone("burger_tray_2", vector3(287.96, -977.0, 29.43), 1.05, 1.0, {
        name="burger_tray_2",
        heading= 35.0,
        debugPoly= false,
        minZ=29.0,
        maxZ=29.6,
    }, {
        options = {
            {
                event = "qb-pizzaria:Tray2",
                icon = "far fa-clipboard",
                label = "Balcão 2",
				-- job = "all",
            },
        },
        distance = 1.5
    })

        exports['qb-target']:AddBoxZone("pizzariadisplay", vector3(292.06, -984.97, 29.43), 4.6, 1.2, {
            name="pizzariadisplay",
            heading=34,
            debugPoly=false,
            minZ=29.0,
            maxZ=29.5,
        }, {
                options = {
                    {
                        event = "qb-pizzaria:Storage",
                        icon = "fas fa-box",
                        label = "Estoque de Produtos",
                        job = "pizzaria",
                    },
                },
                distance = 1.5
            })

        exports['qb-target']:AddBoxZone("pizzaria_register_1", vector3(287.14, -976.38, 29.43), 1.05, 1.0, {
            name="pizzaria_register_1",
            debugPoly=false,
            heading= 35,
            minZ=29.0,
            maxZ=29.6,
        }, {
                options = {
                    {
                        event = "qb-pizzaria:bill",
                        parms = "1",
                        icon = "fas fa-credit-card",
                        label = "Fazer Cobrança",
                        job = "pizzaria",
                    },
                },
                distance = 1.5
            })

        exports['qb-target']:AddBoxZone("pizzaria_register_2", vector3(290.72, -977.20, 29.43), 0.6, 0.5, {
            name="pizzaria_register_2",
            debugPoly=false,
            heading= 35,
            minZ=29.0,
            maxZ=29.6,
            }, {
                    options = {
                        {
                            event = "qb-pizzaria:bill",
                            parms = "2",
                            icon = "fas fa-credit-card",
                            label = "Fazer Cobrança",
                            job = "pizzaria",
                        },
                    },
                    distance = 1.5
                })
                
        exports['qb-target']:AddBoxZone("pizzaria_balcao", vector3(285.91, -983.29, 29.43), 1.05, 1.05, {
            name="pizzaria_balcao",
            debugPoly=false,
            heading= 35,
            minZ= 29.0,
            maxZ= 29.6,
            }, {
                options = {
                    {
                        event = "qb-menu:Estacao",
                        icon = "fas fa-pizza-slice",
                        label = "Abrir Balcão",
                        job = "pizzaria",
                    },
                },
                distance = 1.5
            })

            exports['qb-target']:AddBoxZone("pizzariadrinks2", vector3(284.91, -984.56, 29.43), 1.15, 0.7, {
                name="pizzariadrinks2",
                heading=33,
                debugPoly=false,
                minZ=29.0,
                maxZ=29.6,
                }, {
                    options = {
                        {
                            event = "qb-menu:Bebida",
                            icon = "fas fa-filter",
                            label = "Estação de Bebidas",
                            job = "pizzaria",
                        },
                    },
                    distance = 1.5
                })
        

end)

RegisterNetEvent("qb-menu:Estacao")
    AddEventHandler("qb-menu:Estacao", function(data)
        AddEventHandler(exports['qb-menu']:openMenu {
        {
            id = 0,
            header = "➜ Montar Pizzas",
            txt = "",
            params = {
                event = "qb-menu:Pizzas"
            }
        },
        {
            id = 1,
            header = "➜ Sovar Massa",
            txt = "Precisa de Farinha de Trigo, Óleo de Girassol, Fermento, Sal e Ovos",
            params = {
                event = "qb-pizzaria:Massa"
            }
        },
        {
            id = 2,
            header = "Fechar (ESC)",
            txt = "",
        },
    })
end)

RegisterNetEvent("qb-menu:Pizzas")
    AddEventHandler("qb-menu:Pizzas", function(data)
        AddEventHandler(exports['qb-menu']:openMenu {    
        {
            id = 0,
            header = "➜ Montar Produtos",
            txt = "",
        },
        {
            id = 1,
            header = "• Mozzarella",
            txt = "Queijo Mozzarella & Fatias de Tomate",
            params = {
                event = "qb-pizzaria:Mozzarella"
            }
        },
        {
            id = 2,
            header = "• Peperoni",
            txt = "Queijo Mozzarella, Fatias de Calabresa Frita & Rodelas de Cebola Caramelizada",
            params = {
                event = "qb-pizzaria:Peperoni"
            }
        },
        {
            id = 3,
            header = "• Broccoli",
            txt = "Queijo Mozzarella, Brócolis salteado na manteiga de ervas e queijo catupiry",
            params = {
                event = "qb-pizzaria:Broccoli"
            }
        },
        {
            id = 4,
            header = "Fechar (ESC)",
            txt = "",
        },
    })
end)

RegisterNetEvent('qb-menu:Bebida')
    AddEventHandler('qb-menu:Bebida', function(data) 
    AddEventHandler(exports['qb-menu']:openMenu {
        {
            id = 0,
            header = "➜ Bebidas ",
            txt = "",
        },
        {
            id = 1,
            header = "• Guarana",
            txt = "",
            params = {
                event = "qb-pizzaria:Guarana"
            }
        },
        {
            id = 2,
            header = "• Taça de Vinho",
            txt = "",
            params = {
                event = "qb-pizzaria:Vinho"
            }
        },
        {
            id = 3,
            header = "Fechar (ESC)",
            txt = "",
        },
    })
end)

-- Till Stuff --
RegisterNetEvent("qb-pizzaria:bill")
AddEventHandler("qb-pizzaria:bill", function()
    local bill = exports['qb-input']:ShowInput({
        header = "Criar Pagamento | Luchetti's",
        submitText = "Realizar Cobrança",
        inputs = {
            {
                type = 'number',
                isRequired = true,
                name = 'citizenid',
                --id = 0,
                text = "CID"
            },
            {
                type = 'number',
                isRequired = true,
                name = 'amount',
                --id = 1,
                text = "Valor"
            }
        }
    })
    if bill then
        if not bill.citizenid or not bill.amount  then return end 
        --[[if bill[1].input == nil or bill[2].input == nil then 
            return 
        end--]]
        TriggerServerEvent("qb-pizzaria:bill:player", bill.citizenid, bill.amount)
    end
end)

-- TESTES

RegisterNetEvent('qb-pizzaria:ToggleDuty', function()
    onDuty = not onDuty
    TriggerServerEvent("QBCore:ToggleDuty")
end)

if Config.UseTarget then
    CreateThread(function()
        -- Toggle Duty
        for k, v in pairs(Config.Locations["duty"]) do 
            exports['qb-target']:AddBoxZone("pizzaria_"..k, vector3(291.82, -981.03, 29.43), 1, 1, {
                name = "pizzaria_"..k,
                heading = 11,
                debugPoly = false,
                minZ = v.z - 1,
                maxZ = v.z + 1,
            }, {
                options = {
                    {
                        type = "client",
                        event = "qb-pizzaria:ToggleDuty",
                        icon = "fas fa-sign-in-alt",
                        label = "Entrar/Sair de Serviço",
                        job = "pizzaria",
                    },
                },
                distance = 1.5
            })
        end

    end)

else
    -- Toggle Duty
    local dutyZones = {}
    for k, v in pairs(Config.Locations["duty"]) do
        dutyZones[#dutyZones+1] = BoxZone:Create(
            vector3(291.82, -981.03, 29.43), 1.75, 1, {
            name="box_zone",
            debugPoly = false,
            minZ = v.z - 1,
            maxZ = v.z + 1,
        })
    end

    --[[local dutyCombo = ComboZone:Create(dutyZones, {name = "dutyCombo", debugPoly = false})
    dutyCombo:onPlayerInOut(function(isPointInside)
        if isPointInside then
            inDuty = true
            if not onDuty then
                exports['qb-core']:DrawText('[E] Entrar em serviço','left')
            else
                exports['qb-core']:DrawText('[E] Entrar em serviço','left')
            end
        else
            inDuty = false
            exports['qb-core']:HideText()
        end
    end)--]]

    -- Toggle Duty Thread
    CreateThread(function ()
        Wait(1000)
        while true do
            local sleep = 1000
            if inDuty and PlayerJob.name == "pizzaria" then
                sleep = 5
                if IsControlJustReleased(0, 38) then
                    onDuty = not onDuty
                    TriggerServerEvent("QBCore:ToggleDuty")
                end
            else
                sleep = 1000
            end
            Wait(sleep)
        end
    end)
end


