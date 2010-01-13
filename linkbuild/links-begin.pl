#!/usr/bin/perl -w
use strict;

my @links;

my $tag = '';
while (<>) {
    chomp;
    s/  *$//;
    next unless $_;
    if (/^[^\s]+/) {
	$tag = $_;
    } else {
	m|href=([^>]*)>(.*?)</a>(.*)|;
	my($link, $linktext, $comment) = ($1, $2, $3);
	$link =~ s/^['"]//;
	$link =~ s/['"]$//;
	if (defined $link and defined $linktext) {
	    print "$tag\t$link\n$linktext\n";
	    print "$comment\n" if $comment;
	    print "\n";
	} else {
	    print STDERR "Bogus line $.: '$_'\n";
	}
    }
}
