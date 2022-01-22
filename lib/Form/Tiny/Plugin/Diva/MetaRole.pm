package Form::Tiny::Plugin::Diva::MetaRole;

use v5.10;
use strict;
use warnings;

our $VERSION = '1.00';

use Moo::Role;

has 'diva_config' => (
	is => 'ro',
	writer => 'set_diva_config',
	default => sub {
		return {
			id_base => 'form-field-',
			label_class => 'form-label',
			input_class => 'form-control',
			error_class => 'invalid-feedback',
		};
	},
);

sub add_diva_config
{
	my ($self, %config) = @_;

	for my $key (keys %config) {
		$self->diva_config->{$key} = $config{$key};
	}

	return;
}

after 'inherit_from' => sub {
	my ($self, $parent) = @_;

	if ($parent->DOES('Form::Tiny::Plugin::Diva::MetaRole')) {
			$self->set_diva_config({%{$parent->diva_config}, %{$self->diva_config}});
	}
};

1;

