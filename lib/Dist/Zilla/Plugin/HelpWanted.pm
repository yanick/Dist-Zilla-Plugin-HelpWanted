package Dist::Zilla::Plugin::HelpWanted;
# ABSTRACT: insert 'Help Wanted' information in the distribution's META

=head1 SYNOPSIS

In dist.ini:

    [HelpWanted]
    positions = maintainer co-maintainer coder translator documentation tester

or

    [HelpWanted]
    maintainer    = 1
    co-maintainer = 1
    coder         = 1
    translator    = 1
    documentation = 1
    tester        = 1
    

=head1 DESCRIPTION

C<Dist::Zilla::Plugin::HelpWanted> adds an
C<x_help_wanted> field in the META information of the 
distribution.

=head1 CONFIGURATION OPTIONS

Position  are passed to the plugin either via the 
option C<positions>, or piecemeal (see example above).

The list of possible positions is:

=over

=item    maintainer    

=item    co-maintainer

=item    coder       

=item    translator 

=item    documentation

=item    tester

=back

=cut

use strict;
use warnings;

use Moose;

with qw/
    Dist::Zilla::Role::Plugin
    Dist::Zilla::Role::InstallTool
/;

my @positions = qw/ 
    maintainer 
    co-maintainer 
    coder 
    translator 
    documentation
    tester 
/;

has [ @positions ] => (
    is => 'rw',
    isa => 'Bool',
    default => 0,
);

has 'positions' => (
    is      => 'ro',
    isa     => 'Str',
    default => '',
);

sub setup_installer {
    my $self = shift;

    for my $p ( split ' ', $self->positions ) {
        eval { $self->$p(1) } or
            die "position '$p' not recognized\n";
    }

    my @open_positions = grep { $self->$_ } @positions
                         or return;

    $self->zilla->distmeta->{x_help_wanted} = \@open_positions;
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;

__END__

=head1 SEE ALSO

=over

=item OpenHatch (L<http://openhatch.org/>) 

A non-profit site dedicated to matching prospective free software contributors with communities, tools, and education. 

=back
