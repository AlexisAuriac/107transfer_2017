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
	my $next_char = substr($pol, $i + 1, 1);
	if (index("0123456789*-", $char) == -1) {
	    print STDERR "Synthax error: Invalid character\n";
	    return (84);
	}
	elsif ($char eq "*" && $next_char eq "*") {
	    print STDERR "Synthax error: two '*' in a row\n";
	    return (84);
	}
	elsif ($next_char eq "-" && ($i != 0 || $char ne "*")) {
	    print STDERR "Synthax error: bad character before '-'";
	    return (84);
	}
	elsif ($char eq "-" && index("0123456789", $next_char) == -1) {
	    print STDERR "Synthax error: bad character after '-'\n";
	    return (84);
	}
    }
    if (index($pol, "*") == 0 || rindex($pol, "*") == length($pol) - 1) {
	print STDERR "Syntax error: '*' in first or last position\n";
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
	print STDERR "Division by zero 1\n";
	return (84);
    }
    elsif ($turn % 2 == 0 && substr($pol, 0, 1) eq "0") {
	print STDERR "Division by zero 2\n";
	return (84);
    }
}

sub error {
    my $turn = 1;

    if (scalar @ARGV == 1 && $ARGV[0] eq "-h") {
	help();
	exit(0);
    }
    if (scalar @ARGV == 0) {
	print STDERR "Not enough arguments\n";
	return (84);
    }
    if (scalar(@ARGV) % 2 != 0) {
	print STDERR "Odd number of arguments\n";
	return (84);
    }
    foreach my $pol (@ARGV) {
	if (length $pol == 0) {
	    print STDERR "Empty argument\n";
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
