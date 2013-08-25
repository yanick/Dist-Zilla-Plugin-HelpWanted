
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  "build_requires" => {
    "Dist::Zilla::Plugin::MetaYAML" => 0,
    "File::Spec" => 0,
    "IO::Handle" => 0,
    "IPC::Open3" => 0,
    "JSON::Any" => 0,
    "Module::Build" => "0.3601",
    "Test::DZil" => 0,
    "Test::More" => "0.96"
  },
  "configure_requires" => {
    "Module::Build" => "0.3601"
  },
  "dist_abstract" => "insert 'Help Wanted' information in the distribution's META",
  "dist_author" => [
    "Yanick Champoux <yanick\@cpan.org>"
  ],
  "dist_name" => "Dist-Zilla-Plugin-HelpWanted",
  "dist_version" => "0.3.0",
  "license" => "perl",
  "module_name" => "Dist::Zilla::Plugin::HelpWanted",
  "recommends" => {},
  "recursive_test_files" => 1,
  "requires" => {
    "Dist::Zilla::Role::InstallTool" => 0,
    "Dist::Zilla::Role::Plugin" => 0,
    "List::MoreUtils" => 0,
    "Moose" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "script_files" => []
);


my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
