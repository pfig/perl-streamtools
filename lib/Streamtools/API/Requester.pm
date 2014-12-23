use strict;
use warnings;
package Streamtools::API::Requester;

# ABSTRACT: Role for classes doing API calls.

=for test_synopsis
no strict 'vars'

=head1 SYNOPSIS

    package Streamtools::API::Megaman;
    use Moo;
    with 'Streamtools::API::Requester';

=head1 DESCRIPTION

A role all classes performing API calls must fulfil.

Not for external use.

=cut

use Moo::Role 1.006;

requires 'request';
requires 'method';
requires 'path';

1;
