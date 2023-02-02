#include <stdio.h>
#include <dlfcn.h>


int main()
{
	void*  dl = dlopen("lua_schema/libxml2.2.dylib", RTLD_LAZY | RTLD_GLOBAL);
	if (dl == NULL) {
		printf("Error: %s\n", dlerror());
	}
	else {
		printf("Library [ %p] openened\n", dl);
	}
	return 0;
}
