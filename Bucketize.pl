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
) or die usage("Invalid input: $!");

die usage("from must be provided") unless defined $from;
die usage("die must be provided") unless defined $to;
die usage("bins must be provided") unless defined $num_bins;

die usage("from must be lower than to") unless $from < $to;

my $step = ($to - $from) / $num_bins;
my @bins;
for my $i (0 .. $num_bins - 1) {
        push @bins, ($i * $step) + $from;
}

my $low=0;
my $high=0;
my @counts;
for my $i (@bins) {
        $counts[$i] = 0;
}

while(<>) {
        chomp;
        if ($_ eq "") {
                next;
        }

        my $value = $_;

        if ($value < $bins[0]) {
                $low++;
        } elsif ($value > $bins[$num_bins-1]+$step) {
                $high++;
        } else {
                for my $i (@bins) {
                        if ($value <= $i) {
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

sub usage {
        my $msg = shift @_;

        print STDERR "$msg\n";
        print STDERR "Bucketize.pl --from n --to n --bins n\n";
        print STDERR "Consumes stream of the format\n";
        print STDERR "number\n..."
}
