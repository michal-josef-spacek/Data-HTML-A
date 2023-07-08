use strict;
use warnings;

use English;
use Error::Pure::Utils qw(clean);
use Data::HTML::A;
use Test::More 'tests' => 8;
use Test::NoWarnings;

# Test.
my $obj = Data::HTML::A->new;
isa_ok($obj, 'Data::HTML::A');

# Test.
$obj = Data::HTML::A->new(
	'css_class' => 'button-nice',
	'data' => ['simple button'],
	'data_type' => 'plain',
	'url' => 'http://example.com',
);
isa_ok($obj, 'Data::HTML::A');

# Test.
$obj = Data::HTML::A->new(
	'css_class' => 'button-nice',
	'data' => [['d', 'simple button']],
	'data_type' => 'tags',
	'url' => 'http://example.com',
);
isa_ok($obj, 'Data::HTML::A');

# Test.
eval {
	Data::HTML::A->new(
		'data_type' => 'bad',
	);
};
is($EVAL_ERROR, "Parameter 'data_type' has bad value.\n",
	"Parameter 'data_type' has bad value.");
clean();

# Test.
eval {
	Data::HTML::A->new(
		'data' => 'bad',
		'data_type' => 'plain',
	);
};
is($EVAL_ERROR, "Parameter 'data' must be a array.\n",
	"Parameter 'data' must be a array.");
clean();

# Test.
eval {
	Data::HTML::A->new(
		'data' => [[]],
		'data_type' => 'plain',
	);
};
is($EVAL_ERROR, "Parameter 'data' in 'plain' mode must contain reference to array with scalars.\n",
	"Parameter 'data' in 'plain' mode must contain reference to array with scalars.");
clean();

# Test.
eval {
	Data::HTML::A->new(
		'data' => ['bad'],
		'data_type' => 'tags',
	);
};
is($EVAL_ERROR, "Parameter 'data' in 'tags' mode must contain reference to array with references to array with Tags structure.\n",
	"Parameter 'data' in 'tags' mode must contain reference to array with references to array with Tags structure.");
clean();
