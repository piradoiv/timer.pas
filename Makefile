PREPARE_BUILD = rm -rf src/lib/$@ && mkdir -p src/lib/$@ dist
BUILD_COMMAND = fpc -O3 -Os -CX -XX -Xs -FUsrc/lib/$@ -otimer-$@
POST_BUILD = mv src/timer-$@ dist/timer-$@ && cd dist && zip timer-$@.zip timer-$@

all: linux-arm linux-x86_64 macos-x86_64

linux-arm:
	$(PREPARE_BUILD)
	$(BUILD_COMMAND) -Tlinux -Parm src/timer.lpr
	$(POST_BUILD)

linux-x86_64:
	$(PREPARE_BUILD)
	$(BUILD_COMMAND) -Tlinux -Px86_64 src/timer.lpr
	$(POST_BUILD)

macos-x86_64:
	$(PREPARE_BUILD)
	$(BUILD_COMMAND) -Tdarwin -Px86_64 src/timer.lpr
	strip src/timer-$@
	$(POST_BUILD)

clean:
	rm -rf dist src/lib

