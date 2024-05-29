local QBCore = exports['qb-core']:GetCoreObject()
local hasOpenPlayerList = false
local showPlayerNames = false
local playerNamesCache = {}

-- Function to show the player list
function ShowPlayerList()
  QBCore.Functions.TriggerCallback('bms:playerlist:getPlayerData', function(rdata)
    if rdata.success then
      local playerData = rdata.playerList
      local staff = rdata.isStaff
      local servertime = rdata.date
      local sortedList = {}

      if staff then
        local iter = 0
        local tkeys = {}

        -- Populate the table that holds the keys
        for k in pairs(playerData) do
          iter = iter + 1
          tkeys[iter] = k
        end

        -- Sort the keys
        table.sort(tkeys)
        iter = 0

        -- Use the keys to retrieve the values in the sorted order
        for _, k in ipairs(tkeys) do
          iter = iter + 1
          sortedList[iter] = playerData[k]
        end
      end

      -- Cache player names
      playerNamesCache = {}
      for _, player in ipairs(playerData) do
        playerNamesCache[player.id] = player.charname
      end

      if hasOpenPlayerList then
        TriggerEvent('chat:addMessage', {
          color = {243, 62, 62},
          multiline = true,
          args = {"REPORT IDS", "Displaying ids at time " .. servertime}
        })
        showPlayerNames = true

        if staff then
          SendNUIMessage({setPlayerData = true, plist = sortedList, st = staff})
        end
      end
    end
  end)
end

-- Function to hide the player list
function HidePlayerList()
  SendNUIMessage({closeList = true})
  showPlayerNames = false
end

-- Register command to show player list
RegisterCommand("+playerList", function()
  if not hasOpenPlayerList then
    hasOpenPlayerList = true
    ShowPlayerList()
    -- Send a message to the server to log the event
    local playerData = QBCore.Functions.GetPlayerData()
    local playerName = GetPlayerName(PlayerId())
    local playerServerId = GetPlayerServerId(PlayerId())
    local charName = playerData.charinfo.firstname .. ' ' .. playerData.charinfo.lastname
    TriggerServerEvent('requestDateTime', playerName, playerServerId, charName)
  end
end, false)

-- Register command to hide player list
RegisterCommand("-playerList", function()
  hasOpenPlayerList = false
  HidePlayerList()
end, false)

-- Key mapping for showing the player list
RegisterKeyMapping("+playerList", "(player) Show Player IDs", "keyboard", Config.KeyMapping.ShowPlayerList)

-- Function to draw 3D text with background
function DrawText3D(coords, text)
  local onScreen, _x, _y = World3dToScreen2d(coords.x, coords.y, coords.z)
  local px, py, pz = table.unpack(GetGameplayCamCoords())

  SetTextScale(Config.TextScale, Config.TextScale)
  SetTextFont(Config.TextFont)
  SetTextProportional(Config.TextProportional)
  SetTextEntry("STRING")
  SetTextCentre(1)
  AddTextComponentString(text)

  -- Calculate width for the rectangle
  local textWidth = (string.len(text)) / 370

  -- Draw background rectangle first
  DrawRect(_x, _y + 0.0125, 0.015 + textWidth, 0.03, table.unpack(Config.BackgroundColor))

  -- Draw the text over the rectangle
  SetTextColour(table.unpack(Config.TextColor))
  DrawText(_x, _y)
end

-- Thread to display player IDs
CreateThread(function()
  while true do
    Wait(0)
    if showPlayerNames then
      local players = GetActivePlayers()
      for i = 1, #players do
        local player = players[i]
        local ped = GetPlayerPed(player)
        local playerCoords = GetEntityCoords(ped)
        local playerServerId = GetPlayerServerId(player)

        if player == PlayerId() then
          DrawText3D(playerCoords + vector3(0, 0, 1.0), "[" .. playerServerId .. "] (You)")
        else
          DrawText3D(playerCoords + vector3(0, 0, 1.0), "[" .. playerServerId .. "]")
        end
      end
    else
      Wait(1000)
    end
  end
end)
