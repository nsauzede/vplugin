# vplugin
vplugin is a simple test to load dynamic plugins in V.
A plugin is a dynamic library (.so or .dll) with a C API interface binding.
The principle is to first open the plugin file (dlopen), and
then to get the symbol address (dlsym) of a function, and then to run it.

# Compile and Run

First compile the V plugin to obtain a regular C binding library :
```bash
v -shared plugin.v
```
Note that the same plugin could be produced with another language, compiler
etc..

Then run the V test application :
```bash
v run plugtest.v
```

Created by Nicolas Sauzede : https://github.com/nsauzede/vplugin
