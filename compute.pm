#!/bin/perl

use strict;
use warnings;

sub compute_pol {
    my ($pol, $x) = @_;
    my $result = 0;
    my $first = index $pol, "*";
    my $last = rindex $pol, "*";
    my $mem = $pol;

    if ($first != -1) {
	$mem = substr($pol, 0, $first);
	$result += compute_pol(substr($pol, $first + 1, length($pol) - $first), $x) * $x;
    }
    return $mem + $result;
}

1;
