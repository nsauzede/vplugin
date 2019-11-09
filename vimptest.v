module main

import plugin

fn main() {
	println('plugin initialize')
	mut res := plugin.initialize()
	println('plugin initialize returned $res')
	res = plugin.cleanup()
	println('plugin cleanup returned $res')
}
