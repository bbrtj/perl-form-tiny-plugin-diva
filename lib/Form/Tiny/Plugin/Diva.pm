package Form::Tiny::Plugin::Diva;

use v5.10;
use strict;
use warnings;

our $VERSION = '1.00';

use Form::Tiny::Plugin::Diva::Adapter;
use Form::Tiny::Plugin::Diva::MetaRole;

use parent 'Form::Tiny::Plugin';

sub plugin
{
	my ($self, $caller, $context) = @_;

	return {
		subs => {
			diva_config => sub {
				$$context = undef;
				$caller->form_meta->add_diva_config(@_);
			},
		},

		roles => [__PACKAGE__],
		meta_roles => ['Form::Tiny::Plugin::Diva::MetaRole'],
	};
}

use Scalar::Util qw(weaken);
use Moo::Role;

has 'diva' => (
	is => 'ro',
	builder => '_build_diva',
	lazy => 1,
	init_arg => undef,
);

sub _build_diva
{
	my ($self) = @_;
	my %config = %{$self->form_meta->diva_config};

	my @fields;
	my @hidden;

	for my $field (@{$self->field_defs}) {
		my %field_data = (
			hidden => !defined $field->data,
			%{$field->data // {}},
			name => $field->name,
		);

		if ($field->has_default && !exists $field_data{d} && !exists $field_data{default}) {
			$field_data{default} = $field->default->($self);
		}

		my $push_to = $field_data{hidden} ? \@hidden : \@fields;
		push @$push_to, {%field_data, comment => \%field_data};
	}

	weaken $self;
	return Form::Tiny::Plugin::Diva::Adapter->new(
		%config,
		form => \@fields,
		hidden => \@hidden,

		form_instance => $self,
	);
}

1;

__END__

=head1 NAME

Form::Tiny::Plugin::Diva - Perl extension for blah blah blah

=head1 SYNOPSIS

 use Form::Tiny::Plugin::Diva;
 blah blah blah

=head1 DESCRIPTION

Stub documentation for Form::Tiny::Plugin::Diva, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.

=head2 EXPORT

None by default.



=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

bartosz, E<lt>bartosz@nonetE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2022 by bartosz

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.34.0 or,
at your option, any later version of Perl 5 you may have available.


=cut
