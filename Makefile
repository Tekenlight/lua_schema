all : lua_xsd_lib.so

lua_xsd_lib.so: lua_xsd_lib.o
	rm -f lua_xsd_lib.so
	cc -o lua_xsd_lib.so -bundle lua_xsd_lib.o -L/opt/local/lib -llua

lua_xsd_lib.o: lua_xsd_lib.c lua_xsd_lib.h
	cc -I. -I/Volumes/NEW_DISK/user/sudheerp/usr/local/include  -I${HOME}/libxml2/include -c -fpic lua_xsd_lib.c

clean:
	rm -f lua_xsd_lib.o lua_xsd_lib.so

