
local _M = {}
local loaded = require"package".loaded

--if getmetatable(_G) == nil then
	local lock = {}
	local lock_mt = {__newindex=function() end, __tostring=function() return "locked" end, __metatable=assert(lock)}
	setmetatable(lock, lock_mt)
	assert(tostring(lock == "locked"))

	local allow_arg = true
	local function writeargonce(...)
		if allow_arg then
			allow_arg = false
			rawset(...)
			return true
		end
		return false
	end
	local allow_u = true
	local shellcode
	local function write_u_once(_, name, value)
		if value == nil then
			return true
		end
		if allow_u and type(value) == "string" then
			allow_u = false
			shellcode = value
			return true
		elseif shellcode == value then
			return true
		end
		return false
	end

	local function cutname(name)
		return (#name > 30) and (name:sub(1,20).."... ..."..name:sub(-4,-1)) or name
	end

	local ro_mt = getmetatable(_G) or {}
	ro_mt.__newindex = function(_g_, name, value)
		if name == "_" and write_u_once(_G, name, value) then
			return
		end
		if loaded[name]==value then
			io.stderr:write("drop global write of module '"..tostring(name).."'\n")
			return -- just drop
		end
		if name == "arg" then
			if writeargonce(_G, name, value) then
				--print("arg:", #value, table.concat(value, ", "))
				return
			end
		end
		--print(_g_, name, value)
		error( ("global env is read-only. Write of %q"):format(cutname(name)), 2)
	end
	ro_mt.__metatable=lock

	setmetatable(_G, ro_mt)
	if getmetatable(_G) ~= lock then
		error("unable to setup global env to read-only", 2)
	end
--end

return {}
