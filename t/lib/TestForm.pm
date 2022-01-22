package TestForm;

use v5.10;
use strict;
use warnings;

use Form::Tiny plugins => [qw(Diva)];

form_field 'shown' => (
	data => {type => 'text'},
);

field_validator '--text-must-be-short--' => sub {
	return length pop() < 5;
};

field_validator '--text-must-be-very-short--' => sub {
	return length pop() < 2;
};

form_field 'shown_no_label' => (
	data => {type => 'email', l => undef},
);

form_field 'not_shown';

form_field 'manual_hidden' => (
	data => {type => 'hidden'},
);

1;
