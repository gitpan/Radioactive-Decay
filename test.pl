# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

use strict;

use vars qw($Total_tests);

my $loaded;
my $test_num = 0;
my $OK_tests = 0;

BEGIN { $| = 1; $^W = 1; $test_num=1}
END {print "not ok $test_num\n" unless $loaded;}
print "1..$Total_tests\n";
use Radioactive::Decay;
$loaded = 1;
ok(1, 'compile()' );

# Utility testing functions.
sub ok {
    my ($test, $name) = @_;
    if ($test) {
      $OK_tests++;
    } else {
      print "not ";
    }
    printf "ok %d", ++$test_num;
    print " - $name" if defined $name;
    print "\n";
}

######################### End of black magic.

BEGIN { $Total_tests = 4 }

tie my $var, 'Radioactive::Decay', 1;

$var = 20;
sleep 1;
ok($var == 10, "Decayed to 10");
sleep 1;
ok($var == 5, "Decayed to 5");
sleep 1;
ok($var eq 2.5, "Decayed to 2.5");

warn "You actually had $Total_tests tests ...\n" unless ($test_num == $Total_tests);
# die "Only $OK_tests out of $Total_tests OK...\n" unless ($OK_tests == $Total_tests);

