#!perl

use warnings;
use strict;

use lib 'lib';

use Test::More tests => 7;
use Test::Exception;
use Test::LWP::UserAgent;

use Streamtools;
use Streamtools::API::Streamtools::Export;

my $ua = Test::LWP::UserAgent->new;
{
    local $/ = undef;
    $ua->map_response(
        qr{localhost:7070/export},
        HTTP::Response->new('200', 'OK',
            ['Content-Type' => 'application/json'],
            <DATA>));
}


my $st = Streamtools->new(server => 'localhost', port => 7070, _ua => $ua);
my $l = Streamtools::API::Streamtools::Export->new(_st => $st);
isa_ok($l, 'Streamtools::API::BaseRequest');
isa_ok($l, 'Streamtools::API::Streamtools::Export');

ok($l->method eq 'GET', 'Method is correctly set');
ok($l->path eq 'export', 'Path is correctly set');

my $pattern = $st->export->request;
ok(keys %$pattern == 2, 'Correct number of sections fetched');
ok(exists $pattern->{'Blocks'}, 'Exported pattern contains blocks');
ok(exists $pattern->{'Connections'}, 'Exported pattern contains connections');

__DATA__
{
  "Blocks": [
    {
      "Id": "1",
      "Type": "fromhttpstream",
      "Rule": {
        "Auth": "",
        "Endpoint": "http://developer.usa.gov/1usagov"
      },
      "Position": {
        "X": 510,
        "Y": 195
      }
    },
    {
      "Id": "2",
      "Type": "tolog",
      "Rule": null,
      "Position": {
        "X": 646,
        "Y": 362
      }
    }
  ],
  "Connections": [
    {
      "Id": "3",
      "FromId": "1",
      "ToId": "2",
      "ToRoute": "in"
    }
  ]
}
