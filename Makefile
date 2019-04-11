BUILD_COMMAND = fpc -O3 -Os -CX -XX -Xs -FUsrc/lib/$@ -otimer-$@

build:
	fpc -O3 -Os -CX -XX -Xs -otimer src/timer.lpr
	mv src/timer timer
	strip timer

releases: linux-arm linux-x86_64 macos-x86_64

linux-arm:
	rm -rf src/lib/$@
	mkdir -p src/lib/$@ dist
	$(BUILD_COMMAND) -Tlinux -Parm src/timer.lpr
	mv src/timer-$@ dist/timer-$@
	cd dist && zip timer-$@.zip timer-$@

linux-x86_64:
	rm -rf src/lib/$@
	mkdir -p src/lib/$@ dist
	$(BUILD_COMMAND) -Tlinux -Px86_64 src/timer.lpr
	mv src/timer-$@ dist/timer-$@
	cd dist && zip timer-$@.zip timer-$@

macos-x86_64:
	rm -rf src/lib/$@
	mkdir -p src/lib/$@ dist
	$(BUILD_COMMAND) -Tdarwin -Px86_64 src/timer.lpr
	mv src/timer-$@ dist/timer-$@
	strip dist/timer-$@
	cd dist && zip timer-$@.zip timer-$@

clean:
	rm -f src/*.o
	rm -f src/*.ppu
	rm -rf src/lib
	rm -f timer
	rm -rf dist

all: build releases

