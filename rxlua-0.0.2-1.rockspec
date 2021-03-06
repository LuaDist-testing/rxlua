-- This file was automatically generated for the LuaDist project.

package = "rxlua"
version = "0.0.2-1"

-- LuaDist source
source = {
  tag = "0.0.2-1",
  url = "git://github.com/LuaDist-testing/rxlua.git"
}
-- Original source
-- source = { url = "git://github.com/bjornbytes/RxLua.git", tag = "v0.0.2" }
-- 
-- description =
-- {
--   summary = "Reactive Extensions for Lua",
--   homepage = "https://github.com/bjornbytes/RxLua/tree/master",
--   license = "MIT/X11",
--   maintainer = "tie.372@gmail.com",
--   detailed = [[
-- RxLua gives Lua the power of Observables, which are data structures that represent a stream of values that arrive over time. They're very handy when dealing with events, streams of data, asynchronous requests, and concurrency.
-- ]]
-- }

build =
{
  type = "builtin",
  modules = { rx = "rx.lua", },
  copy_directories = { "doc", "tests" }
}