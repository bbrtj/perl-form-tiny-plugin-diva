package Form::Tiny::Plugin::Diva::MetaRole;

use v5.10;
use strict;
use warnings;

our $VERSION = '1.00';

use Moo::Role;

has 'diva_config' => (
	is => 'ro',
	default => sub {
		return {
			label_class => 'col-sm-12 form-label',
			input_class => 'form-control',
			error_class => 'invalid-feedback',
		};
	},
);

sub add_diva_config
{
	my ($self, $key, $value) = @_;

	$self->diva_config->{$key} = $value;
	return;
}

1;

