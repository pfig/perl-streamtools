#!perl

use warnings;
use strict;

use lib 'lib';

use Test::More tests => 3;

use_ok('Streamtools');
use_ok('Streamtools::API::BaseRequest');
use_ok('Streamtools::API::Streamtools::Version');
