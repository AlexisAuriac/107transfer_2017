#!/bin/perl

use strict;
use warnings;

sub error {
    my $chars = "";
    my $turn = 1;
    
    if (scalar @ARGV == 0 || scalar(@ARGV) % 2 != 0) {
	return (84);
    }
    foreach my $pol (@ARGV) {
	$chars = "";
	if (length $pol == 0) {
	    return 84;
	}
	for (my $i = 0 ; $i < length $pol ; ++$i) {
	    my $char = substr($pol, $i, 1);
	    if (index("0123456789*", $char) == -1) {
		return (84);
	    }
	    elsif ($char eq "*" && substr($pol, $i + 1, 1) eq "*") {
		return (84);
	    }
	    elsif (index($chars, $char) == -1) {
		$chars .= $char;
	    }
	}
	if ($turn % 2 == 0 && ($chars eq "0" || $chars eq "0*")) {
	    return (84);
	}
	elsif (eval $pol == 0) {
	    return (84);
	}
	if (index($pol, "*") == 0 || index($pol, "*") == length($pol) - 1) {
	    return (84);
	    }
	    ++$turn;
    }
    return 0;
}

1;
