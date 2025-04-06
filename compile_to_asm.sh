# $1: name of the c file to compile to assembly
# $2 output path
# make clean > /dev/null
make distclean > /dev/null
opt="$(echo $3 | sed -e "s/-O0/$(cat /etc/gcc.opt)/g") -fno-inline -Wno-error -finline-limit=2"
if ! gcc -masm=intel -std=gnu11 -Ideps/hdr_histogram/ -Wall -Wextra -Wsign-compare -Wundef -Wno-format-zero-length -Wpointer-arith -Wno-missing-braces -Wno-missing-field-initializers -Wno-missing-attributes -pipe -g3 -fvisibility=hidden -Wimplicit-fallthrough -funroll-loops $opt -S -D_GNU_SOURCE -D_REENTRANT -Iinclude -Ideps/jemalloc/include/jemalloc -Ideps/fpconv -Ideps/hiredis -Ideps/hdr_histogram -Ideps/linenoise -Isrc -Iinclude -I/usr/include/lua5.1 -DJEMALLOC_NO_PRIVATE_NAMESPACE -o "$2" "$1"; then
	echo "error compile to asm"
	exit 1
fi
