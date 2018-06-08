local Rx = require 'rx'

-- Cheer someone on using functional reactive programming

local observable = Rx.Observable.fromCoroutine(function()
  for i = 2, 8, 2 do
    coroutine.yield(i)
  end

  return 'who do we appreciate'
end)

observable
  :map(function(value) return value .. '!' end)
  :subscribe(print)

repeat
  Rx.scheduler:update()
until Rx.scheduler:isEmpty()
