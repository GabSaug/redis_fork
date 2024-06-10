# Top level makefile, the real shit is at src/Makefile

default: all

.DEFAULT:
	cd src && $(MAKE) $(EXTRA_CFLAGS) $@

install:
	cd src && $(MAKE) $@

.PHONY: install
