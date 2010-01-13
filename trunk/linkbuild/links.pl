#!/usr/bin/perl -w
use strict;
use LWP::UserAgent;

# N. Dean Pentcheff  October 2009
# Copyright 2009 SCAMIT (All rights reserved)

# Read a text linkdb file of link information, check the links
# for existence, and create a link table for incorporation into
# a webpage frame.

# format of link database file:
#  Tag{TAB}Link{NL}Linktext[{NL}Commenttext]{NL}{NL}
# tag groups are assumed to be continuous in the file
my $linkdb  = 'links.txt';

my $linkout = 'links.html'; # target link table file
my $timeout = 5;            # linkcheck timeout in seconds
my $docheck = 1;            # if set false, fake the linkchecks

# slurp the whole input file
# (could allow us to do grouping-by-tag, instead of assuming
# a grouped input file)
print STDERR "Read in '$linkdb' link database file\n";
open(IN, $linkdb) or die("Failed opening '$linkdb': $!\n");
my $input;
while (<IN>) {
    $input .= $_;
}
close IN;

# parse it
print STDERR "Parse link data\n";
my @links;
for (split(/\n\n/, $input)) {
    s/^\s*//;
    s/\s*$//;
    my($taglink, $linktext, $comments) = split(/\n/, $_);
    my($tag, $link) = split(/\t/, $taglink);
    unless (defined $tag      && $tag     &&
	    defined $link     && $link    &&
	    defined $linktext && $linktext) {
	print STDERR "Bogus link entry:\n$_\n";
	next;
    }
    $comments =~ s/^\s*// if defined $comments;
    $comments =~ s/\s*$// if defined $comments;
    $comments = '&nbsp;' unless $comments;
    push(@links, {tag      => $tag,
		  link     => $link,
		  linktext => $linktext,
		  comments => $comments,
		 });
}

# check links
print STDERR "Checking links for freshness\n";
my $ua = LWP::UserAgent->new(timeout => $timeout);
my $count = 0;
for (@links) {
    print STDERR "Checking ", ++$count, " of ",
	scalar @links, " '", $_->{link}, "' ";
    if ($docheck) {
	# really check the links
	my $req = HTTP::Request->new(HEAD => $_->{link});
	my $res = $ua->request($req);
	$_->{status} = $res->is_success  ?  1  :  0;
    } else {
	# fake the link check for testing
	$_->{status} = rand > 0.3  ?  1  :  0;
    }
    print STDERR $_->{status}  ?  "OK\n"  :  "FAIL\n";
}

# punch it all out
print STDERR "Create output file '$linkout'\n";
open(OUT, "> $linkout")
    or die("Failed opening output file '$linkout': $!\n");
print OUT "<!-- Do not edit: automatically generated.\n" .
    "     Edit the '$linkdb' file instead!      -->\n" .
    "<span id='links'><table cellpadding='0' cellspacing='0'>\n";
my $lasttag = '';
$count = 1;
for (@links) {
    my $tag      = $_->{tag};
    my $link     = $_->{link};
    my $linktext = $_->{linktext};
    my $comments = $_->{comments};
    my $status   = $_->{status};
    # put out the tag as a row, if it's a new one
    if ($tag ne $lasttag) {
	$lasttag = $tag;
	$count = 1;
	print OUT "<tr class='linktag'>" .
	    "<td colspan='2'>$tag</td></tr>\n";
    }
    # put out the link information row
    my $evenodd = $count % 2 ? 'even' : 'odd';
    if ($status) {
	++$count;   # only count OK links for greenbarring
    } else {
	$evenodd = 'fail';
    }
    my $ok = $status  ?  ""  :  "class='fail'";
    print OUT "<tr class='$evenodd'>" .
	"<td class='link'><a $ok href='$link'>$linktext</a></td>" .
	"<td class='comment'>$comments</td></tr>\n";
}
print OUT "</table></span>\n";
close OUT;
