package Form::Tiny::Plugin::Diva::Adapter;

use v5.10;
use strict;
use warnings;

our $VERSION = '1.00';

use parent 'Form::Diva';

sub _ftpd_tweak
{
	my ($self, $generated) = @_;

	my $error_class = $self->{error_class};
	my $errors = $self->{form_instance}->errors_hash;
	for my $field (@{$generated}) {
		my $extra_data = $field->{comment};

		my $errors_html = join '', map {
			qq|<div class="$error_class">$_</div>|
		} @{$errors->{$extra_data->{name}}};
		$field->{errors} = $errors_html;

		# TODO: https://github.com/brainbuz/form-diva/issues/6
		$field->{label} = ''
			if (exists $extra_data->{l} && !defined $extra_data->{l})
			|| (exists $extra_data->{label} && !defined $extra_data->{label});
	}

	return $generated;
}

sub generate
{
	my $self = shift;
	my $generated = $self->SUPER::generate($self->{form_instance}->input, @_);

	return $self->_ftpd_tweak($generated);
}

sub prefill
{
	my $self = shift;
	my $generated = $self->SUPER::prefill($self->{form_instance}->input, @_);

	return $self->_ftpd_tweak($generated);
}

sub datavalues
{
	my $self = shift;
	return $self->SUPER::datavalues($self->{form_instance}->input, @_);
}

1;

__END__
