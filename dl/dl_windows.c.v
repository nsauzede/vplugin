module dl

pub const (
	RTLD_NOW = 0
)

fn C.LoadLibraryA(libfilename byteptr) voidptr
fn C.GetProcAddress(handle voidptr, procname byteptr) voidptr

pub fn open(filename string, flags int) voidptr {
//	println('filename=$filename')
	res := C.LoadLibraryA(filename.str)
//	err := C.GetLastError()
//	println('res=$res err=$err')
	return res
}

pub fn sym(handle voidptr, symbol string) voidptr {
	return C.GetProcAddress(handle, symbol.str)
}
