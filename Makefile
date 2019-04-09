build:
	fpc -O3 -Os -CX -XX -Xs -otimer src/timer.lpr
	mv src/timer timer
	strip timer

releases:
	mkdir -p dist
	fpc -Tlinux -Px86_64 -O3 -Os -CX -XX -Xs -otimer src/timer.lpr
	mv src/timer dist/timer-linux-x86_64
	fpc -Tlinux -Parm -O3 -Os -CX -XX -Xs -otimer src/timer.lpr
	mv src/timer dist/timer-linux-arm
	fpc -Tdarwin -Px86_64 -O3 -Os -CX -XX -Xs -otimer src/timer.lpr
	mv src/timer dist/timer-macos-x86_64
	strip dist/timer-macos-x86_64
	cd dist && zip timer-linux-x86_64.zip timer-linux-x86_64
	cd dist && zip timer-linux-arm.zip timer-linux-arm
	cd dist && zip timer-macos-x86_64.zip timer-macos-x86_64

clean:
	rm -f src/*.o
	rm -f src/*.ppu
	rm -rf src/lib
	rm -f timer
	rm -rf dist

all: build releases

