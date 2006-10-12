#!/usr/bin/perl
# example.pl 
# Copyright (c) 2006 Jonathan Rockway <jrockway@cpan.org>

use File::Attributes qw(set_attribute get_attributes);
use File::Attributes::Recursive qw(:all);
use Directory::Scratch;

use strict;
use warnings;

=for you

First, let's make a directory hierarchy.

=cut

my $tmp  = Directory::Scratch->new;
my $quux = $tmp->touch('foo/bar/baz/quux');
print "** Note, this program is literate!  View the source for details.\n";

print "Created $quux\n";

=for you

Now we have:

   foo
   foo/bar
   foo/bar/baz
   foo/bar/baz/quux

So let's set an attribute on C<foo/bar> and watch it apply automagically
to C<foo/bar/baz/quux>.

=cut

set_attribute($tmp->exists('foo/bar'), 'foo', 'bar');
set_attribute($tmp->exists('foo/bar'), 'bar', 'baz');

print "\nAttributes on foo/bar:\n";
my %attrs = get_attributes($tmp->exists('foo/bar'));
foreach (keys %attrs) {
    print "   $_ -> $attrs{$_}\n";
}

set_attribute($quux, 'quux', q[that's me]);

print "\nAttributes on foo/bar/baz/quux:\n";
%attrs = get_attributes($quux, $tmp);
foreach (keys %attrs) {
    print "   $_ -> $attrs{$_}\n";
}

print "\nRecursive attributes on foo/bar/baz/quux:\n";
%attrs = get_attributes_recursively($quux, $tmp);
foreach (keys %attrs) {
    print "   $_ -> $attrs{$_}\n";
}

=for you

I hope this makes sense.  See the docs for more information.

=cut
