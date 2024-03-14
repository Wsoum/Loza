# Module path system
module path is a system to add loza scripts as modules to loza. for example, you have an directory named `/var/lib/loza_modules` and there is an file named `/var/lib/loza_modules/mymodule.loza`. this file is a loza script. now, how to add that loza script to loza as module?

for example, we want to import that module:

```bash
import '@mymodule'
```

to do this, you have to add directory `/var/lib/loza_modules` to loza path:

```bash
LOZAPATH=/var/lib/loza_modules loza my_program.loza
```

to add an directory to loza path, you have to set that directory to environment variable `LOZAPATH`:

```
LOZAPATH=/path/to/first/dir;/path/to/another/dir;/another/dir2...
```

you can seprate paths with `;`.

next, loza interpreter loads modules from that directories. how? loza loads loza files with `.loza` extension as module. for example, if name of file is `my_module.loza`, you can import that with `import "@my_module"`.

also you can import an directory as module. for example, `/usr/lib/loza_modules` is in the module path. and there is a directory in `/usr/lib/loza_modules/mymodule/`. if you import `import "@mymodule"`, loza uses `/usr/lib/loza_modules/mymodule/__init__.loza` file in that directory as module main file. you can load another scripts of your module in this file.

for example:

#### __init__.loza:

```bash
import $__dir__ + '/core.loza'
import $__dir__ + '/another-file.loza'
# ...
# or whatever you want to do
```

### Default paths
the default module paths in loza are:

- `<home-directory>/.local/lib/loza_modules`
- `/usr/lib/loza_modules` (only in UNIX systems)

### Adding module paths at runtime (sys.path module)
there is an namespace named `sys.path` in the `sys` module, this module is for adding new module paths at the runtime.
with this feature, you can add another directories to your path and load modules from them in your program.

for example:

```bash
import @sys
# or
import @sys.path # only loads sys.path contents

sys.path.add('/home/parsa/my-directory');
```

in above code, directory `/home/parsa/my-directory` will be added to the module path. after this action, you can import modules of that directory.

for example, we have `/home/parsa/my-directory/mylib.loza` module and we can import that:

```bash
import '@sys.path'

sys.path.add('/home/parsa/my-directory');

import '@mylib'

# do whatever you want
```

this system is very helpful, specialy when you want to add your local modules from an directory in your project.

for example, i have an project and there is an directory named `loza_modules` contains local library. i can add this directory to module path in my code start point:

```bash
import $__dir__ + '/loza_modules/'

# now i can import libraries from loza_modules directory
```

also you can get list of module paths:

```bash
import '@sys.path'

$module_paths = sys.path.list()

println($module_paths)
```

output:

```
['/path1', '/path2', '...']
```

### Importing sub directories/files from module path
You can import sub dir/file of a section in your module path.

For example, we added `/some/path` directory to our path.
There is a directory named `/some/path/dir1`.
Also there is a file named `/some/path/dir1/__init__.loza`,
and `/some/path/dir1/other.loza`.

Now, we can import them:

```bash
import @dir1 # imports `/some/path/dir1/__init__.loza`
import @dir1.other # imports `/some/path/dir1/other.loza`
import @dir1.subdir.somefile # imports `/some/path/dir1/subdir/somefile.loza`
```
