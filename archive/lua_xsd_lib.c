#include <stdio.h>
#include <lua_xsd_lib.h>

static int hello_world(lua_State *L)
{
	printf("Hello LUAXSD\n");
	return 1;
}
















static const luaL_Reg luaxsd_lib[] = {
	{"hello", hello_world},
	{ NULL, NULL }
};

int luaopen_xsd_lib(lua_State *L)
{
	luaL_newlib(L, luaxsd_lib);
	return 1;
}
