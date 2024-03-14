# `$__ismain__` variable
the `$__ismain__` variable, is a general Boolean variable. this variable is used to check the current file, is the **Main ran file** or not.

for example, we have two files, `my_program.loza` and `lib.loza`. we want to know that in our scripts **Is the current script main directly ran file?**.

when you run in terminal:

```bash
loza my_program.loza
```

the `my_program.loza` file is ran directly.

#### my_program.loza:

```bash
println($__ismain__)

import('lib.loza')
```

the above code, prints value of this variable and also imports `lib.loza` file.

#### lib.loza:

```bash
println($__ismain__)
```

when i run `my_program.loza`, output is this:

```
True
False
```

actually, value of this variable in `my_program.loza` is `True`, but in `lib.loza` is `False`.

now, when i run `loza lib.loza`, output is `True`.

**The `$__ismain__` variable says that the current file is main ran file or not and you can check this**.

for example, if we want to run a code only if our script is directly ran and is not imported from other script:

```bash
if $__ismain__
    # do something
endif
```

### `import_run` and `import_run_once` functions
Now, you undrestand the `$__ismain__` variable, But sometimes you need to run a file with `True` value for `$__ismain__`! This is too easy, you should use `import_run` instead of `import` and `import_run_once` instead of `import_once`.

for example, in `main.loza`:

```bash
println('i am main program')
import $__dir__ + '/other.loza'
import_run $__dir__ + '/other.loza'
```

content of `other.loza`:

```bash
println($__ismain__)
```

output of `main.loza`:

```
False
True
```

Why? because in second import we used `import_run` instead of `import`, so, value of `$__ismain__` is `True`.
