DIAMOND_RPM=files/diamond_3_10-base_x64-111-2-x86_64-linux.rpm

all: build

build: $(DIAMOND_RPM)
	rm -rf build
	mkdir -p build
	rpm2cpio $(DIAMOND_RPM) | cpio -idmv -D build/
	mkdir -p build/opt
	mv build/usr/local/diamond/3.10_x64 build/opt/diamond
	cd build/opt/diamond/bin; tar xzf bin.tar.gz; rm -f bin.tar.gz
	cd build/opt/diamond/cae_library; tar xzf cae_library.tar.gz; rm -f cae_library.tar.gz
	cd build/opt/diamond/data; tar xzf data.tar.gz; rm -f data.tar.gz
	cd build/opt/diamond/embedded_source; tar xzf embedded_source.tar.gz; rm -f embedded_source.tar.gz
	cd build/opt/diamond/examples; tar xzf examples.tar.gz; rm -f examples.tar.gz
	cd build/opt/diamond/ispfpga; tar xzf ispfpga.tar.gz; rm -f ispfpga.tar.gz
	cd build/opt/diamond/synpbase; tar xzf synpbase.tar.gz; rm -f synpbase.tar.gz
	cd build/opt/diamond/tcltk; tar xzf tcltk.tar.gz; rm -f tcltk.tar.gz

install:
	cp -r build/opt ${DESTDIR}/
	mkdir -p ${DESTDIR}/etc/udev/rules.d
	cp files/99-lattice.rules ${DESTDIR}/etc/udev/rules.d/

clean:
	rm -rf build

.PHONY: all prepare build clean
