use v5.10;
use strict;
use warnings;
use Test::More;

{

	package TestForm;

	use Form::Tiny -plugins => [qw(Diva)];

	form_field 'shown' => (
		data => {type => 'text'},
	);

	form_field 'shown_no_label' => (
		data => {type => 'text', l => undef},
	);

	form_field 'not_shown' => (
	);
}

my $form = TestForm->new;
can_ok $form, 'diva';

subtest 'empty_diva' => sub {
	my $data = $form->diva->generate;
	is scalar @$data, 2, 'field with no data section not returned';

	like $data->[0]{label}, qr{>Shown</label>}i, 'correct label generated';
	like $data->[0]{input}, qr{name="shown"}, 'correct name generated';
	like $data->[0]{input}, qr{type="text"}, 'correct type generated';

	is $data->[1]{label}, '', 'correct label generated';
	like $data->[1]{input}, qr{name="shown_no_label"}, 'correct name generated';
	like $data->[1]{input}, qr{type="text"}, 'correct type generated';
};

done_testing;
