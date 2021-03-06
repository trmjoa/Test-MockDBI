# Test::MockDBI fetch*() with 0-element array returned from coderef

# $Id: coderef-scalar-0.t 246 2008-12-04 13:01:22Z aff $

# ------ enable testing mock DBI
BEGIN { push @ARGV, "--dbitest=2"; }

# ------ use/require pragmas
use strict;            # better compile-time checking
use warnings;          # better run-time checking

use Test::More;        # advanced testing

use File::Spec::Functions;
use lib catdir qw ( blib lib );    # use local module
use Test::MockDBI;     # module we are testing

plan tests => 2;

# ------ define variables
my $dbh    = "";                              # mock DBI database handle
my $md     = Test::MockDBI::get_instance();
my $retval = undef;

# ------ set up return values for DBI fetch*() methods
$dbh = DBI->connect("", "", "");
$md->set_retval_scalar(2, "FETCHROW",  sub {});

# test non-matching sql
$dbh->prepare("other SQL");  
$retval = $dbh->fetchrow_arrayref();
ok(!defined($retval), q{Expect 0 columns});
$dbh->finish();

# test matching sql
$dbh->prepare("FETCHROW");  
$retval = $dbh->fetchrow_arrayref();
ok(!defined($retval), q{Expect undef for matching sql since sub returns undef});

$dbh->finish();


__END__

=pod

=cut
