Zip bomb tools
https://www.bamsoftware.com/hacks/zipbomb/
David Fifield <david@bamsoftware.com>
Public domain


zipbomb is a Python 3 script that generates zip bombs according to
parameters. Example:
	python3 zipbomb --mode=quoted_overlap --num-files=250 --compressed-size=21179 > zbsm.zip
See Makefile for some examples of using it.

optimize.R is an R script that computes optimal parameters for the
zipbomb script, for zip bombs of various sizes. optimize.out is
pregenerated output of optimize.R.
	Rscript optimize.R | tee optimize.out
The optimized parameters are what you see in Makefile.

ratio is a Python 3 script that computes the compression ratio of zip
files listed on the command line.
	$ make zbsm.zip zblg.zip zbxl.zip
	$ python3 ratio zbsm.zip zblg.zip zbxl.zip
	zbsm.zip	5461307620 / 42374	128883.45730872705	+51.102 dB
	zblg.zip	281395456244934 / 9893525	28442385.9286689	+74.54 dB
	zbxl.zip	4507981427706459 / 45876952	98262444.01996146	+79.924 dB


## zipbomb usage

The required options are the number of files you want the zip bomb to
contain,
	--num-files=100
and the size of the kernel, which can be either a specific *compressed*
size, or a maximum *uncompressed* size.
	--compressed-size=1000
	--max-uncompressed-size=20000

The script can run in one of three main modes:
	--mode=no_overlap
	--mode=full_overlap
	--mode=quoted_overlap (default)
In quoted_overlap mode, you can additionally enable extra-field quoting;
you need to provide a 4-digit hexadecimal tag type:
	--mode=quoted_overlap --extra=9999
In quoted_overlap mode, you can also specify to quote as many subsequent
headers as possible, not just one. This produces slightly larger output
file sizes and is useful whenever you are not constrained by maximum
file size (when operating below the 0xffffffff file size limit, or when
using Zip64).
	--mode=quoted_overlap --giant-steps

You can choose either DEFLATE or bzip2 as the compression algorithm.
	--algorithm=deflate (default)
	--algorithm=bzip2
There are limitations when using bzip2. If you use bzip2 in
quoted_overlap mode, you must also use --extra, because bzip2 does not
have its own way of quoting local file headers. And the argument to the
--compressed-size must be congruent to 14 mod 32 when used with bzip2.

Enable Zip64 support for zip bombs that need it (more than 0xfffe files
or files larger than 0xfffffffe bytes). The script will crash somewhere
if the output needs Zip64 but the option isn't enabled.
	--zip64
The need for Zip64 isn't detected automatically because I wanted to
decide in advance whether a particular zip bomb should use Zip64 or not
(and get an error if my calculations were wrong), and because it's
slightly tricky to predict whether the maximum file size will exceed the
threshold in quoted_overlap mode, where files get longer the more of
them that are added (the optimize.R script does this calculation,
though).

The default filename alphabet is 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ.
You can change it with the --alphabet option.
	--alphabet=0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz

If you need the zip bomb to contain certain ordinary files in addition
to the bomb files, you can provide one or more template zip files.
	--template=other.zip
The --num-files option is *in addition* to whatever files are in the
template.
