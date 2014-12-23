#!perl

use warnings;
use strict;

use lib 'lib';

use Test::More tests => 21;
use Test::Exception;

use Streamtools;

my $expected_server = 'localhost';
my $expected_port = 7070;

# simple instantiation
my $st = Streamtools->new(server => $expected_server, port => $expected_port);
isa_ok($st, 'Streamtools');
is($st->server, $expected_server);
is($st->port, $expected_port);
is($st->retry, 0);
is($st->timeout, 10);
isa_ok($st->_ua, 'LWP::UserAgent');
isa_ok($st->_json, 'JSON');

# retry
$st = Streamtools->new(
    server => $expected_server,
    port => $expected_port,
    retry => 1
);
is($st->retry, 1);
isa_ok($st->_ua, 'LWP::UserAgent::Determined');

# timeout
$st = Streamtools->new(
    server => $expected_server,
    port => $expected_port,
    timeout => 30
);
is($st->timeout, 30);

# parameter validation
dies_ok { $st = Streamtools->new(port => $expected_port) }
    'constructor requires a server';
dies_ok { $st = Streamtools->new(server => $expected_server) }
    'constructor requires a port';
dies_ok { $st = Streamtools->new(server => $expected_server, port => 'frobnitzer') }
    'port must be a number';
dies_ok { $st->server('frobnitzer') } 'server is read-only';
is($st->server, $expected_server);
dies_ok { $st->port(7777) } 'port is read-only';
is($st->port, $expected_port);
dies_ok { $st->retry(1) } 'retry is read-only';
is($st->retry, 0);
dies_ok { $st->timeout(15) } 'timeout is read-only';
is($st->timeout, 30);
