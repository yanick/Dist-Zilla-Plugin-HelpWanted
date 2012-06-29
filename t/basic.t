use strict;
use warnings;

use Test::More tests => 1;

use Test::DZil;
use Dist::Zilla::Plugin::MetaYAML;
use JSON::Any;

my $dist_ini = dist_ini({
    name     => 'DZT-Sample',
    abstract => 'Sample DZ Dist',
    author   => 'E. Xavier Ample <example@example.org>',
    license  => 'Perl_5',
    copyright_holder => 'E. Xavier Ample',
    version => '1.0.0',
}, qw/
    GatherDir
    MetaJSON
    FakeRelease
/,
    [ 'HelpWanted' => {
        positions => 'maintainer co-maintainer documentation coder translator tester',
    } ],
);

my $tzil = Builder->from_config(
    { dist_root => 'corpus' },
    { add_files => {
        'source/dist.ini' => $dist_ini
    },
}
);

$tzil->build;

my $meta = JSON::Any->new->decode( $tzil->slurp_file('build/META.json'));

is_deeply $meta->{x_help_wanted} => [
qw/ maintainer co-maintainer coder translator documentation tester /
];

