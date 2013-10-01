crfl
====

	Script to produce a file list from a Card Recon PDF report
	(Requires pdftotext to be installed)

Usage
=====

	$ crfl.pl -[hVb:i:o:]

	-h: Display help/usage
	-V: Display version
	-i: Input file
	-o: Output file
	-b: Home Directory

Examples:
=========

Process Card Recon PDF report to generate a file list:

	$ crfl.pl -i report.pdf -o filelist.txt

