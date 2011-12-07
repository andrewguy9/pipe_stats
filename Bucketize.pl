#!/usr/bin/perl

use strict;
use warnings;

use Getopt::Long;

my $from;
my $to;
my $num_bins;

my $result = GetOptions(
	"from=i" => \$from,
	"to=i" => \$to,
	"bins=i" => \$num_bins,
) or die "Invalid input: $!";

die "from must be provided" unless defined $from;
die "die must be provided" unless defined $to;
die "bins must be provided" unless defined $num_bins;

my $step = ($to - $from) / $num_bins;
my @bins;
for my $i (0 .. $num_bins) {
	push @bins, ($i * $step) + $from;
}

my $low=0;
my $high=0;
my @counts;
for my $i (@bins) {
	$counts[$i] = 0;
}

while(<>) {
	my $value = $_;
	
	if ($value < $bins[0]) {
		$low++;
	} elsif ($value > $bins[$num_bins-1]+$step) {
		$high++;
	} else {
		for my $i (@bins) {
			if ($value > $i) {
				$counts[$i]++;
				last;
			}
		}
	}
}

print "Low $low\n";
for my $i (@bins) {
	print "$i-" . ($i+$step) . " $counts[$i]\n";
}
print "High $high\n";

