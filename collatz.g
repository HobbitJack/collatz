args	"-F collatz -c g.c -H g.h -uTARGET --func-name ggo --show-required --default-optional --no-help --no-version -G"

package "collatz"
version "2.0.0"

description	"Print the length of the Collatz sequence for the specified TARGET.\nIf no TARGETs, read from standard input."

section "Options"
option	"loose-exit-status" l "Exit with 0 even if invalid input encountered"
option	"quiet" q "Don't output the input TARGET"
option	"silent" s "Don't print error messages"
option	"verbose" V "Output all elements of the Collatz sequence for each TARGET, including TARGET; number of iterations is not printed"
section	"Getting help"
option	"help" h "Print this help message and exit"
option	"version" v "Print version information and exit"
text	"\nTry 'man collatz' for more information."

versiontext	"Copyright (C) 2026 Jack Renton Uteg.\nLicense GPLv3+: GNU GPL version 3 or later <https://gnu.org/licenses/gpl.html>.\nThis is free software: you are free to change and redistribute it.\nThere is NO WARRANTY, to the extent permitted by law.\n\nWritten by Jack R. Uteg."
