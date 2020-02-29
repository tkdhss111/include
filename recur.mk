.PHONY : default
default: prep release lib

.PHONY : lib
lib:
	for d in $(DIRS); \
	do \
		make lib --directory=$$d; \
	done

.PHONY : release
release:
	for d in $(DIRS); \
	do \
		make release --directory=$$d; \
	done

.PHONY : debug
debug:
	for d in $(DIRS); \
	do \
		make debug --directory=$$d; \
	done

.PHONY : prep
prep:
	for d in $(DIRS); \
	do \
		make prep --directory=$$d; \
	done

.PHONY : clean
clean:
	for d in $(DIRS); \
	do \
		make clean --directory=$$d; \
	done

.PHONY : install
install:
	for d in $(DIRS); \
	do \
		make install --directory=$$d; \
	done

.PHONY : uninstall
uninstall:
	for d in $(DIRS); \
	do \
		make uninstall --directory=$$d; \
	done
