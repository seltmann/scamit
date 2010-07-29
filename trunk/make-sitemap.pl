#!/usr/bin/perl -w
# "N. Dean Pentcheff" <pentcheff@gmail.com>
# Create a partial-site sitemap and update it at Google Webmaster Tools.
# Run this in the site root
# 11/2009

use strict;
use LWP::Simple;
use URI::Escape;
use File::Find;

my $debug = 0;

my %sites = (
	     # Punch out a Google sitemap for the newsletters
	     scamit => {siteroot => "http://scamit.org",
			# pdfdir is relative to site root
			pdfdir   => "newsletters",
			# name of sitemapfile, put into site root
			mapfile  => "scamit-sitemap.txt",
			# grep filter for filenames to include in sitemap
			filter   => '.pdf$',
		       },
	     # Punch out a Google sitemap for the taxon toolbox
	     toolbox => {siteroot => "http://scamit.org",
			 # pdfdir is relative to where script is run
			 pdfdir   => "taxontools/toolbox",
			 # name of sitemapfile, assumed to be in site root
			 mapfile  => "scamit-taxontools.txt",
			 # grep filter for filenames to include in sitemap
			 filter   => '.',
		        },
	    );


for my $site (keys %sites) {
    my $wanted = sub {
	my $visitedfilename = $_;
	if ($visitedfilename =~ m/$sites{$site}{filter}/  &&
	    -f $visitedfilename) {
	    print $File::Find::name if $debug;
	    my $mtime = (stat($visitedfilename))[9];
	    if ($mtime) {
		my($y,$m,$d) = (localtime($mtime))[5,4,3];
		$y += 1900;
		$m++;
		my $lastmod = sprintf("%4d-%02d-%02d", $y, $m, $d);
		my $url = $sites{$site}{siteroot} . '/' . $File::Find::name;
		print MAP "<url>\n <loc>",
		    # modify uri_escape to NOT escape ://, etc.
                    uri_escape($url, "^A-Za-z0-9\-\._~" . "/:"),
                    "</loc>\n <changefreq>monthly</changefreq>\n",
		    " <lastmod>$lastmod</lastmod>\n",
		    "</url>\n";
		print " OK: $url\n" if $debug;
	    } else {
		" skipped: no mtime\n";
	    }
	} else {
	    print $File::Find::name . " skipped\n" if $debug;
	}
    };

    open(MAP, "> $sites{$site}{mapfile}") or
	die("Failed opening sitemap '$sites{$site}{mapfile}': $!\n");
    print MAP qq|<?xml version="1.0" encoding="UTF-8"?>\n|,
	qq|<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">\n|;

    find({wanted => $wanted,
	  follow => 1},
	  $sites{$site}{pdfdir});

    print MAP "</urlset>\n";
    close MAP;

    # now tell Google about it
    my $url = "http://www.google.com/webmasters/tools/ping?sitemap=";
    $url .= uri_escape($sites{$site}{siteroot} . "/" . $sites{$site}{mapfile});
    print "HTTP: get $url\n";
    if ($debug) {
	print "debugging: URL not updated at Google!\n";
    } else {
	get($url);
    }
}

