# Test::MockDBI fetch*() with 0-element array returned from coderef

# $Id: coderef-array-0.t 246 2008-12-04 13:01:22Z aff $

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
my $dbh    = "";                            # mock DBI database handle
my $md     = Test::MockDBI::get_instance();

# ------ set up return values for DBI fetch*() methods
$dbh = DBI->connect("", "", "");
$md->set_retval_scalar(2, "FETCHROW_ARRAY",  sub {});

# test non-matching sql
$dbh->prepare("other SQL");  
ok(!defined($dbh->fetchrow_array()), q{Expect undef for non-matching sql});
$dbh->finish();

# test matching sql
$dbh->prepare("FETCHROW_ARRAY");  
ok(!defined($dbh->fetchrow_array()), q{Expect undef for matching sql since sub returns undef});
$dbh->finish();

__END__
