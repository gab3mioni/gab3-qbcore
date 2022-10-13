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
            if PlayerData.job.name == "burgershot" then
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
    BurgerShot = AddBlipForCoord(-1197.32, -897.655, 13.995)
    SetBlipSprite (BurgerShot, 106)
    SetBlipDisplay(BurgerShot, 4)
    SetBlipScale  (BurgerShot, 0.5)
    SetBlipAsShortRange(BurgerShot, true)
    SetBlipColour(BurgerShot, 75)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("BurgerShot")
    EndTextCommandSetBlipName(BurgerShot)
end) 

RegisterNetEvent("qb-burgershot:CheeseBurger") 
AddEventHandler("qb-burgershot:CheeseBurger", function()
    if onDuty then
    	QBCore.Functions.TriggerCallback('qb-burgershot:server:get:ingredientBurger', function(HasItems)  
    		if HasItems then
				Working = true
				TriggerEvent('inventory:client:busy:status', true)
				QBCore.Functions.Progressbar("pickup_sla", "Montando Hambúrger", 20000, false, true, {
					disableMovement = true,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = false,
				}, {
					animDict = "mp_common",
					anim = "givetake1_a",
					flags = 8,
				}, {}, {}, function() -- Done
					Working = false
					TriggerEvent('inventory:client:busy:status', false)
					TriggerServerEvent('QBCore:Server:RemoveItem', "hcarne", 1)
					TriggerServerEvent('QBCore:Server:RemoveItem', "queijo", 2)
					TriggerServerEvent('QBCore:Server:RemoveItem', "pao", 2)
					TriggerServerEvent('QBCore:Server:AddItem', "cheeseburger", 1)
                    QBCore.Functions.Notify("Você montou um Chesse Burger", "success")
				end, function()
					TriggerEvent('inventory:client:busy:status', false)
					QBCore.Functions.Notify("Cancelado..", "error")
					Working = false
				end)
			else
   				QBCore.Functions.Notify("Você não tem os ingredientes para montar o CheeseBurger", "error")
			end
		end)
	else 
		QBCore.Functions.Notify("Você precisa estar em serviço", "error")
	end
end)

RegisterNetEvent("qb-burgershot:BaconBurger")
AddEventHandler("qb-burgershot:BaconBurger", function()
    if onDuty then
    	QBCore.Functions.TriggerCallback('qb-burgershot:server:get:ingredientBaconBurger', function(HasItems)  
    		if HasItems then
				Working = true
				TriggerEvent('inventory:client:busy:status', true)
				QBCore.Functions.Progressbar("pickup_sla", "Montando Hambúrger..", 20000, false, true, {
					disableMovement = true,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = false,
				}, {
					animDict = "mp_common",
					anim = "givetake1_a",
					flags = 8,
				}, {}, {}, function() -- Done
					Working = false
					TriggerEvent('inventory:client:busy:status', false)
					TriggerServerEvent('QBCore:Server:RemoveItem', "hcarne", 1)
					TriggerServerEvent('QBCore:Server:RemoveItem', "pao", 2)
					TriggerServerEvent('QBCore:Server:RemoveItem', "queijo", 2)
					TriggerServerEvent('QBCore:Server:RemoveItem', "bacon", 2)
					TriggerServerEvent('QBCore:Server:AddItem', "baconburger", 1)
                    QBCore.Functions.Notify("Você montou um Bacon Burger", "success")
				end, function()
					TriggerEvent('inventory:client:busy:status', false)
					QBCore.Functions.Notify("Cancelado..", "error")
					Working = false
				end)
			else
   				QBCore.Functions.Notify("Você não tem ingredientes para montar o BaconBurger", "error")
			end
		end)
	else 
		QBCore.Functions.Notify("Você precisa estar em serviço", "error")
	end
end)

RegisterNetEvent("qb-burgershot:ChickenBurger")
AddEventHandler("qb-burgershot:ChickenBurger", function()
    if onDuty then
    	QBCore.Functions.TriggerCallback('qb-burgershot:server:get:ingredientChickenBurger', function(HasItems)  
    		if HasItems then
				Working = true
				TriggerEvent('inventory:client:busy:status', true)
				QBCore.Functions.Progressbar("pickup_sla", "Montando Hambúrger..", 20000, false, true, {
					disableMovement = true,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = false,
				}, {
					animDict = "mp_common",
					anim = "givetake1_a",
					flags = 8,
				}, {}, {}, function() -- Done
					Working = false
					TriggerEvent('inventory:client:busy:status', false)
					TriggerServerEvent('QBCore:Server:RemoveItem', "pao", 2)
					TriggerServerEvent('QBCore:Server:RemoveItem', "alface", 2)
					TriggerServerEvent('QBCore:Server:RemoveItem', "hfrango", 1)
					TriggerServerEvent('QBCore:Server:RemoveItem', "tomate", 2)
                    TriggerServerEvent('QBCore:Server:RemoveItem', "queijo", 2)
					TriggerServerEvent('QBCore:Server:AddItem', "chickenburger", 1)
                    QBCore.Functions.Notify("Você montou um Chicken Burger", "success")
				end, function()
					TriggerEvent('inventory:client:busy:status', false)
					QBCore.Functions.Notify("Cancelado..", "error")
					Working = false
				end)
			else
   				QBCore.Functions.Notify("Você não tem ingredientes para montar o Chicken Burger", "error")
			end
		end)
	else 
		QBCore.Functions.Notify("Você precisa estar em serviço", "error")
	end
end)


RegisterNetEvent("qb-burgershot:VeganBurger")
AddEventHandler("qb-burgershot:VeganBurger", function()
    if onDuty then
    	QBCore.Functions.TriggerCallback('qb-burgershot:server:get:ingredientVeganBurger', function(HasItems)  
    		if HasItems then
				Working = true
				TriggerEvent('inventory:client:busy:status', true)
				QBCore.Functions.Progressbar("pickup_sla", "Montando Hambúrger..", 20000, false, true, {
					disableMovement = true,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = false,
				}, {
					animDict = "mp_common",
					anim = "givetake1_a",
					flags = 8,
				}, {}, {}, function() -- Done
					Working = false
					TriggerEvent('inventory:client:busy:status', false)
					TriggerServerEvent('QBCore:Server:RemoveItem', "pao", 2)
					TriggerServerEvent('QBCore:Server:RemoveItem', "hvegan", 1)
                    TriggerServerEvent('QBCore:Server:RemoveItem', "alface", 2)
                    TriggerServerEvent('QBCore:Server:RemoveItem', "tomate", 2)
                    TriggerServerEvent('QBCore:Server:AddItem', "veganburger", 1)
                    QBCore.Functions.Notify("Você montou um Vegan Burger", "success")
				end, function()
					TriggerEvent('inventory:client:busy:status', false)
					QBCore.Functions.Notify("Cancelado..", "error")
					Working = false
				end)
			else
   				QBCore.Functions.Notify("Você não tem ingredientes para montar o Vegan Burger", "error")
			end
		end)
	else 
		QBCore.Functions.Notify("Você precisa estar em serviço", "error")
	end  
end)

RegisterNetEvent("qb-burgershot:FrenchFries")
AddEventHandler("qb-burgershot:FrenchFries", function()
    if onDuty then
    	QBCore.Functions.TriggerCallback('qb-burgershot:server:get:ingredientFrenchFries', function(HasItems)  
    		if HasItems then
				Working = true
				TriggerEvent('inventory:client:busy:status', true)
				QBCore.Functions.Progressbar("pickup_sla", "Arrumando Batata Frita..", 15000, false, true, {
					disableMovement = true,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = false,
				}, {
					animDict = "mp_common",
					anim = "givetake1_a",
					flags = 8,
				}, {}, {}, function() -- Done
					Working = false
					TriggerEvent('inventory:client:busy:status', false)
					TriggerServerEvent('QBCore:Server:RemoveItem', "frenchfries", 1)
                    TriggerServerEvent('QBCore:Server:RemoveItem', "caixavazia", 1)
					TriggerServerEvent('QBCore:Server:AddItem', "boxfrenchfries", 1)
                    QBCore.Functions.Notify("Você preparou uma caixa de batata frita", "success")
				end, function()
					TriggerEvent('inventory:client:busy:status', false)
					QBCore.Functions.Notify("Cancelado..", "error")
					Working = false
				end)
			else
   				QBCore.Functions.Notify("Você não possui os ingredientes para montar a caixa de batata frita", "error")
			end
		end)
	else 
		QBCore.Functions.Notify("Você precisa estar em serviço", "error")
	end  
end)

RegisterNetEvent("qb-burgershot:Nuggets")
AddEventHandler("qb-burgershot:Nuggets", function()
    if onDuty then
    	QBCore.Functions.TriggerCallback('qb-burgershot:server:get:ingredientNuggets', function(HasItems)  
    		if HasItems then
				Working = true
				TriggerEvent('inventory:client:busy:status', true)
				QBCore.Functions.Progressbar("pickup_sla", "Arrumando Nuggets na Caixa..", 15000, false, true, {
					disableMovement = true,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = false,
				}, {
					animDict = "mp_common",
					anim = "givetake1_a",
					flags = 8,
				}, {}, {}, function() -- Done
					Working = false
					TriggerEvent('inventory:client:busy:status', false)
					TriggerServerEvent('QBCore:Server:RemoveItem', "nuggets", 6)
                    TriggerServerEvent('QBCore:Server:RemoveItem', "caixavazia", 1)
					TriggerServerEvent('QBCore:Server:AddItem', "boxnuggets", 1)
                    QBCore.Functions.Notify("Você preparou uma caixa de nuggets", "success")
				end, function()
					TriggerEvent('inventory:client:busy:status', false)
					QBCore.Functions.Notify("Cancelado..", "error")
					Working = false
				end)
			else
   				QBCore.Functions.Notify("Você não possui os ingredientes para montar a caixa de nuggets", "error")
			end
		end)
	else 
		QBCore.Functions.Notify("Você precisa estar em serviço", "error")
	end  
end)

RegisterNetEvent("qb-burgershot:SoftDrink")
AddEventHandler("qb-burgershot:SoftDrink", function()
    if onDuty then
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
        if HasItem then
           MakeSoftDrink()
        else
            QBCore.Functions.Notify("Você não tem um copo vazio..", "error")
        end
      end, 'copo')
    else
        QBCore.Functions.Notify("Você precisa estar em serviço", "error")
    end
end)

RegisterNetEvent("qb-burgershot:mShake")
AddEventHandler("qb-burgershot:mShake", function()
    if onDuty then
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
        if HasItem then
           MakeMShake()
        else
            QBCore.Functions.Notify("Você não tem um copo vazio..", "error")
        end
      end, 'copo')
    else
        QBCore.Functions.Notify("Você precisa estar em serviço", "error")
    end
end)

RegisterNetEvent("qb-burgershot:Fries")
AddEventHandler("qb-burgershot:Fries", function()
    if onDuty then
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
        if HasItem then
           MakeFries()
        else
            QBCore.Functions.Notify("Você precisa de ao menos três batatas cortadas..", "error")
        end
      end, 'batatacortada' )
    else
        QBCore.Functions.Notify("Você precisa estar em serviço", "error")
    end
end)      

RegisterNetEvent("qb-burgershot:Nuggets2")
AddEventHandler("qb-burgershot:Nuggets2", function()
    if onDuty then
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
        if HasItem then
            MakeNuggets()
        else
            QBCore.Functions.Notify("Você precisa de um frango cru..", "error")
        end
       end, 'hfrangocru' )
    else
        QBCore.Functions.Notify("Você precisa estar em serviço", "error")
    end
end)


RegisterNetEvent("qb-burgershot:PattyFry")
AddEventHandler("qb-burgershot:PattyFry", function()
    if onDuty then
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
        if HasItem then
           MakePatty()
        else
            QBCore.Functions.Notify("Você não tem nenhum hambúrger cru..", "error")
        end
      end, 'hcarnecru')
    else
        QBCore.Functions.Notify("Você precisa estar em serviço", "error")
    end
end)

RegisterNetEvent("qb-burgershot:ChickenBurger2")
AddEventHandler("qb-burgershot:ChickenBurger2", function()
    if onDuty then
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
        if HasItem then
            ChickenBurger2()
        else
            QBCore.Functions.Notify("Você não tem nenhum hambúrger cru..", "error")
        end
      end, 'hfrangocru')
    else
        QBCore.Functions.Notify("Você precisa estar em serviço", "error")
    end
end)

RegisterNetEvent("qb-burgershot:FishBurger")
AddEventHandler("qb-burgershot:FishBurger", function()
    if onDuty then
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
        if HasItem then
            FishBurger()
        else
            QBCore.Functions.Notify("Você não tem nenhum hambúrger cru..", "error")
        end
      end, 'hpeixecru')
    else
        QBCore.Functions.Notify("Você precisa estar em serviço", "error")
    end
end)

RegisterNetEvent("qb-burgershot:DutyB")
AddEventHandler("qb-burgershot:DutyB", function()
    TriggerServerEvent("QBCore:ToggleDuty")
end)

RegisterNetEvent("qb-burgershot:Tray1")
AddEventHandler("qb-burgershot:Tray1", function()
    TriggerEvent("inventory:client:SetCurrentStash", "burgertray1")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "burgertray1", {
        maxweight = 10000,
        slots = 6,
    })
end)

RegisterNetEvent("qb-burgershot:Tray4")
AddEventHandler("qb-burgershot:Tray4", function()
    TriggerEvent("inventory:client:SetCurrentStash", "burgertray4")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "burgertray4", {
        maxweight = 10000,
        slots = 6,
    })
end)

RegisterNetEvent("qb-burgershot:Tray3")
AddEventHandler("qb-burgershot:Tray3", function()
    TriggerEvent("inventory:client:SetCurrentStash", "burgertray3")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "burgertray3", {
        maxweight = 10000,
        slots = 6,
    })
end)

RegisterNetEvent("qb-burgershot:Storage")
AddEventHandler("qb-burgershot:Storage", function()
    TriggerEvent("inventory:client:SetCurrentStash", "burgerestoque")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "burgerestoque", {
        maxweight = 250000,
        slots = 40,
    })
end)

RegisterNetEvent("qb-burgershot:Storage2")
AddEventHandler("qb-burgershot:Storage2", function()
    TriggerEvent("inventory:client:SetCurrentStash", "burgerestoque2")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "burgerestoque2", {
        maxweight = 250000,
        slots = 40,
    })
end)

RegisterNetEvent("qb-burgershot:Storage3")
AddEventHandler("qb-burgershot:Storage3", function()
    TriggerEvent("inventory:client:SetCurrentStash", "burgerestoque3")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "burgerestoque3", {
        maxweight = 250000,
        slots = 40,
    })
end)

-- Functions --
function MakeFries()
TriggerServerEvent('QBCore:Server:RemoveItem', "batatacortada", 1)
QBCore.Functions.Progressbar("pickup", "Fritando batata..", 10000, false, true, {
    disableMovement = true,
    disableCarMovement = false,
    disableMouse = false,
    disableCombat = false,
},{
    animDict = "amb@prop_human_bbq@male@base",
    anim = "base",
    flags = 8,
    }, {
        model = "prop_cs_fork",
        bone = 28422,
        coords = { x = -0.005, y = 0.00, z = 0.00 },
        rotation = { x = 175.0, y = 160.0, z = 0.0 },
    }
)
Citizen.Wait(4000)
TriggerServerEvent('QBCore:Server:AddItem', "frenchfries", 1)
QBCore.Functions.Notify("Você fritou a batata", "success")
StopAnimTask(PlayerPedId(), "amb@prop_human_bbq@male@base", "base", 1.0)
end

function MakeNuggets()
    TriggerServerEvent('QBCore:Server:RemoveItem', "hfrangocru", 1)
    QBCore.Functions.Progressbar("pickup", "Fritando nuggets..", 10000, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = false,
    },{
        animDict = "amb@prop_human_bbq@male@base",
        anim = "base",
        flags = 8,
        }, {
            model = "prop_cs_fork",
            bone = 28422,
            coords = { x = -0.005, y = 0.00, z = 0.00 },
            rotation = { x = 175.0, y = 160.0, z = 0.0 },
        }
    )
    Citizen.Wait(10000)
    TriggerServerEvent('QBCore:Server:AddItem', "nuggets", 1)
    QBCore.Functions.Notify("Você fritou o nuggets", "success")
    StopAnimTask(PlayerPedId(), "amb@prop_human_bbq@male@base", "base", 1.0)
    end

function MakePatty()
    TriggerServerEvent('QBCore:Server:RemoveItem', "hcarnecru", 1)
    QBCore.Functions.Progressbar("pickup", "Fritando o hambúrger..", 10000, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = false,
    },{
        animDict = "amb@prop_human_bbq@male@base",
        anim = "base",
        flags = 8,
    }, {
        model = "prop_cs_fork",
        bone = 28422,
        coords = { x = -0.005, y = 0.00, z = 0.00 },
        rotation = { x = 175.0, y = 160.0, z = 0.0 },
    }    
)
    Citizen.Wait(4000)
    TriggerServerEvent('QBCore:Server:AddItem', "hcarne", 1)
    QBCore.Functions.Notify("Você fritou o hambúrger", "success")
    StopAnimTask(PlayerPedId(), "amb@prop_human_bbq@male@base", "base", 1.0)
end

function ChickenBurger2()
    TriggerServerEvent('QBCore:Server:RemoveItem', "hfrangocru", 1)
    QBCore.Functions.Progressbar("pickup", "Fritando o hambúrger..", 10000, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = false,
    },{
        animDict = "amb@prop_human_bbq@male@base",
        anim = "base",
        flags = 8,
    }, {
        model = "prop_cs_fork",
        bone = 28422,
        coords = { x = -0.005, y = 0.00, z = 0.00 },
        rotation = { x = 175.0, y = 160.0, z = 0.0 },
    }    
)
    Citizen.Wait(4000)
    TriggerServerEvent('QBCore:Server:AddItem', "hfrango", 1)
    QBCore.Functions.Notify("Você fritou o hambúrger", "success")
    StopAnimTask(PlayerPedId(), "amb@prop_human_bbq@male@base", "base", 1.0)
end

function FishBurger()
    TriggerServerEvent('QBCore:Server:RemoveItem', "hpeixecru", 1)
    QBCore.Functions.Progressbar("pickup", "Fritando o hambúrger..", 10000, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = false,
    },{
        animDict = "amb@prop_human_bbq@male@base",
        anim = "base",
        flags = 8,
    }, {
        model = "prop_cs_fork",
        bone = 28422,
        coords = { x = -0.005, y = 0.00, z = 0.00 },
        rotation = { x = 175.0, y = 160.0, z = 0.0 },
    }    
)
    Citizen.Wait(4000)
    TriggerServerEvent('QBCore:Server:AddItem', "hpeixe", 1)
    QBCore.Functions.Notify("Você fritou o hambúrger", "success")
    StopAnimTask(PlayerPedId(), "amb@prop_human_bbq@male@base", "base", 1.0)
end

function MakeSoftDrink()

    TriggerServerEvent('QBCore:Server:RemoveItem', "copo", 1)
    QBCore.Functions.Progressbar("pickup", "Enchendo o copo..", 6000, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = false,
    })
    Citizen.Wait(4000)
    TriggerServerEvent('QBCore:Server:AddItem', "soda", 1)
    QBCore.Functions.Notify("Você encheu o copo com soda", "success")
    end  


function MakeMShake()

    TriggerServerEvent('QBCore:Server:RemoveItem', "copo", 1)
    TriggerServerEvent('QBCore:Server:RemoveItem', "leite", 1)
    TriggerServerEvent('QBCore:Server:RemoveItem', "chocolatepo", 1)
    QBCore.Functions.Progressbar("pickup", "Enchendo o copo..", 6000, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = false,
    })
    Citizen.Wait(4000)
    TriggerServerEvent('QBCore:Server:AddItem', "milkshake", 1)
    QBCore.Functions.Notify("Você encheu um copo com MilkShake", "success")
    end  
   

-- bt target -

Citizen.CreateThread(function()
    

    exports['qb-target']:AddBoxZone("Duty", vector3(-1196.95, -902.69, 14.0), 1, 1.2, {
        name = "Duty",
        heading = 32,
        debugPoly = false,
        minZ=14.0,
        maxZ=18.0,
    }, {
        options = {
            {  
                event = "qb-burgershot:DutyB",
                icon = "far fa-clipboard",
                label = "Entrar/Sair de Serviço",
                job = "burgershot",
            },
        },
        distance = 1.5
    })

    exports['qb-target']:AddBoxZone("burger_tray_1", vector3(-1195.29, -892.31, 14.0), 1.05, 1.0, {
        name = "burger_tray_1",
        heading = 35.0,
        debugPoly = false,
        minZ=13.8,
        maxZ=14.3,
    }, {
        options = {
            {
                event = "qb-burgershot:Tray1",
                icon = "far fa-clipboard",
                label = "Balcão 1",
            },
        },
        distance = 1.5
    })

    exports['qb-target']:AddBoxZone("burger_tray_2", vector3(-1193.87, -894.38, 14.0), 0.5, 0.7, {
        name="burger_tray_2",
        heading=318,
        debugPoly=false,
        minZ=14.0,
        maxZ=14.4,
    }, {
        options = {
            {
                event = "qb-burgershot:Tray4",
                icon = "far fa-clipboard",
                label = "Balcão 2",
				-- job = "all",
            },
        },
        distance = 1.5
    })
    exports['qb-target']:AddBoxZone("burger_tray_3", vector3(-1193.88, -906.98, 14.0), 1, 1, {
        name="burger_tray_3",
        heading=350,
        debugPoly=false,
        minZ=13.2,
        maxZ=14.2,
    }, {
        options = {
            {
                event = "qb-burgershot:Tray3",
                icon = "far fa-clipboard",
                label = "Balcão 3",
				-- job = "all",
            },
        },
        distance = 3.5
    })


 exports['qb-target']:AddBoxZone("burgershotcooker", vector3(-1200.54, -900.92, 14.0), 1.8, 1.0, {
    name="burgershotcooker",
    heading=34,
    debugPoly=false,
    minZ=13.0,
    maxZ=14.4,
    }, {
        options = {
            {
                event = "qb-menu:SteakHouse",
                icon = "fas fa-hamburger",
                label = "Utilizar Chapa",
                job = "burgershot",
            },
        },
        distance = 1.5
    })

    exports['qb-target']:AddBoxZone("burgershotfryer", vector3(-1202.01, -899.27, 14.0), 2.5, 1.5, {
        name="burgershotfryer",
        heading=35,
        debugPoly=false,
        minZ=13.0,
        maxZ=14.4,
        }, {
            options = {
                {
                    event = "qb-menu:SideDish2",
                    icon = "fas fa-box",
                    label = "Fritar Acompanhamentos",
                    job = "burgershot",
                },
            },
            distance = 1.5
        })


        exports['qb-target']:AddBoxZone("burgershotdrinks", vector3(-1199.54, -895.52, 14.0), 2.2, 0.6, {
            name="burgershotdrinks",
            heading=34,
            debugPoly=false,
            minZ=13.8,
            maxZ=14.8,
            }, {
                options = {
                    {
                        event = "qb-menu:DrinkMenu",
                        icon = "fas fa-filter",
                        label = "Estação de Bebidas",
                        job = "burgershot",
                    },
                },
                distance = 1.5
            })

        exports['qb-target']:AddBoxZone("burgershotdrinks2", vector3(-1189.08, -905.28, 14.0), 1.15, 0.7, {
            name="burgershotdrinks2",
            heading=33,
            debugPoly=false,
            minZ=13.8,
            maxZ=14.8,
            }, {
                options = {
                    {
                        event = "qb-menu:DrinkMenu",
                        icon = "fas fa-filter",
                        label = "Estação de Bebidas",
                        job = "burgershot",
                    },
                },
                distance = 1.5
            })


         exports['qb-target']:AddBoxZone("burgerfridge", vector3(-1203.71, -895.86, 14.0), 1.6, 1, {
            name="burgerfridge",
            heading=35,
            debugPoly=false,
            minZ=13.0,
            maxZ=15.6,
        }, {
                options = {
                    {
                        event = "qb-menu:OrderMenu",
                        icon = "fas fa-laptop",
                        label = "Ver Estoque!",
                        job = "burgershot",
                    },
                },
                distance = 1.5
            })

        exports['qb-target']:AddBoxZone("burgershotdisplay", vector3(-1197.78, -894.45, 14.0), 4.6, 1.2, {
            name="burgershotdisplay",
            heading=34,
            debugPoly=false,
            minZ=13.0,
            maxZ=14.8,
        }, {
                options = {
                    {
                        event = "qb-burgershot:Storage",
                        icon = "fas fa-box",
                        label = "Estoque de Lanches",
                        job = "burgershot",
                    },
                },
                distance = 1.5
            })


        exports['qb-target']:AddBoxZone("craftburger", vector3(-1197.57, -899.41, 14.0), 1.8, 0.7, {
            name="craftburger",
            heading=304,
            debugPoly=false,
            minZ=13.0,
            maxZ=14.4,
        }, {
                options = {
                    {
                        event = "qb-menu:Balcao",
                        icon = "fas fa-cheeseburger",
                        label = "Abrir Balcão",
                        job = "burgershot",
                    },
                },
                distance = 1.5
            })


        exports['qb-target']:AddBoxZone("BurgerShot_register_1", vector3(-1196.01, -891.34, 14.0), 0.5, 0.4, {
            name="BurgerShot_register_1",
            debugPoly=false,
            heading=125,
            minZ=14.0,
            maxZ=14.5,
        }, {
                options = {
                    {
                        event = "qb-burgershot:bill",
                        parms = "1",
                        icon = "fas fa-credit-card",
                        label = "Fazer Cobrança",
                        job = "burgershot",
                    },
                },
                distance = 1.5
            })

        exports['qb-target']:AddBoxZone("BurgerShot_register_2", vector3(-1194.65, -893.3, 14.0), 0.6, 0.5, {
            name="BurgerShot_register_2",
            debugPoly=false,
            heading=302,
            minZ=14.1,
            maxZ=14.5,
            }, {
                    options = {
                        {
                            event = "qb-burgershot:bill",
                            parms = "2",
                            icon = "fas fa-credit-card",
                            label = "Fazer Cobrança",
                            job = "burgershot",
                        },
                    },
                    distance = 1.5
                })  


        exports['qb-target']:AddBoxZone("BurgerShot_register_3", vector3(-1193.39, -895.22, 14.0), 0.6, 0.4, {
            name="BurgerShot_register_3",
            debugPoly=false,
            heading=125,
            minZ=14.0,
            maxZ=14.4,
                    }, {
                            options = {
                                {
                                    event = "qb-burgershot:bill",
                                    parms = "3",
                                    icon = "fas fa-credit-card",
                                    label = "Fazer Cobrança",
                                    job = "burgershot",
                                },
                            },
                            distance = 1.5
             })  


end)
-- NH - Context --

RegisterNetEvent("qb-menu:SteakHouse")
    AddEventHandler("qb-menu:SteakHouse", function(data)
        AddEventHandler(exports['qb-menu']:openMenu {
        {
            id = 0,
            header = "➜ Chapa",
            txt = "",
        },
        {
            id = 1,
            header = "• Fritar Hambúrger de Carne",
            txt = "Opção mais gordurosa de se fritar um hambúrger de carne com bastante gordura..",
            params = {
                event = "qb-burgershot:PattyFry"
            }
        },
        {
            id = 2,
            header = "• Fritar Hambúrger de Frango",
            txt = "Aqueles mais saudáveis comem frango, ou não?",
            params = {
                event = "qb-burgershot:ChickenBurger2"
            }
        },
        {
            id = 3,
            header = "• Fritar Hambúrger de Peixe",
            txt = "Pescado diretamente do piêr de Santa Mônica",
            params = {
                event = "qb-burgershot:FishBurger"
            }    
        },
        {
            id = 4,
            header = "Fechar (ESC)",
            txt = "",
        },
    })
end)

RegisterNetEvent("qb-menu:SideDish2")
    AddEventHandler("qb-menu:SideDish2", function(data)
    AddEventHandler(exports['qb-menu']:openMenu {
        {
            id = 0,
            header = "➜ Fritadeira",
            txt = "",
        },
        {
            id = 1,
            header = "• Fritar Batata Frita",
            txt = "Cuidado com o óleo quente, você pode se machucar..",
            params = {
                event = "qb-burgershot:Fries"
            }
        },
        {
            id = 2,
            header = "• Fritar Nuggets",
            txt = "Iscas de frango empanado e frito, tentação de você não poder comer hein",
            params = {
                event = "qb-burgershot:Nuggets2"
            }
        },
    })
end)

RegisterNetEvent("qb-menu:Balcao")
    AddEventHandler("qb-menu:Balcao", function(data)
        AddEventHandler(exports['qb-menu']:openMenu {
        {
            id = 0,
            header = "➜ Montar Lanches",
            txt = "",
            params = {
                event = "qb-menu:Burgers"
            }
        },
        {
            id = 1,
            header = "➜ Montar Acompanhamentos",
            txt = "",
            params = {
                event = "qb-menu:SideDish"
            }
        },
        {
            id = 2,
            header = "Fechar (ESC)",
            txt = "",
        },
    })
end)

RegisterNetEvent("qb-menu:Burgers")
    AddEventHandler("qb-menu:Burgers", function(data)
        AddEventHandler(exports['qb-menu']:openMenu {    
        {
            id = 0,
            header = "➜ Montar Lanches",
            txt = "",
        },
        {
            id = 1,
            header = "• Cheese Burger",
            txt = "Pão, Hambúrger de Carne e Queijo",
            params = {
                event = "qb-burgershot:CheeseBurger"
            }
        },
        {
            id = 2,
            header = "• Bacon Burger",
            txt = "Pão, Hambúrger de Carne, Bacon e Queijo",
            params = {
                event = "qb-burgershot:BaconBurger"
            }
        },
        {
            id = 3,
            header = "• Chicken Burger",
            txt = "Pão, Hambúrger de Frango , Alface, Tomate, Queijo",
            params = {
                event = "qb-burgershot:ChickenBurger"
            }
        },
        {
            id = 4,
            header = "• Vegan Burger",
            txt = "Pão, Hambúrger Vegano, Alface, Tomate",
            params = {
                event = "qb-burgershot:VeganBurger"
            }
        },
        {
            id = 5,
            header = "Voltar",
            txt = "",
            params = {
                event = "qb-menu:Balcao"
            }
        },
    })
end)

RegisterNetEvent('qb-menu:SideDish')
    AddEventHandler("qb-menu:SideDish", function(data)
    AddEventHandler(exports['qb-menu']:openMenu {
        {
            id = 0,
            header = "➜ Montar Acompanhamentos",
            txt = "",
        },
        {
            id = 1,
            header = "• Batata Frita",
            txt = "Procure um recipiente para colocar a batata frita.",
            params = {
                event = "qb-burgershot:FrenchFries"
            },
        },
        {
            id = 2,
            header = "• Nuggets",
            txt = "Procure um recipiente para colocar os nuggets",
            params = {
                event = "qb-burgershot:Nuggets"
            },
        },
        {
            id = 3,
            header = "Voltar",
            txt = "",
            params = {
                event = "qb-menu:Balcao"
            }
        },
    })
end)        

RegisterNetEvent('qb-menu:OrderMenu')
    AddEventHandler("qb-menu:OrderMenu", function(data)
    AddEventHandler(exports['qb-menu']:openMenu {
        {
            id = 0,
            header = "➜ Geladeira",
            txt = "",
        },
        {
            id = 1,
            header = "• Abrir Geladeira",
            txt = "Vamos ver o que a empresa tem na geladeira",
            params = {
                event = "qb-burgershot:Storage2"
            }
        },
        {
            id = 2,
            header = "• Abrir Estoque",
            txt = "Vamos ver o que a empresa tem no estoque",
            params = {
                event = "qb-burgershot:Storage3"
            }
        },
        {
            id = 3,
            header = "Fechar (ESC)",
            txt = "",
        },
    })
end)

RegisterNetEvent('qb-menu:DrinkMenu')
    AddEventHandler('qb-menu:DrinkMenu', function(data) 
    AddEventHandler(exports['qb-menu']:openMenu {
        {
            id = 0,
            header = "➜ Refrigerantes ",
            txt = "",
        },
        {
            id = 1,
            header = "• Soda",
            txt = "Refrigerante de Limão, necessita de um copo para encher.",
            params = {
                event = "qb-burgershot:SoftDrink"
            }
        },
        {
            id = 2,
            header = "• MilkShake",
            txt = "Misture o leite com chocolate em pó e reserve em um copo.",
            params = {
                event = "qb-burgershot:mShake"
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
RegisterNetEvent("qb-burgershot:bill")
AddEventHandler("qb-burgershot:bill", function()
    local bill = exports['qb-input']:ShowInput({
        header = "Criar Pagamento | BurgerShot",
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
        TriggerServerEvent("qb-burgershot:bill:player", bill.citizenid, bill.amount)
    end
end)



--[[RegisterNetEvent("qb-burgershot:shop")
AddEventHandler("qb-burgershot:shop", function()


    TriggerServerEvent("inventory:server:OpenInventory", "shop", "burgershot", Config.Items)


end)--]]

-- TESTES

RegisterNetEvent('qb-burgershot:ToggleDuty', function()
    onDuty = not onDuty
    TriggerServerEvent("QBCore:ToggleDuty")
end)

if Config.UseTarget then
    CreateThread(function()
        -- Toggle Duty
        for k, v in pairs(Config.Locations["duty"]) do
            exports['qb-target']:AddBoxZone("BurgerShot_"..k, vector3(-1192.27, -897.62, 14.0), 1, 1, {
                name = "BurgerShot_"..k,
                heading = 11,
                debugPoly = false,
                minZ = v.z - 1,
                maxZ = v.z + 1,
            }, {
                options = {
                    {
                        type = "client",
                        event = "qb-burgershot:ToggleDuty",
                        icon = "fas fa-sign-in-alt",
                        label = "Entrar/Sair de Serviço",
                        job = "burgershot",
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
            vector3(-1192.27, -897.62, 14.0), 1.75, 1, {
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
            if inDuty and PlayerJob.name == "burgershot" then
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


