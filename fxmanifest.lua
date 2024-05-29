fx_version 'cerulean'
game 'gta5'

author 'clydejuniorscripts'
description "Clyde's Player List"
version '1.0.0'

shared_script 'config.lua'

client_scripts {
  'client.lua'
}

server_scripts {
  'server.lua'
}

ui_page 'html/index.html'

files {
  'html/index.html',
  'html/css/style.css',
  'html/index.js'
}