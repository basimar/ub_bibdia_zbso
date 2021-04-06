#!/usr/bin/perl
use strict;
#use warnings;
binmode(STDOUT, ":utf8");

use Text::CSV;

my $konkordanz_csv = Text::CSV->new({ sep_char => ';'});
my $items_csv = Text::CSV->new({ sep_char => ';'});

open(my $items, '<:utf8','a150.490'); 
open(my $konkordanz, '<','dsv01-bibdia-aleph-konkordanz.csv'); 

my %konkordanz;

while (my $line_konkordanz = <$konkordanz>) {
   chomp $line_konkordanz;
   $konkordanz_csv->parse($line_konkordanz);
   my @fields_konkordanz = $konkordanz_csv->fields();
   $konkordanz{$fields_konkordanz[1]} = $fields_konkordanz[0];
}

while (my $line_items = <$items>) {
   chomp $line_items;
   if ( $line_items =~ /\$\$w/ ) {
      for (keys %konkordanz) {
          $line_items =~ s/\$\$wBibdia $_$/\$\$w$konkordanz{$_}/g;
      }
   }
print $line_items . "\n";
}

