#include <stdlib.h>
#include <stdio.h>
#include <dlfcn.h>

int main() {
	void *handle;
	char* (*libversion)();
	char *error;
	
	printf("Attempting to load %s...\n", LIBNAME);
	handle = dlopen(LIBNAME, 1);
	if (!handle) {
		printf("ERROR: failed to load %s: %s\n", LIBNAME, dlerror());
		exit(1);
	}

	libversion = dlsym(handle, "Pa_GetVersionText");
	if ((error = dlerror()) != NULL)  {
		printf("ERROR: failed to load symbol 'Pa_GetVersionText' from %s: %s\n", LIBNAME, dlerror());
		exit(1);
	}
	
	printf("Loaded %s\n", (*libversion)());
	
	dlsym(handle, "Pa_RefreshDeviceList");
	if ((error = dlerror()) != NULL)  {
		printf("ERROR: failed to load symbol 'Pa_RefreshDeviceList' from %s: %s\n", LIBNAME, dlerror());
		exit(1);
	} else {
		printf("Symbol 'Pa_RefreshDeviceList' is present\n");
	}
	
	dlsym(handle, "Pa_SetDevicesChangedCallback");
	if ((error = dlerror()) != NULL)  {
		printf("ERROR: failed to load symbol 'Pa_SetDevicesChangedCallback' from %s: %s\n", LIBNAME, dlerror());
		exit(1);
	} else {
		printf("Symbol 'Pa_SetDevicesChangedCallback' is present\n");
	}
		
	dlclose(handle);
	
	return 0;
}