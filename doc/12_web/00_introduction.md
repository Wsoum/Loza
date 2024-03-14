# Web Development with Loza
Loza is a general programming language. means that this language is not for a specific work and you can use it anywhere. But Loza has potential of web development. You can run loza at server to develop website backend.

## Get started
This is a very basic example:

```bash
import @web

web.init()

web.end_headers()

println('Hello world!')
```

Then, you can run this using `@serve` module:

```bash
$ loza @serve 8000
```

Now, you can go into http://localhost:8000/myfile.loza (Write path of your script instead of `myfile.loza`), and you will see `Hello world!` in the browser.

## Headers
The headers in HTTP are important things(You should now about them before reading this guide). In loza, for setting the headers, you should use `web.set_header($name, $value)` function. This function sets the header.

for example:

```bash
import @web

web.init()

web.set_header('Content-type', 'application/json')
web.set_header('Foo', 'Bar')
# ...

# surely call this function to end the headers
web.end_headers()
```

Now, you can go into http://localhost:8000/myfile.loza (Write path of your script instead of `myfile.loza`), and you will see `Hello world!` in the browser!

Remember that to call `web.init()` function in the first of your script. This function initializes the web environment.

## Status code
You can set status code of your HTTP response using `web.status($code)` function:

```bash
import @web

web.init()

web.status(404)

web.end_headers()
```

## Request Method
The HTTP request method is accessible using key `REQUEST_METHOD` in envvars:

```bash
import @web, @os

web.init()
web.end_headers()

if $os.env['REQUEST_METHOD'] == 'POST'
    println('The post')
elif $os.env['REQUEST_METHOD'] == 'GET'
    println('The get')
endif
```

## Using Pit engine
You learned about Loza's Pit engine in the previous parts. You can use this in web:

```html
#!/usr/bin/loza @pit
{
web.init()
web.end_headers()

$name = 'parsa'
}
<h1>Hello {{ $name }}</h1>
```

Save the file with `.loza.html` extension. for example: `hello.loza.html`.

Now, run the server and go to http://localhost:8000/hello.loza.html and you will see `Hello parsa` in `h1` tag.

REMEMBER to put `#!/usr/bin/loza @pit` shebang in the first of your file. This is important(Also do this if your are in windows or non-UNIX like OS).

## Webserver cli options
You can use `loza @serve --help` command to see the help:

```
Usage:   loza @serve <port>
         loza @serve <host> <port>
         loza @serve <host> <port> <directory>
         loza @serve <host> <port> <directory> <main-script: main file is request handler>
Example: loza @serve 8080
         loza @serve 0.0.0.0 8080
         loza @serve 0.0.0.0 8080 path/to/public/html
         loza @serve 0.0.0.0 8080 path/to/public/html path/to/public/html/server.loza
```

## Request handler
When you serve a server in a directory, if request of user is `/some/dir/and/file.loza`, webserver searches for `/some/dir/and/file.loza` in that directory. But sometimes you want to set webserver to send All of requests to a specify file.

You can use the 4th argument for webserver cli:

```bash
$ loza @serve localhost 8080 . ./server.loza
```

Now, all of requests will be send to `server.loza` and youself can handle them by this script. for example, you can handle routing with this feature.
