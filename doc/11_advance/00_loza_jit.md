# The Loza Jit Compiler
The **Jit** or **Just in time** compiler, is a system to cache the code and compress that to speed up the interpreter.

this system, compresses the content of scripts and saves them to `__lozaam__` directory. then, when file is ran again, jit system loads compressed content from that cache.

you can see `__lozaam__` directory alongside your scripts. this directory contains cached codes.

Also, make sure to add `__lozaam__` file to your **gitignore**.

To disable the jit, you can use `LOZA_DISABLE_JIT` environment variable with value `1` while running the loza interpreter.
for example:

```bash
$ LOZA_DISABLE_JIT=1 loza somefile.loza
```
