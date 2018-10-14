
DESTDIR :=

BIN := /usr/bin
ETC := /etc
DOC := /usr/share/doc

INSTALL := \
	$(DESTDIR)$(BIN)/mksignkernels \
	$(DESTDIR)$(ETC)/mksignkernels.mk \
	$(DESTDIR)$(DOC)/mksignkernels/README.md \

.PHONY: install
install : $(INSTALL)

$(DESTDIR)$(BIN)/% : %
	install -D -m 755 -t $(@D) $<

$(DESTDIR)$(ETC)/% : %
	install -D -b -m 644 -t $(@D) $<

$(DESTDIR)$(DOC)/mksignkernels/% : %
	install -D -m 644 -t $(@D) $<
