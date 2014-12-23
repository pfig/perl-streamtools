#!perl

use warnings;
use strict;

use lib 'lib';

use Test::More tests => 5;
use Test::Exception;
use Test::LWP::UserAgent;

use Streamtools;
use Streamtools::API::Streamtools::Version;

my $ua = Test::LWP::UserAgent->new;
$ua->map_response(
    qr{localhost:7070/version},
    HTTP::Response->new('200', 'OK',
        ['Content-Type' => 'application/json'],
        '{"Version": "0.2.8"}'));
# $ua->map_response(
#     qr{example.com/fail}, HTTP::Response->new('500', 'ERROR', ['Content-Type' => 'text/plain'], ''));


my $st = Streamtools->new(server => 'localhost', port => 7070, _ua => $ua);
my $v = Streamtools::API::Streamtools::Version->new(_st => $st);
isa_ok($v, 'Streamtools::API::BaseRequest');
isa_ok($v, 'Streamtools::API::Streamtools::Version');

ok($v->method eq 'GET', 'Method is correctly set');
ok($v->path eq 'version', 'Method is correctly set');

ok($st->version->request eq "0.2.8", 'Correct value decoded');
