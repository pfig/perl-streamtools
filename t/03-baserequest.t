#!perl

use warnings;
use strict;

use lib qw(lib t/lib);

use Test::More tests => 14;
use Test::Exception;

use Streamtools;
use Streamtools::API::BaseRequest;
use Streamtools::API::NullRequest;
use Streamtools::API::TestRequest;

my $st = Streamtools->new(server => 'localhost', port => 7070);
my $t = Streamtools::API::NullRequest->new(_st => $st);
isa_ok($t, 'Streamtools::API::NullRequest');

dies_ok { $t->request }
    'request() needs to be implemented';
dies_ok { $t->method }
    'method() needs to be implemented';
dies_ok { $t->path }
    'path() needs to be implemented';


$t = Streamtools::API::TestRequest->new(_st => $st);
# these should match whatever is in TestRequest, for convenience's sake
my $header = 'Content-type';
my $value = 'application/json';
my $headers = { $header => $value };
my $http_headers = $t->_make_headers($headers);
ok($http_headers->header_field_names == 1, 'Headers have correct number of entries');
ok($http_headers->header($header) eq $value, 'Headers are set correctly');

my $unencoded_path = 'frobnitzer?foo=baz';
my $encoded_path = 'frobnitzer%3Ffoo%3Dbaz';
my $resulting_path = $t->_urlencode($unencoded_path);
ok($resulting_path eq $encoded_path, 'Path is URL-encoded correctly');

my $request = $t->_make_request;
ok($request->method eq $t->method, 'Correct method used in request');
ok($request->uri->path eq '/' . $encoded_path, 'Correct path used in request');
ok($request->uri->scheme =~ /^http$/i, 'Correct scheme used in request');
ok($request->uri->host eq 'localhost', 'Correct host name used in request');
ok($request->uri->port == 7070, 'Correct port used in request');
ok($request->header($header) eq $value, 'Correct headers set in request');


# parameter validation
dies_ok { $t = Streamtools::API::TestRequest->new }
    'Streamtools object should have been passed in';
