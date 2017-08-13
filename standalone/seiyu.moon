#!/usr/bin/env moon

HOME = os.getenv"HOME"
OA_PATH = HOME.."/app/openarena-0.8.8/openarena.x86_64"

say = (text) ->
  if not text
    return
  print "saying ", text
  espeak_cmd = [[espeak --stdout -s250 -k18 -a50 -v female2 | play -t wav - \
  gain 3
  ]]
  with io.popen espeak_cmd, "w"
    \write text
    \close!

timer = {
  time: os.time!
  reset: => @time = os.time!
  diff: => return os.time! - @time
}

fd = io.popen OA_PATH .. " 2>&1 ", "r"

while true
  input = fd\read!
  if not input
    break
  input = input\gsub("%^.", "")\lower!
  if input\match("guild") and (timer\diff! > 1)
    say input\gsub "guild", ""
    timer\reset!
