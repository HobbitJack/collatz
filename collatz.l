%option noyywrap
%option header-file="collatz.l.h"

%%
[[:graph:]]+	{ return 0; }

[ \t\n]	{ /* ignore whitespace */ }
<<EOF>>	{ return -1; }
%%
