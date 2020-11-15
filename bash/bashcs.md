### parentheses, brackets, curly braces
https://stackoverflow.com/questions/2188199/how-to-use-double-or-single-brackets-parentheses-curly-braces
#### double parentheses
- Double parentheses (( )) are used for arithmetic
- echo $((a + b + (14 * c)))
- C-style variable increment, decrement, tenary operation
- Variables used inside double parentheses do not need to be prefixed with '$'. Spaces are also allowed around operators for readability
#### Brackets
- Square brackets [] are used for test construct (needs space)
- used for array indexing
- regular expression
- Double square brackets [[]]offer extended functionality to single square brackets, useful for the regular expression operator =~, or use of &&, || instead of -a and -o
- There are two formats for arithmetic expansion: $[ expression ] and $(( expression #)) although [] is a non-standard and obsolete version
#### curly braces
- Curly braces {} are used to delimit a variable (unambiguously identify variables)
- use a variable for parameter expansion
- create a list of strings, eg, echo f{oo,ee,a}d //brace expansion; extended brace expansion {a..z}
- Braces are also used to execute a sequence of commands in the current shell context, e.g.
{ date; make 2>&1; date; } | tee logfile
- a semicolon ; after the last command within braces is a must, and the braces {, } must be surrounded by spaces.
#### single parentheses
- used to create a subshell without affecting the environment of the current shell, e.g. (cd /tmp; pwd)
- array initialization
- command/process substitution (?compared to ``)


### Arithmetic Comparisons  
- lt, gt, le, ge, eq, ne
String Comparisons
- =, !=, >, <
- -n not empty
- -s empty

### File Testing
- -e file existence
- -d directory existence

### Redirecting
- 2>&1; 1>&2; &>

### quotes
- Single quotes in bash will suppress special meaning of every meta characters.
- Double quotes in bash will suppress special meaning of every meta characters except "$", "\" and "`".

### Bash quoting with ANSI-C style
echo $'web: www.linuxconfig.org\nemail: web\x40linuxconfigorg'
- must have $ and single quotes 
- \n
- \r
- \b
- \v
- \x40

