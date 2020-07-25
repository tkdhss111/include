DIR_INS=${HOME}/local/
DIR_BIN=${DIR_INS}bin/
DIR_LIB=${DIR_INS}lib/

CMAKE=FC=caf cmake .. -GNinja -DCMAKE_INSTALL_PREFIX=${DIR_INS}
CMAKE_RLS=$(CMAKE) -DCMAKE_BUILD_TYPE=Release
CMAKE_DBG=$(CMAKE) -DCMAKE_BUILD_TYPE=Debug

NINJA=ninja

MKDIR=mkdir -p
MKDIR_BUILD=$(MKDIR) build && cd build

default: release

debugrun: debug
	build/src/$(BIN)

run: release
	${DIR_BIN}$(BIN)

.PHONY: tests
tests:
	$(MKDIR_BUILD) && $(CMAKE_DBG) && ninja && ctest -VV

.PHONY: debug
debug:
	$(MKDIR_BUILD) && $(CMAKE_DBG) && $(NINJA)

.PHONY: release
release:
	$(MKDIR_BUILD) && $(CMAKE_RLS) && $(NINJA) && $(NINJA) install

.PHONY: release_intel
release_intel:
	source /opt/intel/compilers_and_libraries/linux/bin/compilervars.sh -arch intel64 -platform linux && \
	export FC=ifort CC=icc CXX=icpc && \
	$(MKDIR_BUILD) && $(CMAKE_RLS) && $(NINJA) && $(NINJA) install

clean:
	rm -r build ${HOME}/local/bin/${BIN}

clean_lib:
	rm -r build ${HOME}/local/lib/${LIB}
