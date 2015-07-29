
local _M = {}
local loaded = require"package".loaded

--if getmetatable(_G) == nil then
	local lock = {}
	local lock_mt = {__newindex=function() end, __tostring=function() return "locked" end, __metatable=assert(lock)}
	setmetatable(lock, lock_mt)
	assert(tostring(lock == "locked"))
	
	local ro_mt = getmetatable(_G)
	or {
		__newindex = function(_g_, name, value)
			if name == "_" then return end
			if loaded[name]==value then
				print("drop global write of '"..tostring(name).."'")
				return -- just drop
			end
			if name:sub(1,2) == "__" then
				print("drop global write of '"..tostring(name).."'")
				return -- drop also
			end
			print(_g_, name, value)
			error("global env is read-only", 2)
		end,
		__metatable=lock,
	}
	setmetatable(_G, ro_mt)
	if getmetatable(_G) ~= lock then
		error("unable to setup global env to read-only", 2)
	end
--end

return {}
