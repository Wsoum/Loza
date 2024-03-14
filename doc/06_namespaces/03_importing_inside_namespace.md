# importing inside namespaces
you can import an script inside an namespace.

for example, we have `foo.loza` and `bar.loza` scripts.

#### `foo.loza`:

```bash
namespace foo
    func hello
        println('hello world')
    endfunc
endns

func bye
    println('good bye')
endfunc
```

#### `bar.loza`:

```bash
import('foo.loza')

namespace App
    import('foo.loza')
endns

foo.hello() # output: hello world
bye() # output: good bye

App.foo.hello() # output: hello world
App.bye() # output: good bye
```

in above example, we imported `foo.loza` inside an namespace and content of `foo.loza` is loaded under that namespace. for example, `foo.hello` function is loaded under `App` namespace, so finally will be set as `App.foo.hello`.
