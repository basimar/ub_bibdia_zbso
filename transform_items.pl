#!/usr/bin/perl
use strict;
#use warnings;
binmode(STDOUT, ":utf8");

use Text::CSV;

my $konkordanz_csv = Text::CSV->new({ sep_char => ';'});
my $items_csv = Text::CSV->new({ sep_char => ';'});

open(my $items, '<:utf8','zbso_items.csv'); 
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
   $items_csv->parse($line_items);
   my @fields_items = $items_csv->fields();
  
   if ($konkordanz{$fields_items[7]}) { 
       print "$konkordanz{$fields_items[7]}" . " 949   L " . '$$b' . $fields_items[0] . '$$c' . $fields_items[1] . '$$s' . $fields_items[2] . '$$m' . $fields_items[3] . '$$i' . $fields_items[4] . '$$h' . $fields_items[5] . '$$f' . $fields_items[6] . '$$z' . $fields_items[8] .  "\n";
   } else {
       #print "Barcode $fields_items[0]: Bibdia-Systemnummer $fields_items[7] nicht gefunden\n";
   }
}

