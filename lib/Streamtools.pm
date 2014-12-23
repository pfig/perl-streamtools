use strict;
use warnings;
package Streamtools;

use 5.018;


# ABSTRACT: Client library for Streamtools

=for test_synopsis
no strict 'vars'

=head1 SYNOPSIS

    use Streamtools;

    # Use the Streamtools server at http://localhost:7070
    my $st = Streamtools->new(server => 'localhost', port => 7070);


=head1 DESCRIPTION

This module provides a client library for the REST API provided by Streamtools.
From the developer blurb: "Streamtools is a graphical toolkit for dealing with
streams of data. Streamtools makes it easy to explore, analyse, modify and
learn from streams of data."

To find out more about Streamtools, please visit:

    http://nytlabs.github.io/streamtools/

Development of this code happens here:

    https://github.com/pfig/perl-streamtools/

=cut

use JSON 2.90;
use LWP::UserAgent::Determined 1.07;
use Readonly 2.00;
use Sub::Quote 1.006;

use Moo 1.006;
use MooX::Types::MooseLike::Base 0.27 qw(:all);
use namespace::clean 0.25;

has server => (
    is => 'ro',
    isa => Str,
    required => 1
);

has port => (
    is => 'ro',
    isa => Int,
    required => 1
);

has _ua => (
    is => 'lazy',
    isa => quote_sub(q{
        my ($val) = @_;
        die 'Not a LWP::UserAgent' unless (ref $val) =~ /^(Test::)?LWP::UserAgent/
    }),
    required => 0
);

has retry => (
    is => 'ro',
    isa => Bool,
    required => 0,
    default => 0
);

has timeout => (
    is => 'ro',
    isa => Int,
    required => 0,
    default => 10
);

has _json => (
    is => 'ro',
    isa => quote_sub(q{
        my ($val) = @_;
        die 'Not a JSON parser' unless (ref $val) =~ /^JSON/
    }),
    required => 0,
    default => sub { JSON->new->utf8; }
);

=head1 METHODS

=head2 new

Creates a new Streamtools object.

Takes two MANDATORY arguments, server and port:

    my $st = Streamtools->new(server => 'localhost', port => 7070);

Optionally you can specify whether to retry requests (retry => 1, defaults to
false), and what the connection timeout should be (timeout => 30, defaults to
10 seconds).

=head2 version

Get the version of a Streamtools service:

    my $version = $st->version;
    my $response = $version->request;

Alternatively, of course,

    my $version_response = $st->version->request

=cut

sub version {
    my $self = shift;

    return Streamtools::API::Streamtools::Version->new(_st => $self);
}

=head2 library

=cut

# No user-serviceable parts below.

Readonly::Scalar my $KEEP_ALIVE_CACHESIZE => 10;

sub _build__ua {
    my $self = shift;

    my $ua;
    if ($self->retry) {
        $ua = LWP::UserAgent::Determined->new(
            keep_alive => $KEEP_ALIVE_CACHESIZE,
            requests_redirectable => [qw(GET HEAD DELETE PUT POST)],
        );
        $ua->timing('1,2,4,8,16,32');
    } else {
        $ua = LWP::UserAgent->new(
            keep_alive => $KEEP_ALIVE_CACHESIZE,
            requests_redirectable => [qw(GET HEAD DELETE PUT POST)],
        );
    }
    $ua->timeout($self->timeout);
    $ua->env_proxy;

    return $ua;
}

=head1 LICENSE

This library is free software and may be distributed under the same terms as
Perl itself. See L<http://dev.perl.org/licenses/>.


=head1 TESTING

Tests against a Streamtools server are only performed if the environment
variable LIVE_STREAMTOOLS_TESTS is set to the desired Streamtools instance's
URL (e.g., LIVE_STREAMTOOLS_TESTS=http://localhost:7070) - if it happens to
point to something other than a Streamtools server, these tests will fail.


=head1 AUTHOR

Pedro Figueiredo <pfig@me.com>


=head1 ACKNOWLEDGEMENTS

=over

=item * The Streamtools developers for a wonderful tool, in particular Jacqui
Maher and Eric Buth, who not only introduced me to Streamtools, but were kind
and patient enough to explain things and listen to my crazy ideas.

=back

=cut

1;
