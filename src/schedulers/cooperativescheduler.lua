local util = require 'util'
local Subscription = require 'subscription'

--- @class CooperativeScheduler
-- @description Manages Observables using coroutines and a virtual clock that must be updated
-- manually.
local CooperativeScheduler = {}
CooperativeScheduler.__index = CooperativeScheduler
CooperativeScheduler.__tostring = util.constant('CooperativeScheduler')

--- Creates a new CooperativeScheduler.
-- @arg {number=0} currentTime - A time to start the scheduler at.
-- @returns {Scheduler.CooperativeScheduler}
function CooperativeScheduler.create(currentTime)
  local self = {
    tasks = {},
    currentTime = currentTime or 0
  }

  return setmetatable(self, CooperativeScheduler)
end

--- Schedules a function to be run after an optional delay.
-- @arg {function} action - The function to execute. Will be converted into a coroutine. The
--                          coroutine may yield execution back to the scheduler with an optional
--                          number, which will put it to sleep for a time period.
-- @arg {number=0} delay - Delay execution of the action by a time period.
function CooperativeScheduler:schedule(action, delay)
  local task = {
    thread = coroutine.create(action),
    due = self.currentTime + (delay or 0)
  }

  table.insert(self.tasks, task)

  return Subscription.create(function()
    return self:unschedule(task)
  end)
end

function CooperativeScheduler:unschedule(task)
  for i = 1, #self.tasks do
    if self.tasks[i] == task then
      table.remove(self.tasks, i)
    end
  end
end

--- Triggers an update of the CooperativeScheduler. The clock will be advanced and the scheduler
-- will run any coroutines that are due to be run.
-- @arg {number=0} delta - An amount of time to advance the clock by. It is common to pass in the
--                         time in seconds or milliseconds elapsed since this function was last
--                         called.
function CooperativeScheduler:update(delta)
  self.currentTime = self.currentTime + (delta or 0)

  for i = #self.tasks, 1, -1 do
    local task = self.tasks[i]

    if self.currentTime >= task.due then
      local success, delay = coroutine.resume(task.thread)

      if success then
        task.due = math.max(task.due + (delay or 0), self.currentTime)
      else
        error(delay)
      end

      if coroutine.status(task.thread) == 'dead' then
        table.remove(self.tasks, i)
      end
    end
  end
end

--- Returns whether or not the CooperativeScheduler's queue is empty.
function CooperativeScheduler:isEmpty()
  return not next(self.tasks)
end

return CooperativeScheduler
