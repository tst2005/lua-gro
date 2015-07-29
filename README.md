# GRO - Global Read-Only

A simple way to lock the global environment.
If you write something in global environment an error will be raised.
There is stuff to silencly drop some write request.
Exceptions:
 * if the name of the variable and the value are found in the loaded packages
 * allow one time to write the variable `arg` : done by the interpretor when we launch script with command line arguments.
 * the variable named `_` : Use by me for shell code launcher (see below)


# How to use

Just load it.
```lua
require "gro"
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
drop global write of 'gro'
drop global write of 'os'
no
```


# Compatibility

Tested with Lua/5.1, Lua/5.2 and LuaJIT/5.1.
Should be compatible with any version of Lua.


# About shell code launcher

...FILLME...


# License

* MIT
