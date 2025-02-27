if not Framework.ESX() then return end

local client = client
local firstSpawn = false

AddEventHandler("esx_skin:resetFirstSpawn", function()
    firstSpawn = true
end)

AddEventHandler("esx_skin:playerRegistered", function()
    if(firstSpawn) then
        InitializeCharacter(Framework.GetGender(true))
    end
end)

RegisterNetEvent("skinchanger:loadSkin2", function(ped, skin)
    if not skin.model then skin.model = "mp_m_freemode_01" end
    client.setPedAppearance(ped, skin)
    Framework.CachePed()
end)

RegisterNetEvent("skinchanger:getSkin", function(cb)
    while not Framework.PlayerData do
        Wait(1000)
    end
    lib.callback("illenium-appearance:server:getAppearance", false, function(appearance)
        cb(appearance)
        Framework.CachePed()
    end)
end)

RegisterNetEvent("skinchanger:loadSkin", function(skin, cb)
    if not skin.hair_1 then
        client.setPlayerAppearance(skin)
        Framework.CachePed()
    end
	if cb ~= nil then
		cb()
	end
end)

RegisterNetEvent("skinchanger:loadClothes", function(_, clothes)
    local playerPed = PlayerPedId()
    local components = Framework.ConvertComponents(clothes, client.getPedComponents(playerPed))
    local props = Framework.ConvertProps(clothes, client.getPedProps(playerPed))

    client.setPedComponents(playerPed, components)
    client.setPedProps(playerPed, props)
end)

RegisterNetEvent("esx_skin:openSaveableMenu", function(onSubmit, onCancel)
    InitializeCharacter(Framework.GetGender(true), onSubmit, onCancel)
end)
