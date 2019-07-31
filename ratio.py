#!/usr/bin/env python3

# Usage: ratio ZIPFILE [ZIPFILE]...

import math
import os
import sys
import zipfile

for filename in sys.argv[1:]:
    with zipfile.ZipFile(filename) as z:
        zipped_size = os.stat(filename).st_size
        unzipped_size = sum(info.file_size for info in z.infolist())
        r = float(unzipped_size) / zipped_size
        dB = 10.0 * math.log(r, 10)
        print("{}\t{} / {}\t{}\t{:+.5} dB".format(filename, unzipped_size, zipped_size, r, dB))
