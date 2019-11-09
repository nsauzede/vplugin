#include <stdio.h>
#include <stdlib.h>

#include <dlfcn.h>

typedef int (*plug_t)();

#ifdef WIN32
#define PLUGIN_NAME "plugin/plugin.dll"
#else
#define PLUGIN_NAME "plugin/plugin.so"
#endif

int main() {
	char *fname = PLUGIN_NAME;
	void *h = dlopen(fname, RTLD_NOW);
	printf("C loading plugin\n");
	plug_t initialize = dlsym(h, "plugin__initialize");
	plug_t cleanup = dlsym(h, "plugin__initialize");
	if (!initialize || !cleanup) {
		exit(1);
	}
	printf("initialize plugin\n");
	int res = initialize();
	printf("initialize plugin returned %d\n", res);
	printf("cleanup plugin\n");
	res = cleanup();
	printf("cleanup plugin returned %d\n", res);
	return 0;
}
