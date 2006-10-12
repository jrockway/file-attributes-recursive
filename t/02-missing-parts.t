#!/usr/bin/perl
# 02-missing-parts.t 
# Copyright (c) 2006 Jonathan Rockway <jrockway@cpan.org>

use Test::More tests => 5;
use Directory::Scratch;
use File::Attributes qw(set_attribute get_attribute);
use File::Attributes::Recursive qw(:all);

my $tmp = Directory::Scratch->new;
my $top = $tmp->base;
my $a = $tmp->mkdir('a');
my $b = $tmp->mkdir('a/b');
my $c = $tmp->mkdir('a/b/c');
my $d = $tmp->touch('a/b/c/d');
ok(-e $d, 'files created OK');

set_attribute($a, 'a' => 'yes');

my $result;
eval {
    $result = get_attribute_recursively($a, "$top", 'a');
};
ok(!$@, 'no errors');
is($result, 'yes', 'worked');

eval {
    $result = get_attribute_recursively($a, "$top", 'b');
};
ok(!$@, 'no errors');
is($result, undef, 'worked');
