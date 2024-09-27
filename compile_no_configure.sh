mkdir -p build/bin
make clean > /dev/null
make distclean > /dev/null
rm build/bin/redis
opt="$(echo $1 | sed -e "s/-O0/$(cat /etc/gcc.opt)/g") -Wno-error -finline-limit=2"
make EXTRA_CFLAGS=" $opt" -j -n &> log_make.txt
if ! make EXTRA_CFLAGS="$opt" -j ; then
	echo "error make"
	exit 1
fi
if ! cp ./src/redis-server build/bin/redis; then
	echo "error copying binary"
	exit 1
fi
