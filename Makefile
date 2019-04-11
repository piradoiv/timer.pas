PROGRAM = timer
PREPARE_BUILD = rm -rf src/lib/$@ && mkdir -p src/lib/$@ dist
BUILD_COMMAND = fpc -O3 -Os -CX -XX -Xs -FUsrc/lib/$@ -o$(PROGRAM)-$@
POST_BUILD = mv src/$(PROGRAM)-$@ dist/$(PROGRAM)-$@ && cd dist && zip $(PROGRAM)-$@.zip $(PROGRAM)-$@

all: linux-arm linux-x86_64 macos-x86_64

linux-arm:
	$(PREPARE_BUILD)
	$(BUILD_COMMAND) -Tlinux -Parm src/$(PROGRAM).lpr
	$(POST_BUILD)

linux-x86_64:
	$(PREPARE_BUILD)
	$(BUILD_COMMAND) -Tlinux -Px86_64 src/$(PROGRAM).lpr
	$(POST_BUILD)

macos-x86_64:
	$(PREPARE_BUILD)
	$(BUILD_COMMAND) -Tdarwin -Px86_64 src/$(PROGRAM).lpr
	strip src/$(PROGRAM)-$@
	$(POST_BUILD)

clean:
	rm -rf dist src/lib

