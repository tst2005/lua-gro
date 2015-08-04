# GRO - Global Read-Only

A simple way to lock the global environment.
When something try to write in global environment, an error is raised.
There is some stuff to silencly drop some write request without error.
Exceptions:
 * if the `name` of the variable AND the `value` are found in the loaded packages
 * allow one time to write the variable `arg` : done by the interpretor when you launch script with command line arguments.
 * the variable named `_` : Use by me for shell code launcher (see below)

There is not special exception about `_ENV` because in lua 5.2+ the _ENV are managed by the interpretor, the _G was not used/called.


# How to use

Just load it.

In lua module :
```lua
require "gro"
```

In command line :
```
$ lua -l gro
```

## Command line use

Without GRO :
```
  $ lua -e 'os=nil' -l os -e 'print(os and "yes" or "no")'
yes
```

With GRO :
```
$ lua -e 'os=nil' -l gro -l os -e 'print(os and "yes" or "no")'
drop global write of module 'gro'
drop global write of module 'os'
no
```


# Compatibility

Tested with Lua/5.1, Lua/5.2 and LuaJIT/5.1.
Should be compatible with any version of Lua.


# About shell code launcher

Sample :
```
#!/bin/sh
_=[[
	for name in luajit lua5.3 lua-5.3 lua5.2 lua-5.2 lua5.1 lua-5.1 lua; do
		: ${LUA:="$(command -v "$name")"}
	done
	if [ -z "$LUA" ]; then
		echo >&2 "ERROR: lua interpretor not found"
		exit 1
	fi
	LUA_PATH='./?.lua;./?/init.lua;./lib/?.lua;./lib/?/init.lua;;'
	exec "$LUA" "$0" "$@"
	exit $?
]]
_=nil
-- lua code here ...
```


# License

* MIT
