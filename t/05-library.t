#!perl

use warnings;
use strict;

use lib 'lib';

use Test::More tests => 6;
use Test::Exception;
use Test::LWP::UserAgent;

use Streamtools;
use Streamtools::API::Streamtools::Library;

my $ua = Test::LWP::UserAgent->new;
{
    local $/ = undef;
    $ua->map_response(
        qr{localhost:7070/library},
        HTTP::Response->new('200', 'OK',
            ['Content-Type' => 'application/json'],
            <DATA>));
}


my $st = Streamtools->new(server => 'localhost', port => 7070, _ua => $ua);
my $l = Streamtools::API::Streamtools::Library->new(_st => $st);
isa_ok($l, 'Streamtools::API::BaseRequest');
isa_ok($l, 'Streamtools::API::Streamtools::Library');

ok($l->method eq 'GET', 'Method is correctly set');
ok($l->path eq 'library', 'Path is correctly set');

my $library = $st->library->request;
ok(keys %$library == 56, 'Correct number of blocks fetched');
ok(exists $library->{'bang'}, 'Correct library structure (probably)');

__DATA__
{
  "bang": {
    "Desc": "sends a 'bang' request to blocks connected to it, triggered by clicking the query endpoint",
    "InRoutes": [],
    "OutRoutes": [
      "out"
    ],
    "QueryParamRoutes": [],
    "QueryRoutes": [
      "query"
    ],
    "Type": "Core"
  },
  "cache": {
    "Desc": "stores a set of dictionary values queryable on key",
    "InRoutes": [
      "rule",
      "in",
      "lookup"
    ],
    "OutRoutes": [
      "out"
    ],
    "QueryParamRoutes": [
      "lookup"
    ],
    "QueryRoutes": [
      "rule",
      "keys",
      "values",
      "dump"
    ],
    "Type": "Core"
  },
  "categorical": {
    "Desc": "draws a random number from a Categorical distribution when polled",
    "InRoutes": [
      "poll",
      "rule"
    ],
    "OutRoutes": [
      "out"
    ],
    "QueryParamRoutes": [],
    "QueryRoutes": [
      "rule"
    ],
    "Type": "Stats"
  },
  "count": {
    "Desc": "counts the number of messages seen over a specified Window",
    "InRoutes": [
      "poll",
      "clear",
      "in",
      "rule"
    ],
    "OutRoutes": [
      "out"
    ],
    "QueryParamRoutes": [],
    "QueryRoutes": [
      "rule",
      "count"
    ],
    "Type": "Stats"
  },
  "dedupe": {
    "Desc": "stores a set of messages as specified by Path, emiting only those it hasn't seen before.",
    "InRoutes": [
      "in",
      "rule"
    ],
    "OutRoutes": [
      "out"
    ],
    "QueryParamRoutes": [],
    "QueryRoutes": [
      "rule"
    ],
    "Type": "Core"
  },
  "exponential": {
    "Desc": "draws a random number from a Exponential distribution when polled",
    "InRoutes": [
      "rule",
      "poll"
    ],
    "OutRoutes": [
      "out"
    ],
    "QueryParamRoutes": [],
    "QueryRoutes": [
      "rule"
    ],
    "Type": "Stats"
  },
  "fft": {
    "Desc": "",
    "InRoutes": [
      "in",
      "rule"
    ],
    "OutRoutes": [
      "out"
    ],
    "QueryParamRoutes": [],
    "QueryRoutes": [
      "rule"
    ],
    "Type": "Stats"
  },
  "filter": {
    "Desc": "selectively emits messages based on criteria defined in this block's rule",
    "InRoutes": [
      "in",
      "rule"
    ],
    "OutRoutes": [
      "out"
    ],
    "QueryParamRoutes": [],
    "QueryRoutes": [
      "rule"
    ],
    "Type": "Core"
  },
  "fromHTTPGetRequest": {
    "Desc": "emits a query route that must be responded to using another block",
    "InRoutes": [],
    "OutRoutes": [
      "out"
    ],
    "QueryParamRoutes": [],
    "QueryRoutes": [
      "query"
    ],
    "Type": "Network I/O"
  },
  "fromamqp": {
    "Desc": "reads from a topic on AMQP broker as specified in this block's rules",
    "InRoutes": [
      "rule"
    ],
    "OutRoutes": [
      "out"
    ],
    "QueryParamRoutes": [],
    "QueryRoutes": [
      "rule"
    ],
    "Type": "Queue I/O"
  },
  "fromemail": {
    "Desc": "",
    "InRoutes": [
      "rule"
    ],
    "OutRoutes": [
      "out"
    ],
    "QueryParamRoutes": [],
    "QueryRoutes": [
      "rule"
    ],
    "Type": "Network I/O"
  },
  "fromfile": {
    "Desc": "reads in a file specified by the block's rule, emitting a message for each line",
    "InRoutes": [
      "in",
      "rule",
      "poll"
    ],
    "OutRoutes": [
      "out"
    ],
    "QueryParamRoutes": [],
    "QueryRoutes": [
      "rule"
    ],
    "Type": "Data Stores"
  },
  "fromhttpstream": {
    "Desc": "emits new data appearing on a long-lived http stream as new messages in streamtools",
    "InRoutes": [
      "rule"
    ],
    "OutRoutes": [
      "out"
    ],
    "QueryParamRoutes": [],
    "QueryRoutes": [
      "rule"
    ],
    "Type": "Network I/O"
  },
  "fromnsq": {
    "Desc": "reads from a topic in NSQ as specified in this block's rule",
    "InRoutes": [
      "rule"
    ],
    "OutRoutes": [
      "out"
    ],
    "QueryParamRoutes": [],
    "QueryRoutes": [
      "rule"
    ],
    "Type": "Queue I/O"
  },
  "frompost": {
    "Desc": "emits any message that is POSTed to its IN route",
    "InRoutes": [
      "in"
    ],
    "OutRoutes": [
      "out"
    ],
    "QueryParamRoutes": [],
    "QueryRoutes": [],
    "Type": "Network I/O"
  },
  "fromsqs": {
    "Desc": "reads from Amazon's SQS, emitting each line of JSON as a separate message",
    "InRoutes": [
      "rule"
    ],
    "OutRoutes": [
      "out"
    ],
    "QueryParamRoutes": [],
    "QueryRoutes": [
      "rule"
    ],
    "Type": "Queue I/O"
  },
  "fromudp": {
    "Desc": "listens for messages sent over UDP, emitting each into streamtools",
    "InRoutes": [
      "rule"
    ],
    "OutRoutes": [
      "out"
    ],
    "QueryParamRoutes": [],
    "QueryRoutes": [
      "rule"
    ],
    "Type": "Network I/O"
  },
  "fromwebsocket": {
    "Desc": "connects to an existing websocket, emitting each message heard from the websocket",
    "InRoutes": [
      "rule"
    ],
    "OutRoutes": [
      "out"
    ],
    "QueryParamRoutes": [],
    "QueryRoutes": [
      "rule"
    ],
    "Type": "Network I/O"
  },
  "gaussian": {
    "Desc": "draws a random number from the Gaussian distribution when polled",
    "InRoutes": [
      "rule",
      "poll"
    ],
    "OutRoutes": [
      "out"
    ],
    "QueryParamRoutes": [],
    "QueryRoutes": [
      "rule"
    ],
    "Type": "Stats"
  },
  "gethttp": {
    "Desc": "makes an HTTP GET request to a URL you specify in the inbound message",
    "InRoutes": [
      "rule",
      "in"
    ],
    "OutRoutes": [
      "out"
    ],
    "QueryParamRoutes": [],
    "QueryRoutes": [
      "rule"
    ],
    "Type": "Network I/O"
  },
  "histogram": {
    "Desc": "builds a non-stationary histogram of inbound messages for a specified path",
    "InRoutes": [
      "in",
      "rule",
      "poll"
    ],
    "OutRoutes": [
      "out"
    ],
    "QueryParamRoutes": [],
    "QueryRoutes": [
      "rule",
      "histogram"
    ],
    "Type": "Stats"
  },
  "javascript": {
    "Desc": "transform messages with javascript (includes underscore.js)",
    "InRoutes": [
      "in",
      "rule"
    ],
    "OutRoutes": [
      "out"
    ],
    "QueryParamRoutes": [],
    "QueryRoutes": [
      "rule"
    ],
    "Type": "Core"
  },
  "join": {
    "Desc": "joins two streams together, emitting the joined message once it's been seen on both inputs",
    "InRoutes": [
      "inB",
      "clear",
      "inA"
    ],
    "OutRoutes": [
      "out"
    ],
    "QueryParamRoutes": [],
    "QueryRoutes": [],
    "Type": "Core"
  },
  "kullbackleibler": {
    "Desc": "",
    "InRoutes": [
      "in",
      "rule"
    ],
    "OutRoutes": [
      "out"
    ],
    "QueryParamRoutes": [],
    "QueryRoutes": [
      "rule"
    ],
    "Type": "Stats"
  },
  "learn": {
    "Desc": "applies stochastic gradient descent to learn the relationship between features and response",
    "InRoutes": [
      "poll",
      "in",
      "rule"
    ],
    "OutRoutes": [
      "out"
    ],
    "QueryParamRoutes": [],
    "QueryRoutes": [
      "rule"
    ],
    "Type": "Stats"
  },
  "linearModel": {
    "Desc": "Emits the linear combination of paramters and features",
    "InRoutes": [
      "rule",
      "in"
    ],
    "OutRoutes": [
      "out"
    ],
    "QueryParamRoutes": [],
    "QueryRoutes": [
      "rule"
    ],
    "Type": "Stats"
  },
  "logisticModel": {
    "Desc": "returns 1 or 0 depending on the model parameters and feature values",
    "InRoutes": [
      "rule",
      "in"
    ],
    "OutRoutes": [
      "out"
    ],
    "QueryParamRoutes": [],
    "QueryRoutes": [
      "rule"
    ],
    "Type": "Stats"
  },
  "map": {
    "Desc": "maps inbound data onto outbound data, providing a way to restructure or rename elements",
    "InRoutes": [
      "in",
      "rule"
    ],
    "OutRoutes": [
      "out"
    ],
    "QueryParamRoutes": [],
    "QueryRoutes": [
      "rule"
    ],
    "Type": "Core"
  },
  "mask": {
    "Desc": "emits a subset of the inbound message by specifying the desired JSON output structure in this block's rule",
    "InRoutes": [
      "in",
      "rule"
    ],
    "OutRoutes": [
      "out"
    ],
    "QueryParamRoutes": [],
    "QueryRoutes": [
      "rule"
    ],
    "Type": "Core"
  },
  "movingaverage": {
    "Desc": "performs a moving average of the values specified by the Path over the duration of the Window",
    "InRoutes": [
      "in",
      "rule",
      "poll"
    ],
    "OutRoutes": [
      "out"
    ],
    "QueryParamRoutes": [],
    "QueryRoutes": [
      "rule",
      "average"
    ],
    "Type": "Stats"
  },
  "packbycount": {
    "Desc": "Packs incoming messages into array. When the array is filled, it is emitted.",
    "InRoutes": [
      "in",
      "rule",
      "clear",
      "flush"
    ],
    "OutRoutes": [
      "out"
    ],
    "QueryParamRoutes": [],
    "QueryRoutes": [
      "rule"
    ],
    "Type": "Core"
  },
  "packbyinterval": {
    "Desc": "Packs incoming messages into array. Arrays are emitted and emptied on an interval.",
    "InRoutes": [
      "in",
      "rule",
      "clear",
      "flush"
    ],
    "OutRoutes": [
      "out"
    ],
    "QueryParamRoutes": [],
    "QueryRoutes": [
      "rule"
    ],
    "Type": "Core"
  },
  "packbyvalue": {
    "Desc": "groups messages together based on a common value, similar to 'group-by' in other languages",
    "InRoutes": [
      "in",
      "rule"
    ],
    "OutRoutes": [
      "out"
    ],
    "QueryParamRoutes": [],
    "QueryRoutes": [
      "rule"
    ],
    "Type": "Core"
  },
  "parsecsv": {
    "Desc": "converts incoming CSV messages to JSON for use in streamtools",
    "InRoutes": [
      "in",
      "rule",
      "poll"
    ],
    "OutRoutes": [
      "out"
    ],
    "QueryParamRoutes": [],
    "QueryRoutes": [
      "rule"
    ],
    "Type": "Parsers"
  },
  "parsexml": {
    "Desc": "converts incoming XML messages to JSON for use in streamtools",
    "InRoutes": [
      "rule",
      "in"
    ],
    "OutRoutes": [
      "out"
    ],
    "QueryParamRoutes": [],
    "QueryRoutes": [
      "rule"
    ],
    "Type": "Parsers"
  },
  "poisson": {
    "Desc": "draws a random number from a Poisson distribution when polled",
    "InRoutes": [
      "rule",
      "poll"
    ],
    "OutRoutes": [
      "out"
    ],
    "QueryParamRoutes": [],
    "QueryRoutes": [
      "rule"
    ],
    "Type": "Stats"
  },
  "queue": {
    "Desc": "FIFO queue allowing push & pop on streams plus popping from a query",
    "InRoutes": [
      "pop",
      "push"
    ],
    "OutRoutes": [
      "out"
    ],
    "QueryParamRoutes": [],
    "QueryRoutes": [
      "pop",
      "peek"
    ],
    "Type": "Core"
  },
  "redis": {
    "Desc": "sends arbitrary commands to redis",
    "InRoutes": [
      "rule",
      "in"
    ],
    "OutRoutes": [
      "out"
    ],
    "QueryParamRoutes": [],
    "QueryRoutes": [
      "rule"
    ],
    "Type": "Data Stores"
  },
  "set": {
    "Desc": "add, ismember and cardinality routes on a stored set of values",
    "InRoutes": [
      "add",
      "isMember",
      "rule"
    ],
    "OutRoutes": [
      "out"
    ],
    "QueryParamRoutes": [],
    "QueryRoutes": [
      "cardinality",
      "rule"
    ],
    "Type": "Core"
  },
  "sync": {
    "Desc": "takes an disordered stream and creates a properly timed, ordered stream at the expense of introducing a lag",
    "InRoutes": [
      "in",
      "rule"
    ],
    "OutRoutes": [
      "out"
    ],
    "QueryParamRoutes": [],
    "QueryRoutes": [
      "rule"
    ],
    "Type": "Core"
  },
  "ticker": {
    "Desc": "emits the time at an interval specified by the block's rule",
    "InRoutes": [
      "rule"
    ],
    "OutRoutes": [
      "out"
    ],
    "QueryParamRoutes": [],
    "QueryRoutes": [
      "rule"
    ],
    "Type": "Core"
  },
  "timeseries": {
    "Desc": "stores an array of values for a specified Path along with timestamps",
    "InRoutes": [
      "in",
      "rule",
      "poll"
    ],
    "OutRoutes": [
      "out"
    ],
    "QueryParamRoutes": [],
    "QueryRoutes": [
      "timeseries",
      "rule"
    ],
    "Type": "Stats"
  },
  "toHTTPGetRequest": {
    "Desc": "responds to a Get requets's response channel",
    "InRoutes": [
      "in",
      "rule"
    ],
    "OutRoutes": [],
    "QueryParamRoutes": [],
    "QueryRoutes": [
      "rule"
    ],
    "Type": "Network I/O"
  },
  "toamqp": {
    "Desc": "send messages to an exchange on an AMQP broker",
    "InRoutes": [
      "in",
      "rule"
    ],
    "OutRoutes": [],
    "QueryParamRoutes": [],
    "QueryRoutes": [
      "rule"
    ],
    "Type": "Queue I/O"
  },
  "tobeanstalkd": {
    "Desc": "sends jobs to beanstalkd tube",
    "InRoutes": [
      "in",
      "rule"
    ],
    "OutRoutes": [],
    "QueryParamRoutes": [],
    "QueryRoutes": [
      "rule"
    ],
    "Type": "Queue I/O"
  },
  "toelasticsearch": {
    "Desc": "sends messages as JSON to a specified index and type in Elasticsearch",
    "InRoutes": [
      "in",
      "rule"
    ],
    "OutRoutes": [],
    "QueryParamRoutes": [],
    "QueryRoutes": [
      "rule"
    ],
    "Type": "Data Stores"
  },
  "toemail": {
    "Desc": "",
    "InRoutes": [
      "in",
      "rule"
    ],
    "OutRoutes": [],
    "QueryParamRoutes": [],
    "QueryRoutes": [
      "rule"
    ],
    "Type": "Network I/O"
  },
  "tofile": {
    "Desc": "writes messages, separated by newlines, to a file on the local filesystem",
    "InRoutes": [
      "in",
      "rule"
    ],
    "OutRoutes": [
      "out"
    ],
    "QueryParamRoutes": [],
    "QueryRoutes": [
      "rule"
    ],
    "Type": "Data Stores"
  },
  "toggle": {
    "Desc": "emits a 'state' boolean value, toggling true/false on each hit",
    "InRoutes": [
      "in"
    ],
    "OutRoutes": [
      "out"
    ],
    "QueryParamRoutes": [],
    "QueryRoutes": [],
    "Type": "Core"
  },
  "tolog": {
    "Desc": "quick way to view data in your streams; logs both to STDOUT and the GUI",
    "InRoutes": [
      "in"
    ],
    "OutRoutes": [],
    "QueryParamRoutes": [],
    "QueryRoutes": [],
    "Type": "Core"
  },
  "tomongodb": {
    "Desc": "sends messages to MongoDB, optionally in batches",
    "InRoutes": [
      "rule",
      "in"
    ],
    "OutRoutes": [],
    "QueryParamRoutes": [],
    "QueryRoutes": [
      "rule"
    ],
    "Type": "Data Stores"
  },
  "tonsq": {
    "Desc": "send messages to an NSQ topic",
    "InRoutes": [
      "rule",
      "in"
    ],
    "OutRoutes": [],
    "QueryParamRoutes": [],
    "QueryRoutes": [
      "rule"
    ],
    "Type": "Queue I/O"
  },
  "tonsqmulti": {
    "Desc": "sends messages to an NSQ topic in batches",
    "InRoutes": [
      "in",
      "rule"
    ],
    "OutRoutes": [],
    "QueryParamRoutes": [],
    "QueryRoutes": [
      "rule"
    ],
    "Type": "Queue I/O"
  },
  "unpack": {
    "Desc": "splits an array of objects from incoming data, emitting each element as a separate message",
    "InRoutes": [
      "in",
      "rule"
    ],
    "OutRoutes": [
      "out"
    ],
    "QueryParamRoutes": [],
    "QueryRoutes": [
      "rule"
    ],
    "Type": "Core"
  },
  "webRequest": {
    "Desc": "Makes requests to a given URL with specified HTTP method.",
    "InRoutes": [
      "in",
      "rule"
    ],
    "OutRoutes": [
      "out"
    ],
    "QueryParamRoutes": [],
    "QueryRoutes": [
      "rule"
    ],
    "Type": "Network I/O"
  },
  "zipf": {
    "Desc": "draws a random number from a Zipf-Mandelbrot distribution when polled",
    "InRoutes": [
      "poll",
      "rule"
    ],
    "OutRoutes": [
      "out"
    ],
    "QueryParamRoutes": [],
    "QueryRoutes": [
      "rule"
    ],
    "Type": "Stats"
  }
}
