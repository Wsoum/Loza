# sys module
this module has some functions to manage loza internal envrinonment.

### sys.path module
this module is for manage module paths. you can add new module paths and load modules from everywhere at runtime with this module.

to know about this module, go to next section [Module path system](#module-path-system).

### `$sys.lozainfo`, access to lozainfo

if you want to access to loza interpreter info, `sys` module has a variable named `lozainfo`:

```bash
import @sys

println($sys.lozainfo)
```

output is something like this:

```
{'version': 'vx.y.z', 'pythoninfo': 'x.y.z (default, Jul x y, a:b:c) [GCC x.y.x]'}
```

this variable is a dictonary.
for example, to access loza version:

```bash
import @sys

println($sys.lozainfo['version'])
```

output:

```
v1.x.y
```

and `$sys.lozainfo['pythoninfo']` shows info of python.

### `$sys.lozaexe`: The loza's interpreter exe filename
This variable contains loza's interpreter filename.

```bash
println($sys.lozaexe)
```
