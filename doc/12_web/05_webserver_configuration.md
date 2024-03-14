# WebServer Configuration
You can run Loza in Apache or other webservers.

For running Loza in the Traditional webservers, You only need to write a `.htaccess` file with the following contents:

```htaccess
AddHandler cgi-script .loza .loza.html .pit
Options +ExecCGI
DirectoryIndex .loza
```

And then, add the Shebang for your Loza scripts (`.loza`, `.loza.html`, `.pit`).
And make them executable using `chmod +x filename.loza` (If you are on UNIX systems).

