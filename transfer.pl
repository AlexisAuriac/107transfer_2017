#!/bin/perl

use strict;
use warnings;
use error;
use compute;

if (error() == 84) {
    exit 84;
}

my $result = 0;
my $first_arg = shift @ARGV;

for (my $x = 0 ; $x < 1.001 ; $x += 0.001) {
    $result += compute_pol($first_arg, $x);
    foreach my $pol (@ARGV) {
	$result /= compute_pol($pol, $x);
    }
    $x = eval sprintf("%.3f", $x);
    print "$x -> ";
    print sprintf("%.5f\n", $result);
    $result = 0;
}
