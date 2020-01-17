all: prep release

release:
	for d in $(DIRS); \
	do \
		make release --directory=$$d; \
	done

prep:
	for d in $(DIRS); \
	do \
		make prep --directory=$$d; \
	done

clean:
	for d in $(DIRS); \
	do \
		make clean --directory=$$d; \
	done

install:
	for d in $(DIRS); \
	do \
		make install --directory=$$d; \
	done
