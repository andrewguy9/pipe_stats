#!/usr/bin/perl
use warnings;
use strict;

my $year;
my $yoc;
my $month;
my $dow;
my $dom;
my $hour;
my $min;
my $sec;
my $sub_sec;
my $zone;

# mdt
my $mdt_date = "Jul 26 12:59:45 ";
my %mdt_format = (
  regex => '^([A-Z][a-z]{2,2}) (\d\d) (\d\d):(\d\d):(\d\d)\s',
  year => 0,
  yoc => 0,
  month => 1,
  dow => 0,
  dom => 2,
  hour => 3,
  min => 4,
  sec => 5,
  sub_sec => 0,
  zone => 0,
);

# mdyt
my $mdyt_date = "07/30/12 00:33:35 ";
my %mdyt_format = (
  regex => '^(\d\d)/(\d\d)/(\d\d) (\d\d):(\d\d):(\d\d)\s',
  year => 3,
  yoc => 0,
  month => 1,
  dow => 0,
  dom => 2,
  hour => 4,
  min => 5,
  sec => 6,
  sub_sec => 0,
  zone => 0,
);

# ymdtz
my $ymdtz_date = '2012-08-29 10:35:24.652661 PDT ';
my %ymdtz_format = (
  regex => '^(\d\d(\d\d))-(\d\d)-(\d\d) (\d\d):(\d\d):(\d\d)\.(\d+)\s([A-Z]+)\s',
  year => 1,
  yoc => 2,
  month => 3,
  dow => 0,
  dom => 4,
  hour => 5,
  min => 6,
  sec => 7,
  sub_sec => 8,
  zone => 9,
);

# wmdt
my $wmdt_date = 'Thu Jul 26 12:59:43 ';
my %wmdt_format = (
  regex => '^([A-Z][a-z]+) ([A-Z][a-z]+) (\d\d) (\d\d):(\d\d):(\d\d)\s',
  year => 0,
  yoc => 0,
  month => 2,
  dow => 1,
  dom => 3,
  hour => 4,
  min => 5,
  sec => 6,
  sub_sec => 0,
  zone => 0,
);

my %format = %ymdtz_format;
my $date = $ymdtz_date;

my @groups = ();
print "$format{regex}\n";
if( $date =~ /$format{regex}/) {
  @groups = (undef,$1,$2,$3,$4,$5,$6,$7,$8,$9);
} else {
  print "nope\n";
}

$year    = $groups[$format{year}];
$yoc     = $groups[$format{yoc}];
$month   = $groups[$format{month}];
$dow     = $groups[$format{dow}];
$dom     = $groups[$format{dom}];
$hour    = $groups[$format{hour}];
$min     = $groups[$format{min}];
$sec     = $groups[$format{sec}];
$sub_sec = $groups[$format{sub_sec}];
$zone    = $groups[$format{zone}];

print "Date     $date\n";
print "Year    '$year'\n" if $year;
print "YOC     '$yoc'\n" if $yoc;
print "Month   '$month'\n" if $month;
print "Week    '$dow'\n" if $dow;
print "Day     '$dom'\n" if $dom;
print "Hour    '$hour'\n" if $hour;
print "Min     '$min'\n" if $min;
print "Sec     '$sec'\n" if $sec;
print "Sub_sec '$sub_sec'\n" if $sub_sec;
print "Zone    '$zone'\n" if $zone;

