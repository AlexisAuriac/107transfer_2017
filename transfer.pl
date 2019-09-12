#!/bin/perl

use strict;
use warnings;
use error;
use compute;

if (error() == 84) {
    exit 84;
}

for (my $x = 0 ; $x < 1.001 ; $x += 0.001) {
    my $result = 1;
    for (my $i = 0 ; $i < scalar(@ARGV) ; ++$i) {
        if ($i % 2 == 0) {
            $result *= compute_pol($ARGV[$i], $x);
        } else {
            $result /= compute_pol($ARGV[$i], $x);
        }
    }
    $x = eval sprintf("%.3f", $x);
    print "$x -> ";
    print sprintf("%.5f\n", $result);
    $result = 0;
}
