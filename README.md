# GRO - Global Read-Only

A simple way to lock the global environment.
There is stuff to silencly drop some write request.

```
  $ lua -e 'os=nil' -l os -e 'print(os and "yes" or "no")'
yes

$ lua -e 'os=nil' -l gro -l os -e 'print(os and "yes" or "no")'
drop global write of 'gro'
drop global write of 'os'
no
```

# License

* MIT
