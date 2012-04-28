#!/usr/bin/perl

use strict;
use warnings;
use POSIX;

use Getopt::Long;
use List::Util qw[min max];

my $step = 1;

my $result = GetOptions(
        "step=i" => \$step
) or die usage("Invalid input: $!");

my @data;
while(<>) {
        chomp;
        push @data, $_;
}

my $low = floor(min(@data));

my %bins = ();
for my $val (@data) {
        my $bin = floor(($val - $low) / $step);
        $bins{$bin}++;
}

my $last = 0;
for my $i (sort {$a <=> $b} keys %bins) {
        for (my $gap = $last; $gap < $i; $gap++) {
                my $gap_bottom = $gap * $step;
                my $gap_top = ($gap+1) * $step;

                print "[$gap_bottom-$gap_top) 0\n";
        }
        my $bottom = $i * $step;
        my $top = ($i+1) * $step;
        my $num = $bins{$i};

        print "[$bottom-$top) $num\n";
        $last = $i;
}

sub usage {
        my $msg = shift @_;

        print STDERR "$msg\n";
        print STDERR "Bucketize.pl [--step n]\n";
        print STDERR "Consumes stream of the format\n";
        print STDERR "number\n..."
}
