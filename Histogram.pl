#!/usr/bin/perl
use strict;
use warnings;

use List::Util qw[min max];
use Getopt::Long;

my $line_width;
my $bucket_width;
my $star_width;
my $use_percentage = 0;

# Collect Options
GetOptions(
	"width=i" => \$line_width,
	"bwidth=i" => \$bucket_width,
	"percentage" => \$use_percentage,
) or die "Invalid input: $!";

# Sanity Check
my $terminal_width = `tput cols`;

# Gather buckets from STDIN
my %buckets;

my @buckets;
my @values;
my $bucket_width_max = 0;
my $n = 0;
my $sum = 0;
while(<>) {
	chomp;

	my $line = $_;
	(my $bucket, my $value) = split /\s/, $line;
	push @buckets, $bucket;
	push @values, $value;

	$bucket_width_max = max($bucket_width_max, length($bucket));
	$n++;
	$sum += $value;
}

# Compute Results
my $max_value = max(@values);

# Determine output dimensions
$line_width = $terminal_width unless defined $line_width;
$bucket_width = min($bucket_width_max, $line_width / 2) unless defined $bucket_width;
my $line_spaces = 1;
$star_width = $line_width - $bucket_width - $line_spaces;

# Produce Output
# Output format
# <bucket> <stars>
while(@buckets) {
	my $bucket = shift @buckets;
	my $value = shift @values;

	$bucket = substr $bucket, 0, $bucket_width;
	$bucket .= " " x ($bucket_width - length($bucket));
	my $meter_percentage;
	if($use_percentage) {
		$meter_percentage = $value / $sum;
	} else {
		$meter_percentage = $value / $max_value;
	}
	my $stars = "*" x (int($star_width * $meter_percentage));

	printf("%s %s\n", $bucket, $stars);
}

