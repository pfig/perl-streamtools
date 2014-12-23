use strict;
use warnings;
package Streamtools::API::Streamtools::Version;

# ABSTRACT: GET /version

=for test_synopsis
no strict 'vars'

=head1 SYNOPSIS

    my $st = Streamtools->new(server => 'localhost', port => 7070);
    my $version = $st->version->request;

=head1 DESCRIPTION

A representation of the /version resource.

=cut

use Carp 1.3301;
use HTTP::Status 6.03 qw(:is status_message);
use Readonly 2.00;

use Moo 1.006;
use MooX::Types::MooseLike::Base 0.27 qw(:all);

extends 'Streamtools::API::BaseRequest';

use namespace::clean 0.25;

Readonly::Scalar my $METHOD => 'GET';
Readonly::Scalar my $PATH => 'version';

has method => (
    is => 'ro',
    isa => Str,
    required => 0,
    default => sub { $METHOD }
);

has path => (
    is => 'ro',
    isa => Str,
    required => 0,
    default => sub { $PATH }
);

sub request {
    my $self = shift;

    my $http_request = $self->_make_request;
    # TODO: proper error/exception handling
    my $response = $self->_st->_ua->request($http_request);
    my $code = $response->code;

    if (is_success($code)) {
        my $val = $self->_st->_json->decode($response->decoded_content);
        return $val->{'Version'};
    }
    else {
        confess status_message($code);
    }
}

1;
