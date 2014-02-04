LIBNAME = lpeg
LUADIR = /usr/include/lua5.2

COPT = -O2
# COPT = -DLPEG_DEBUG -g

CWARNS = -Wall -Wextra -pedantic \
	-Waggregate-return \
	-Wcast-align \
	-Wcast-qual \
	-Wdisabled-optimization \
	-Wpointer-arith \
	-Wshadow \
	-Wsign-compare \
	-Wundef \
	-Wwrite-strings \
	-Wbad-function-cast \
	-Wdeclaration-after-statement \
	-Wmissing-prototypes \
	-Wnested-externs \
	-Wstrict-prototypes \
# -Wunreachable-code \


CFLAGS = $(CWARNS) $(COPT) -ansi -I$(LUADIR) -fPIC
CC = gcc

FILES = lpvm.o lpcap.o lptree.o lpcode.o lpprint.o

# For Linux
linux:
	make lpeg-labels.so "DLLFLAGS = -shared -fPIC"

# For Mac OS
macosx:
	make lpeg-labels.so "DLLFLAGS = -bundle -undefined dynamic_lookup"

lpeg-labels.so: $(FILES)
	env $(CC) $(DLLFLAGS) $(FILES) -o lpeg-labels.so

$(FILES): makefile

test: test.lua re-labels.lua lpeg-labels.so
	./test.lua

clean:
	rm -f $(FILES) lpeg-labels.so


lpcap.o: lpcap.c lpcap.h lptypes.h
lpcode.o: lpcode.c lptypes.h lpcode.h lptree.h lpvm.h lpcap.h
lpprint.o: lpprint.c lptypes.h lpprint.h lptree.h lpvm.h lpcap.h
lptree.o: lptree.c lptypes.h lpcap.h lpcode.h lptree.h lpvm.h lpprint.h
lpvm.o: lpvm.c lpcap.h lptypes.h lpvm.h lpprint.h lptree.h

