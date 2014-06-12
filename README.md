![alt tag](https://raw.githubusercontent.com/lateralblast/crfl/master/crfl.jpg)

CRFL
====

Card Recon File List

Introduction
------------

Perl script to produce a file list from a Card Recon PDF report

License
-------

This software is licensed as CC-BA (Creative Commons By Attrbution)

http://creativecommons.org/licenses/by/4.0/legalcode

Requirements
------------

This script requires the following:

- Perl
- pdf2text

Usage
-----

```
$ crfl.pl -[hVb:i:o:]

-h: Display help/usage
-V: Display version
-i: Input file
-o: Output file
-b: Home Directory
```

Examples
--------

Process Card Recon PDF report to generate a file list:

```
$ crfl.pl -i report.pdf -o filelist.txt
```

