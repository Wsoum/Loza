# Module string
This module has some functions for working with strings.

### concat
This function concats two strings.

```bash
import @string

println(string.concat('loza', 'ak')) # loza
```

### remove_last
This function removes last character of a string.

```bash
println(string.remove_last('loza')) # lozaa
```

### remove_first
This function removes first character of a string.

```bash
println(string.remove_first('loza')) # ashmak
```

### add_last
This function adds a string to last of other string.

```bash
println(string.add_last('lozaa', 'k'))
```

### add_first
This function adds a string to first of other string.

```bash
println(string.add_first('ashmak', 'p'))
```

### length
This function returns length of a string.

```bash
println(string.length('loza')) # 7
```

### cut
This function cuts a part of string.

```bash
println(string.cut('loza', 1, 4)) # ash
```

### upcase
This function makes upper case string.

```bash
println(string.upcase('loza')) # LOZA
```

### lowcase
This function makes lower case string.

```bash
println(string.lowcase('LOZA')) # loza
```

### reverse
This function reverses a string.

```bash
println(string.reverse('loza'))
```

### to_str
This function converts any type to string.

```bash
println(string.to_str(100))
println(typeof(string.to_str(100))) # test
```
