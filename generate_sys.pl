#! /usr/bin/perl

use warnings;
use strict;

die "Argumente: $0 Input Output\n" unless @ARGV == 2;

my($inputfile,$outputfile) = @ARGV;

open my $in, "<", $inputfile or die "$0: open $inputfile: $!";
open my $out, ">", $outputfile or die "$0: open $outputfile: $!";

my $counter = 1;

while (my $z = <$in>) {
    if ($z =~ /<controlfield tag="001"><\/controlfield>/) {
        my $counter9 = sprintf("%09d", $counter);
        $z = '<controlfield tag="001">' . $counter9 . '</controlfield>'. "\n";
        $counter ++;
    }
    print $out $z;
}

close $out or warn "$0: close $outputfile:: $!";

