package TestFormConfigured;

use v5.10;
use strict;
use warnings;

use Form::Tiny -plugins => [qw(Diva)];

extends 'TestBaseFormConfigured';

diva_config
	'id_base' => 'myident-',
	'label_class' => 'mylabel-class',
	;

diva_config 'error_class' => 'myerror-class';

form_field 'shown' => (
	data => {type => 'text'},
);

field_validator '--text-must-be-short--' => sub {
	return length pop() < 5;
};

1;
