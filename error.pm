#!/bin/perl

use strict;
use warnings;

sub help {
    print << 'END_HELP';
USAGE
        ./107transfer [num den]*
DESCRIPTION
        num   polynomial numerator defined by its coeficients
        den   polynomial denominator defined by its coeficients
END_HELP
}

sub error_syntax {
    my ($pol) = @_;

    for (my $i = 0 ; $i < length $pol ; ++$i) {
	my $char = substr($pol, $i, 1);
	if (index("0123456789*", $char) == -1) {
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

sub division_by_zero {
    my ($pol, $turn) = @_;
    my $chars = "";

    for (my $i = 0 ; $i < length $pol ; ++$i) {
	my $char = substr($pol, $i, 1);
	if (index($chars, $char) == -1) {
	    $chars .= $char;
	}
    }
    if ($turn % 2 == 0 && ($chars eq "0" || $chars eq "0*")) {
	return (84);
    }
    elsif ($turn % 2 == 0 && substr($pol, 0, 1) eq "0") {
	return (84);
    }
}

sub error {
    my $turn = 1;

    if (scalar @ARGV == 1 && $ARGV[0] eq "-h") {
	help();
	exit(0);
    }
    if (scalar @ARGV == 0 || scalar(@ARGV) % 2 != 0) {
	return (84);
    }
    foreach my $pol (@ARGV) {
	if (length $pol == 0) {
	    return (84);
	}
	if (error_syntax($pol) == 84 || division_by_zero($pol, $turn)) {
	    return (84);
	}
	++$turn;
    }
    return 0;
}

1;
