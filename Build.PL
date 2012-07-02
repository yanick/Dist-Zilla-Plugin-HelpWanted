
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  "build_requires" => {
    "Carp" => 0,
    "Dist::Zilla::Plugin::MetaYAML" => 0,
    "File::Find" => 0,
    "File::Temp" => 0,
    "JSON::Any" => 0,
    "Module::Build" => "0.3601",
    "Scalar::Util" => 0,
    "Test::DZil" => 0,
    "Test::More" => "0.94",
    "perl" => "5.004"
  },
  "configure_requires" => {
    "Module::Build" => "0.3601"
  },
  "dist_abstract" => "insert 'Help Wanted' information in the distribution's META",
  "dist_author" => [
    "Yanick Champoux <yanick\@cpan.org>"
  ],
  "dist_name" => "Dist-Zilla-Plugin-HelpWanted",
  "dist_version" => "0.2.1",
  "license" => "perl",
  "module_name" => "Dist::Zilla::Plugin::HelpWanted",
  "recommends" => {},
  "recursive_test_files" => 1,
  "requires" => {
    "Dist::Zilla::Role::InstallTool" => 0,
    "Dist::Zilla::Role::Plugin" => 0,
    "Moose" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "script_files" => []
);


my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
