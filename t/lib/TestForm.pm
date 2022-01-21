package TestForm;

use v5.10;
use strict;
use warnings;

use Form::Tiny -plugins => [qw(Diva)];

form_field 'shown' => (
	data => {type => 'text'},
);

form_field 'shown_no_label' => (
	data => {type => 'text', l => undef},
);

form_field 'not_shown';

1;
