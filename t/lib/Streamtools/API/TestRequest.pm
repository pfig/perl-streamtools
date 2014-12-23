use strict;
use warnings;
package Streamtools::API::TestRequest;

use Moo;
extends 'Streamtools::API::BaseRequest';
use MooX::Types::MooseLike::Base qw(:all);
use namespace::clean;

has method => (
    is => 'rwp',
    isa => Enum['GET', 'POST', 'PUT', 'DELETE'],
    required => 0
);

has path => (
    is => 'rwp',
    isa => Str,
    required => 0
);

has headers => (
    is => 'rwp',
    isa => HashRef[Str],
    required => 0
);

has content => (
    is => 'rwp',
    isa => Str,
    required => 0
);

sub BUILD {
    my $self = shift;

    $self->_set_method('GET');
    $self->_set_path('frobnitzer?foo=baz');
    $self->_set_headers({ 'Content-type' => 'application/json' });
    $self->_set_content('');
}

1;
