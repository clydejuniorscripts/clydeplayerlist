# Clyde's Player List

Clyde's Player List is a powerful script for FiveM QBCore servers that lets administrators and players view player IDs in-game and log player information to Discord. It enhances server management and player interactions.

Players and admins can press U to view in-game player IDs, which is useful for reporting DM, VDM, modders, and other rule violations. The script includes a Discord webhook to log who presses U, helping catch fail RP abusers.

Future features will allow players to view in-game names along with IDs, which can be enabled or disabled in the config.


## Features

- Real-time player ID display in-game.
- Discord logging of player information.
- Customizable text and background settings.
- Easy key mapping for quick access.

## Installation

### Step 1: Download and Extract

1. Download the `clydeplayerlist.zip` file.
2. Extract the contents to a folder named `clydeplayerlist`.

### Step 2: Configure the Script

1. Open the `config.lua` file.
2. Enter your Discord Webhook URL in the `Config.DiscordWebhookURL` field.

Config.DiscordWebhookURL = 'https://discord.com/api/webhooks/YOUR_WEBHOOK_URL_HERE'

### Step 3: Add to Your FiveM Server

Move the clydeplayerlist folder to your server's resource directory.

Add the following line to your server.cfg file:

start clydeplayerlist

Step 4: Start Your Server

Start your FiveM server.

Press and hold the "U" key in-game to view player IDs and log information to Discord.

Support and Improvements
If you have any questions, need support, or want to contribute improvements, join our Discord community: https://discord.gg/ZW2fGcPZZY

Credits

Author: clydejuniorscripts
This is a free script and should not be redistributed or sold. Improvements are always welcome.
<a href="https://buymeacoffee.com/clydejuniorscripts" target="_blank"><img src="https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png" alt="Buy Me A Coffee" style="height: 41px !important;width: 174px !important;box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;-webkit-box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;" ></a>

License
This project is licensed under the MIT License. See the LICENSE file for details.

