package Data::HTML::A;

use strict;
use warnings;

use Error::Pure qw(err);
use List::Util qw(none);
use Mo qw(build is);
use Readonly;

Readonly::Array our @DATA_TYPES => qw(plain tags);

our $VERSION = 0.01;

has css_class => (
	is => 'ro',
);

has data => (
	default => [],
	ro => 1,
);

has data_type => (
	ro => 1,
);

has url => (
	is => 'ro',
);

sub BUILD {
	my $self = shift;

	# Check data type.
	if (! defined $self->{'data_type'}) {
		$self->{'data_type'} = 'plain';
	}
	if (none { $self->{'data_type'} eq $_ } @DATA_TYPES) {
		err "Parameter 'data_type' has bad value.";
	}

	return;
}

1;

__END__

=pod

=encoding utf8

=head1 NAME

Data::HTML::A - Data object for HTML a element.

=head1 SYNOPSIS

 use Data::HTML::A;

 my $obj = Data::HTML::A->new(%params);
 my $css_class = $obj->css_class;
 my $data = $obj->data;
 my $data_type = $obj->data_type;
 my $url = $obj->url;

=head1 METHODS

=head2 C<new>

 my $obj = Data::HTML::A->new(%params);

Constructor.

Returns instance of object.

=over 8

=item * C<css_class>

Form CSS class.

Default value is undef.

=item * C<data>

Button data content. It's reference to array.
Data type of data is described in 'data_type' parameter.

Default value is [].

=item * C<data_type>

Button data type for content.

Possible value are: plain tags

Default value is 'plain'.

=item * C<url>

URL of link.

Default value is undef.

=back

=head2 C<css_class>

 my $css_class = $obj->css_class;

Get CSS class for form.

Returns string.

=head2 C<data>

 my $data = $obj->data;

Get data inside button element.

Returns reference to array.

=head2 C<data_type>

 my $data_type = $obj->data_type;

Get button data type.

Returns string.

=head2 C<url>

 my $url = $obj->url;

Get URL of link.

Returns string.

=head1 ERRORS

 new():
         Parameter 'data_type' has bad value.

=head1 EXAMPLE1

=for comment filename=link.pl

 use strict;
 use warnings;

 use Data::HTML::A;

 my $obj = Data::HTML::A->new(
         'css_class' => 'link',
         'data' => 'Michal Josef Spacek homepage',
         'url' => 'https://skim.cz',
 );

 # Print out.
 print 'CSS class: '.$obj->css_class."\n";
 print 'Data: '.$obj->data."\n";
 print 'Data type: '.$obj->data_type."\n";
 print 'URL: '.$obj->url."\n";

 # Output:
 # CSS class: link
 # Data: Michal Josef Spacek homepage
 # Data type: plain
 # URL: https://skim.cz

=head1 EXAMPLE2

=for comment filename=link_tags.pl

 use strict;
 use warnings;

 use Data::HTML::A;
 use Tags::Output::Raw;

 my $obj = Data::HTML::A->new(
         'css_class' => 'link',
         # Tags(3pm) structure.
         'data' => [
                 ['b', 'span'],
                 ['a', 'class', 'span-link'],
                 ['d', 'Link'],
                 ['e', 'span'],
         ],
         'data_type' => 'tags',
         'url' => 'https://skim.cz',
 );

 my $tags = Tags::Output::Raw->new;

 # Serialize data to output.
 $tags->put(@{$obj->data});
 my $data = $tags->flush(1);

 # Print out.
 print 'CSS class: '.$obj->css_class."\n";
 print 'Data (serialized): '.$data."\n";
 print 'Data type: '.$obj->data_type."\n";
 print 'URL: '.$obj->url."\n";

 # Output:
 # CSS class: link
 # Data (serialized): <span class="span-link">Link</span>
 # Data type: tags
 # URL: https://skim.cz

=head1 DEPENDENCIES

L<Error::Pure>,
L<List::Util>,
L<Mo>,
L<Readonly>.

=head1 REPOSITORY

L<https://github.com/michal-josef-spacek/Data-HTML-A>

=head1 AUTHOR

Michal Josef Špaček L<mailto:skim@cpan.org>

L<http://skim.cz>

=head1 LICENSE AND COPYRIGHT

© 2022-2023 Michal Josef Špaček

BSD 2-Clause License

=head1 VERSION

0.01

=cut
