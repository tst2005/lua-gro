# GRO - Global Read-Only

A simple way to lock the global environment.
If you write something in global environment an error will be raised.
There is stuff to silencly drop some write request.
Exceptions:
 * if the name of the variable and the value are found in the loaded packages
 * the variable named `_`
 * all variable starting with `__` (like __index, __newindex, ...)

# How to use

Just load it.
```lua
require "gro"
```

## Command line use

```
  $ lua -e 'os=nil' -l os -e 'print(os and "yes" or "no")'
yes

$ lua -e 'os=nil' -l gro -l os -e 'print(os and "yes" or "no")'
drop global write of 'gro'
drop global write of 'os'
no
```

# Compatibility

Tested with Lua/5.1, Lua/5.2 and LuaJIT/5.1.
Should be compatible with any version of Lua.

# License

* MIT
