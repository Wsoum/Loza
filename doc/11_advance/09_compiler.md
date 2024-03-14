# The Loza Compiler(Mixer)
This program is a compiler/mixer for loza programming language.

This helps you, to mix lot of scripts in your project to One file.

Maybe your project has lot of files which them importing together. This tool helps you to mix and build them to ONE file.

## Get started
Let's get started:

```bash
$ loza @compiler /path/to/my-program/main.loza out.loza
```

then, you can run `out.loza`:

```bash
$ loza out.loza
```

Let's look at an example. we have 3 files: `app.loza`, `lib.loza`, `core.loza`.

##### `app.loza`:

```bash
println('App: start')

import $__dir__ + '/core.loza'

println('App: end')
```

##### `core.loza`:

```bash
println('Core: start')

import $__dir__ + '/lib.loza'

println('Core: end')
```


##### `lib.loza`:

```bash
println('Lib: hello')
```

When i run `app.loza` normally, output is this:

```
App: start
Core: start
Lib: hello
Core: end
App: end
```

now, i can mix this 3 files to one file:

```bash
$ loza @compiler app.loza out.loza
```

now, when i run generated `out.loza` output is:

```
App: start
Core: start
Lib: hello
Core: end
App: end
```

Excatly even the normal run output.

This helps you to build you project from lot of files to one file(Mix them).
