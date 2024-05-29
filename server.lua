local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('bms:playerlist:getPlayerData', function(source, cb)
  local xPlayers = QBCore.Functions.GetPlayers()
  local playerList = {}
  local isStaff = false

  for _, playerId in ipairs(xPlayers) do
    local xPlayer = QBCore.Functions.GetPlayer(playerId)
    table.insert(playerList, {
      id = playerId,
      job = xPlayer.PlayerData.job.label,
      grade = xPlayer.PlayerData.job.grade
    })

    -- Check if the player is staff
    if xPlayer.PlayerData.job.name == 'admin' then
      isStaff = true
    end
  end

  cb({
    success = true,
    playerList = playerList,
    isStaff = isStaff,
    date = os.date('%Y-%m-%d %H:%M:%S')
  })
end)

-- Function to send a Discord webhook message
function SendDiscordWebhookMessage(content)
  if Config.DiscordWebhookURL ~= '' then
    PerformHttpRequest(Config.DiscordWebhookURL, function(err, text, headers)
      if err ~= 200 then
        print("Error sending Discord webhook: " .. tostring(err))
      else
        print("Successfully sent Discord webhook message.")
      end
    end, 'POST', json.encode({
      username = 'Player List Logger',
      content = content
    }), { ['Content-Type'] = 'application/json' })
  else
    print("Discord webhook URL is not set.")
  end
end

-- Register an event to handle the webhook message
RegisterNetEvent('sendDiscordWebhookMessage')
AddEventHandler('sendDiscordWebhookMessage', function(playerName, playerServerId, charName)
  local identifiers = GetPlayerIdentifiers(source)
  local discordName, fivemName

  for _, id in ipairs(identifiers) do
    if string.find(id, "discord:") then
      discordName = id
    elseif string.find(id, "fivem:") then
      fivemName = id
    end
  end

  local content = string.format("Player: %s\nServer ID: %s\nCharacter: %s\nTime: %s",
    playerName, playerServerId, charName, os.date('%Y-%m-%d %H:%M:%S'))

  if discordName and discordName ~= "" then
    content = content .. string.format("\nDiscord: %s", discordName)
  end

  if fivemName and fivemName ~= "" then
    content = content .. string.format("\nFiveM: %s", fivemName)
  end

  SendDiscordWebhookMessage(content)
end)

-- Handle request for current date and time
RegisterNetEvent('requestDateTime')
AddEventHandler('requestDateTime', function(playerName, playerServerId, charName)
  local source = source
  TriggerEvent('sendDiscordWebhookMessage', playerName, playerServerId, charName)
end)
