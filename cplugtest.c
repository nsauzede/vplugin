#include <stdio.h>
#include <stdlib.h>

#ifdef WIN32
#include <windows.h>
#define dlopen(fname,flags) LoadLibrary(fname)
#define dlsym(handle,symbol) GetProcAddress(handle, symbol)
#else
#include <dlfcn.h>
#endif

typedef int (*plug_t)();

#ifdef WIN32
//#define PLUGIN_NAME "plugin/plugin.dll"
#define PLUGIN_NAME "plugin/plugin.so"
#else
#define PLUGIN_NAME "plugin/plugin.so"
#endif

int main(int argc, char *argv[]) {
	char *fname = PLUGIN_NAME;
	int arg = 1;
	if (arg < argc) {
		fname = argv[arg++];
	}
	printf("C loading plugin [%s]\n", fname);
	void *h = dlopen(fname, RTLD_NOW);
	if (!h) {
		printf("can't open plugin ?\n");
		exit(1);
	}
	plug_t initialize = (plug_t)dlsym(h, "plugin__initialize");
	plug_t cleanup = (plug_t)dlsym(h, "plugin__initialize");
	if (!initialize || !cleanup) {
		printf("bad plugin API ?\n");
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
