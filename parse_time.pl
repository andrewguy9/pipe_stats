#!/usr/bin/perl
use warnings;
use strict;

###############################################################################
################################# DATE FORMATS ################################
###############################################################################

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

###############################################################################
################################## PARSE LIST #################################
###############################################################################

my @formats = (
  \%mdt_format,
  \%mdyt_format,
  \%ymdtz_format,
  \%wmdt_format,
);

my @test_dates = (
  'Jul 26 12:59:45 ',
  '07/30/12 00:33:35 ',
  '2012-08-29 10:35:24.652661 PDT ',
  'Thu Jul 26 12:59:43 ',
);

###############################################################################
################################## FUNCTIONS ##################################
###############################################################################

sub apply_format
{
  my $string = shift;
  my $format = shift;
 
  my @groups = ();
  if( $string =~ /$format->{regex}/) {
    @groups = (undef,$1,$2,$3,$4,$5,$6,$7,$8,$9);

    my %parts = (
      year    => $groups[$format->{year}],
      yoc     => $groups[$format->{yoc}],
      month   => $groups[$format->{month}],
      dow     => $groups[$format->{dow}],
      dom     => $groups[$format->{dom}],
      hour    => $groups[$format->{hour}],
      min     => $groups[$format->{min}],
      sec     => $groups[$format->{sec}],
      sub_sec => $groups[$format->{sub_sec}],
      zone    => $groups[$format->{zone}],
    );

    return \%parts;

  } else {
    return undef;
  }
}

sub parse_string
{
  my $string = shift;
  my $parts = undef;
  for my $format (@formats) {
    if ($parts = apply_format($string, $format)) {
      last;
    }
  }
  return $parts;
}

sub get_local_time_parts 
{
  (my $sec, my $min, my $hour, my $dom, my $month, my $year, my $dow, my $doy, my $daylight) = localtime();

  $year += 1900;

  my %parts = (
      year    => $year,
      yoc     => $year % 1000,
      month   => $month,
      dow     => $dow,
      dom     => $dom,
      hour    => $hour,
      min     => $min,
      sec     => $sec,
      sub_sec => undef,
      zone    => undef,
  );

  return \%parts;
}

###############################################################################
################################ TEST FUNCTIONS ###############################
###############################################################################

sub print_parts
{
  my $parts = shift;

  my $year    = $parts->{year};
  my $yoc     = $parts->{yoc};
  my $month   = $parts->{month};
  my $dow     = $parts->{dow};
  my $dom     = $parts->{dom};
  my $hour    = $parts->{hour};
  my $min     = $parts->{min};
  my $sec     = $parts->{sec};
  my $sub_sec = $parts->{sub_sec};
  my $zone    = $parts->{zone};

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

}

sub test_date {
  my $date = shift;
  if (my $parts = parse_string($date)) {
    print "Date    '$date'\n";
    print_parts($parts);
  } else {
    print "Failed to parse\n";
  }
}

###############################################################################
################################## TEST CODE ##################################
###############################################################################

for my $date (@test_dates) {
  test_date($date);
}

print "****************************************\n";

print_parts( get_local_time_parts() );

