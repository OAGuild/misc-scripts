import send_signal from require "libs.xdotool"

local This

This =
  CONFIG_PATH: os.getenv"HOME" .. "/.openarena/baseoa/magic.cfg"
  CFG_RELOAD_KEY: "F7"

  exec: (cfg) ->
    fd = io.open This.CONFIG_PATH, "w+"
    fd\write cfg
    fd\write "\n"
    fd\close!
    send_signal {class: "OpenArena", key: This.CFG_RELOAD_KEY}

  hide_console: ->
    send_signal {class: "OpenArena", key:"quoteleft"}

This
