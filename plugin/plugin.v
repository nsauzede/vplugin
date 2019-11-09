module plugin

pub fn initialize() int {
	println('${byteptr(C.__func__)}: hello plugin')
	return 42
}

pub fn cleanup() int {
	println('${byteptr(C.__func__)}: bye plugin')
	return 42
}
