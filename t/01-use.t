#!perl

use warnings;
use strict;

use lib 'lib';

use Test::More tests => 4;

use_ok('Streamtools');
use_ok('Streamtools::API::BaseRequest');
use_ok('Streamtools::API::Streamtools::Version');
use_ok('Streamtools::API::Streamtools::Library');
