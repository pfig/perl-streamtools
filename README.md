# A Perl client library for Streamtools


## Synopsis

``` perl
  use Streamtools;

  # Connect to the Streamtools server at http://localhost:7070
  my $st = Streamtools->new(server => 'localhost', port => 7070);
```


## Description

This module provides a Perl client library for the REST API provided by
Streamtools.

From the developer blurb: "Streamtools is a graphical toolkit for dealing
with streams of data. Streamtools makes it easy to explore, analyse,
modify and learn from streams of data."

To find out more about Streamtools, have a look at
[their website](http://nytlabs.github.io/streamtools/).

