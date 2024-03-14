# Importing scripts
you can distribute your code in more than 1 files.

for example, we have 2 files: `app.loza`, `fib.loza`.
`app.loza` is main file. `fib.loza` contains a function to show fibonaccy algo.

#### fib.loza:
```bash
# this function prints fibonacci pattern
func fib
    $a = 1
    $b = 1

    while $a < 10000
        println($a)

        $tmp_a = $a
        $tmp_b = $b

        $a = $tmp_b

        $b = $tmp_a + $tmp_b
    endwhile
endfunc
```

#### app.loza:
```bash
import 'fib.loza'

fib()
```

when we run `import` function and pass a file path to that, content of that file will be included in our code and will be ran. for example, here we used a function from the `fib.loza` file.

also you can import more than 1 scripts in one command:

```bash
# seprate them with `,` (actially a tuple or list)
import('a.loza', '/path/to/b.loza', 'dir/c.loza')
```

### import_once function
there is a command named `import_once`. this is excatly like `import` function, but this function do not repeats for import one script.

for example, we have a file named `foo.loza`:

#### foo.loza:

```bash
$a = 100
```

now, we import this file Two times:

```bash
import('foo.loza')
println($a)
$a = 300
import('foo.loza')
println($a)
```

output:

```
100
100
```

because i imported this script two times and my code sets `$i` two times.

but if i use the `import_once` function:

```bash
import_once('foo.loza')
println($a)
$a = 300
import_once('foo.loza')
println($a)
```

output:

```
100
300
```

because, `import_once` function checks the file, and if files already imported, don't imports again.

### Importing directory
You can import directories, the directory should have `__init__.loza` file.

for example:

```bash
import '/path/to/some/dir' # means import `/path/to/some/dir/__init__.loza`
```

when you import a directory, `__init__.loza` file in that directory will be imported.
