#!/usr/bin/env perl

use strict;
use Getopt::Std;

# Name:         crfl.pl
# Version:      0.0.5
# Release:      1
# License:      Open Source 
# Group:        System
# Source:       Lateral Blast  
# URL:          N/A
# Distribution: Solaris
# Vendor:       UNIX
# Packager:     Richard Spindler <richard@lateralblast.com.au>
# Description:  Script to produce a file list from a Card Recon PDF report
#               (Requires pdftotext to be installed)

# Changes       0.0.1 Fri 20 Sep 2013 14:34:33 EST
#               Initial version
#               0.0.2 Tue 24 Sep 2013 15:43:44 EST
#               Cleaned up script
#               0.0.3 Wed 25 Sep 2013 17:35:59 EST
#               Fixed description 
#               0.0.4 Wed 25 Sep 2013 18:17:00 EST
#               Added clean up subroutine
#               0.0.5 Thu 26 Sep 2013 07:39:04 EST
#               Cleaned up description

my $script_name=$0;
my $script_version=`cat $script_name | grep '^# Version' |awk '{print \$3}'`;
my $options="hVb:i:o:";
my %option;
my $input_file;
my $output_file;
my @file_data;
my @file_list;
my $text_file;
my $base_dir;

if ($#ARGV == -1) {
  print_usage();
}
else {
  getopts($options,\%option);
}

# If given -h print usage

if ($option{'h'}) {
  print_usage();
  exit;
}

sub print_version {
  print "$script_version";
  return;
}

# Print usage

sub print_usage {
  print "\n";
  print "Usage: $script_name -[$options]\n";
  print "\n";
  print "-h: Display help/usage\n";
  print "-V: Display version\n";
  print "-i: Input file\n";
  print "-o: Output file\n";
  print "-b: Home Directory\n";
  print "\n";
  print "Example usage:\n";
  print "\n";
  print "$script_name -i report.pdf -o filelist.txt\n";
  print "\n";
  return;
}

if ($option{'b'}) {
  $base_dir=$option{'b'};
}
else {
  $base_dir="/export/home";
}

if ($option{'i'}) {
  $input_file=$option{'i'};
  if ($option{'o'}) {
    $output_file=$option{'o'};
    $output_file=~s/\.pdf/_file_list\.txt/g;
  }
  generate_text_file();
  import_file_data();
  process_file_data();
  generate_file_list();
  clean_up_files();
  exit;
}

sub generate_text_file {
  $text_file="/tmp/$input_file".".txt";
  system("pdftotext $input_file $text_file");
  return;
}

sub import_file_data {
  my $file_handle;
  if (-e "$input_file.txt") {
    @file_data=do {
      open my $file_handle, "<", $text_file or die "could not open $text_file: $!";
      <$file_handle>;
    };
  }
}

sub process_file_data {
  my $line;
  my $counter;
  my $next;
  my $next_line;
  my $file_name;
  for ($counter=0;$counter<@file_data;$counter++) {
    $line=@file_data[$counter]; 
    chomp($line);
    if ($line=~/^$base_dir\/[a-z]/) {
      $next=$counter+1;
      $next_line=@file_data[$next];
      chomp($next_line);
      if ($next_line=~/[A-z|0-9]/) {
        $file_name="$line$next_line";
      }
      else {
        $file_name="$line";
      }
      push(@file_list,$file_name);
    }
  }
}

sub generate_file_list {
  my $line;
  if ($option{'o'}) {
    open(OUTPUT,">",$output_file);
  }
  foreach $line (@file_list) {
    if ($option{'o'}) {
      print OUTPUT "$line\n";
    }
    else {
      print "$line\n";
    }
  }
}

sub clean_up_files {
  system("rm $text_file");
  return;
}