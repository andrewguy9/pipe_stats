#!/usr/bin/perl

use strict;
use warnings;

use Getopt::Long;

my $num_bins;

my $result = GetOptions(
        "bins=i" => \$num_bins,
) or die usage("Invalid input: $!");

die usage("bins must be provided") unless defined $num_bins;
die usage("bins must be positive") unless $num_bins > 0;

my @data;
while(<>) {
        chomp;
        print "READ $_\n";
        push @data, $_;
}
@data = sort @data;

my $low = $data[0];
my $high = $data[-1];
my $step = ($high - $low) / $num_bins;

my @bins;
my @lows;
my @highs;
my $bin = 0;
my $bin_low = $low;
my $bin_end = $bin_low + $step;

push @lows, $low;
push @highs, $high;
for my $val (@data) {
        if ($val > $bin_end) {
                $bin++;
                $bin_low = $bin_end;
                $bin_end += $step;
                push @lows, $low;
                push @highs, $high;
        }
        $bins[$bin]++;
}

for (my $i = 0; $i < @bins; $i++) {
        print "$lows[$i]-$highs[$i]:$bins[$i]\n";
}

sub usage {
        my $msg = shift @_;

        print STDERR "$msg\n";
        print STDERR "Bucketize.pl --bins n\n";
        print STDERR "Consumes stream of the format\n";
        print STDERR "number\n..."
}
