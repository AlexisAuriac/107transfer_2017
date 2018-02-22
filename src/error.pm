#!/bin/perl

use strict;
use warnings;

sub error {
    if (scalar @ARGV == 0) {
	return (84);
    }
    foreach my $pol (@ARGV) {
	if (length $pol == 0) {
	    return 84;
	}
	for (my $i = 0 ; $i < length $pol ; ++$i) {
	    my $char = substr($pol, $i, 1);
	    if (($char lt 0 || $char gt 9) && $char ne "*") {
		return (84);
	    }
	    elsif ($char eq "*" && substr($pol, $i + 1, 1) eq "*") {
		return (84);
	    }
	}
	if (index($pol, "*") == 0 || index($pol, "*") == length($pol) - 1) {
	    return (84);
	}
    }
    return 0;
}

1;
