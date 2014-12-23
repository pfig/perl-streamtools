use strict;
use warnings;
package Streamtools::API::BaseRequest;

# ABSTRACT: Base class for all API requests

=for test_synopsis
no strict 'vars'

=head1 SYNOPSIS

    package NewKidsOnTheBlock;
    extends 'Streamtools::API::BaseRequest';


=head1 DESCRIPTION

A base class for the different API requests.

Not for external use.

=cut

use HTTP::Headers 6.05;
use Sub::Quote 1.006;
use URI::Escape 1.65 qw(uri_escape_utf8);

use Moo 1.006;
with 'Streamtools::API::Requester';
use MooX::Types::MooseLike::Base 0.27 qw(:all);
use namespace::clean 0.25;

has _st => (
    is => 'ro',
    isa => quote_sub(q{
        my ($val) = @_;
        die 'Not a Streamtools object' unless (ref $val) =~ /^Streamtools/
    }),
    required => 1
);

has headers => (
    is => 'ro',
    isa => HashRef[Str],
    required => 0,
    default => sub { {}; }
);

has content => (
    is => 'ro',
    isa => Str,
    required => 0,
    default => sub { ''; }
);

sub method {
    die 'Please implement this method in your concrete classes';
}

sub path {
    die 'Please implement this method in your concrete classes';
}

sub request {
    die 'Please implement this method in your concrete classes';
}

#
# Make request objects
#
sub _make_request {
    my $self = shift;
    my $method = $self->method;
    my $path = $self->path;
    my $headers = $self->headers;
    my $content = $self->content;

    my $http_headers = $self->_make_headers($headers);
    my $protocol = 'http';
    my $uri = $protocol . '://' .
              $self->_st->server . ':' .
              $self->_st->port  . '/' .
              $self->_urlencode($path);

    my $request = HTTP::Request->new($method, $uri, $http_headers, $content);

    return $request;
}

#
# Make HTTP headers
#
sub _make_headers {
    my ($self, $headers) = @_;
    $headers ||= {};

    my $http_headers = HTTP::Headers->new;
    while (my ($k, $v) = each %$headers) {
        $http_headers->header($k => $v);
    }

    return $http_headers;
}

#
# URL-encode the final URL for the request
#
sub _urlencode {
    my ($self, $unencoded) = @_;
    return uri_escape_utf8($unencoded, '^A-Za-z0-9_-');
}

1;

=for test_synopsis
no strict 'vars'

=head1 SYNOPSIS

  my $request = Streamtools::API::BaseRequest->new(
  )->_make_request;

=head1 DESCRIPTION

This module is a base class for all the Streamtools API requests.

=head1 METHODS
