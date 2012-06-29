package Dist::Zilla::Plugin::HelpWanted;
BEGIN {
  $Dist::Zilla::Plugin::HelpWanted::AUTHORITY = 'cpan:YANICK';
}
{
  $Dist::Zilla::Plugin::HelpWanted::VERSION = '0.1.0';
}
# ABSTRACT: insert 'Help Wanted' information in the distribution's META


use strict;
use warnings;

use Moose;

with qw/
    Dist::Zilla::Role::Plugin
    Dist::Zilla::Role::InstallTool
/;

my @positions = qw/ maintainer co-maintainer coder translator documentation /;

has [ @positions ] => (
    is => 'ro',
    isa => 'Bool',
    default => 0,
);

sub setup_installer {
    my $self = shift;

    my @open_positions = grep { $self->$_ } @positions
        or return;

    $self->zilla->distmeta->{x_help_wanted} = \@open_positions;
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;

__END__
=pod

=head1 NAME

Dist::Zilla::Plugin::HelpWanted - insert 'Help Wanted' information in the distribution's META

=head1 VERSION

version 0.1.0

=head1 SYNOPSIS

In dist.ini:

    [HelpWanted]
    maintainer    = 1
    co-maintainer = 1
    coder         = 1
    translator    = 1
    documentation = 1

=head1 DESCRIPTION

C<Dist::Zilla::Plugin::HelpWanted> adds an
C<x_help_wanted> field in the META information of the 
distribution.

=head1 CONFIGURATION OPTIONS

Position that are passed to the plugin with a C<true> value are added
to the I<help wanted> list.

The list of possible positions is:

=over

=item maintainer    

=item co-maintainer

=item coder       

=item translator 

=item documentation

=back

=head1 AUTHOR

Yanick Champoux <yanick@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Yanick Champoux.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

