module main

import dl

struct Plugin {
	initialize fn() int
	cleanup fn() int
}

fn main() {
	fname := "plugin/plugin.so"
	println('loading plugin')
	h := dl.open(fname, dl.RTLD_NOW)
//	println('handle=$h')
	plugin := Plugin {
		initialize:dl.sym(h, "plugin__initialize")
		cleanup:dl.sym(h, "plugin__cleanup")
	}
	// this kludge because V can't cast voidptr to high order function yet ?
	initialize := plugin.initialize
	cleanup := plugin.cleanup
//	println('initialize=${int(initialize)} cleanup=${int(cleanup)}')
	if isnil(voidptr(initialize)) || isnil(voidptr(cleanup)) {
		panic('failed to load plugin [$fname]')
	}
	println('plugin initialize')
	mut res := initialize()
	println('plugin initialize returned $res')
	res = cleanup()
	println('plugin cleanup returned $res')
}
