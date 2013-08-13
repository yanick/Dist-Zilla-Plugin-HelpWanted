package Dist::Zilla::Plugin::HelpWanted;
# ABSTRACT: insert 'Help Wanted' information in the distribution's META

=head1 SYNOPSIS

In dist.ini:

    [HelpWanted]
    positions = maintainer developer translator documenter tester helper

or

    [HelpWanted]
    maintainer    = 1
    developer     = 1
    translator    = 1
    documenter    = 1
    tester        = 1
    helper        = 1

=head1 DESCRIPTION

C<Dist::Zilla::Plugin::HelpWanted> adds an
C<x_help_wanted> field in the META information of the 
distribution.

=head1 CONFIGURATION OPTIONS

Position  are passed to the plugin either via the 
option C<positions>, or piecemeal (see example above).

The list of possible positions (inspired by
L<DOAP|https://github.com/edumbill/doap/wiki>) is:

=over

=item    maintainer

=item    developer

=item    translator

=item    documenter

=item    tester

=item    helper

=back

=cut

use strict;
use warnings;

use Moose;
use List::MoreUtils qw(uniq);

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
    documenter
    developer
    helper
/;

my %legacy = (
    'co-maintainer'   => 'maintainer',
    'coder'           => 'developer',
    'documentation'   => 'documenter',
);

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

    my @open_positions =
        uniq
        map { exists($legacy{$_}) ? $legacy{$_} : $_ }
        grep { $self->$_ } @positions;

    @open_positions or return;

    $self->zilla->distmeta->{x_help_wanted} = \@open_positions;
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;
