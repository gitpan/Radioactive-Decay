package Radioactive::Decay;

=pod

=head1 NAME

Radioactive::Decay - allow scalar values to decay over time

=head1 SYNOPSIS

  use Radioactive::Decay;

  my $halflife = 10;
  tie my $var, $Radioactive::Decay, $halflife;

  $var = 40;
  sleep 10;
  print $var;  # 20
  sleep 10;
  print $var;  # 10

=head1 DESCRIPTION

This allows you to tie a scalar variable so that it will decay over
time. 

For example, if you set a half-life of 30 seconds, then a variable which
is set to 100 now will be 25 in a minute's time.

We're sure there are all manner of useful applications for this, and hopefully
someone will let us know what they are.

=head1 AUTHOR

  Marty <marty@kasei.com>, Tony Bowden <tony@tmtm.com>.
  Comments should be made collectively to <perl-decay@tmtm.com>

=head1 LICENSE

This program may be distributed under the same license as Perl itself.

=cut

use strict;
use vars qw/$VERSION/;
$VERSION = "0.02";

sub TIESCALAR { bless [0,log(2)/$_[1], time], $_[0]; }
sub STORE     { $_[0]->[0] = $_[1] }
sub FETCH     { $_[0]->[0] * exp(-$_[0]->[1] * (time - $_[0]->[2])) }
sub DESTROY   {}


return q/
  make me laugh make me cry enrage me don't try to disengage me
/;

