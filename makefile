.POSIX:	
.PHONY:	all clean install release source uninstall
.SUFFIXES:

PREFIX 	?= /usr/local

all:	collatz

collatz:	collatz.c collatz.g.c collatz.g.h collatz.l.c collatz.l.h
	c99 -o $@ collatz.c collatz.g.c collatz.l.c

collatz.l.c collatz.l.h:	collatz.l
	lex -D_POSIX_C_SOURCE=200809L -o collatz.l.c collatz.l

collatz.g.c collatz.g.h:	collatz.g
	gengetopt <collatz.g
	sed -E 's/(\\n)?[[:blank:]]+\(default=.*\)//' <collatz.g.c >collatz.g.c.tmp
	mv -f collatz.g.c.tmp collatz.g.c

clean:
	rm -f collatz collatz.g.? collatz.l.? collatz*.tar.gz collatz.1.gz Makefile

source:
	rm -f collatz_source.tar.gz
	tar -cf collatz_source.tar collatz.c collatz.g collatz.l collatz.1 makefile
	gzip collatz_source.tar

release:	collatz
	rm -f collatz.tar.gz
	sed 6,33d makefile | sed '2c .PHONY:	install uninstall'> Makefile
	tar -cf poly.tar poly poly.c poly.g poly.l poly.1 Makefile
	gzip collatz.tar

install:	collatz
	mkdir -p $(PREFIX)/bin/
	install collatz $(PREFIX)/bin/
	gzip -k collatz.1
	mkdir -p $(PREFIX)/share/man/man1/
	install collatz.1.gz $(PREFIX)/share/man/man1/

uninstall:
	rm $(PREFIX)/bin/collatz
	rm $(PREFIX)/share/man/man1/collatz.1.gz 
