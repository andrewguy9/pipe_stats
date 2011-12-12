#!/usr/bin/perl
use strict;
use warnings;

use List::Util qw[max];

my %buckets;

my @buckets;
my @values;
my $bucket_width_max = 0;
my $n = 0;
while(<>) {
	chomp;

	my $line = $_;
	(my $bucket, my $value) = split /\s/, $line;
	push @buckets, $bucket;
	push @values, $value;

	$bucket_width_max = max($bucket_width_max, length($bucket));
	$n++;
}

my $max_value = max(@values);

my $stars_width_max = `tput cols` - $bucket_width_max - 1;

while(@buckets) {
	my $bucket = shift @buckets;
	my $value = shift @values;
	my $percent = ($value / $n) * 100;

	my $spaces = " " x ($bucket_width_max - length($bucket));
	my $stars = "*" x int(($value/$max_value)*$stars_width_max);

	print "$bucket $spaces$stars";
	print "\n";
}

