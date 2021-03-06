--- Algorithms in Lua.
-- The library demonstrates common data structures and algorithms mostly in Lua.
-- Since Lua is a slow language compared with C/C++, you should not rely on
-- this module for critical tasks.  In addition, the module is still in alpha
-- stage; the API may change without warning.
--
-- The package is built partially as a supplement for other libraries; don't
-- expect full implementations for classic algorithms.
--
-- Lua community is split by two major Lua implementations, official [Lua](https://www.lua.org/)
-- and [LuaJIT](http://luajit.org/). Although LuaJIT is behind official Lua in
-- language features, the former outperforms the latter by about 10x-50x.  Therefore,
-- this library targets LuaJIT.
-- @module algo
local algo = {}
package.loaded["algo"] = algo

algo.version = "0.1.0"

algo.Array = algo.Array or require "algo.Array"
algo.List = algo.List or require "algo.List"
algo.Stack = algo.Stack or require "algo.Stack"
algo.Queue = algo.Queue or require "algo.Queue"
algo.Set = algo.Set or require "algo.Set"
algo.Heap = algo.Heap or require "algo.Heap"
algo.NaiveBSTree = algo.NaiveBSTree or require "algo.NaiveBSTree"
algo.String = algo.String or require "algo.String"
algo.UTF8String = algo.UTF8String or require "algo.UTF8String"
algo.Time = algo.Time or require "algo.Time"
algo.DateTime = algo.DateTime or require "algo.DateTime"
algo.DateTimeDuration = algo.DateTimeDuration or require "algo.DateTimeDuration"

return algo
