#!/usr/bin/perl -w
# "N. Dean Pentcheff" <pentcheff@gmail.com>
# Create a partial-site sitemap and update it at Google Webmaster Tools.
# 11/2009

use strict;
use LWP::Simple;
use URI::Escape;

my %sites = (
	     # Punch out a Google sitemap for the newsletters
	     scamit => {siteroot => "http://scamit.org",
			pdfroot  => "http://scamit.org/newsletters",
			# pdfdir is relative to where script is run
			pdfdir   => "newsletters",
			# name of sitemapfile, assumed to be in site root
			mapfile  => "scamit-sitemap.txt",
			# grep filter for filenames to include in sitemap
			filter   => '.pdf$',
		       },
	    );


for my $site (keys %sites) {
    open(MAP, "> $sites{$site}{mapfile}") or
	die("Failed opening sitemap '$sites{$site}{mapfile}': $!\n");
    print MAP qq|<?xml version="1.0" encoding="UTF-8"?>\n|,
	qq|<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">\n|;

    # get the PDF info
    opendir(DIR, $sites{$site}{pdfdir}) or
	die("Failed opening PDF directory '$sites{$site}{pdfdir}': $!\n");
    for my $file (grep(/$sites{$site}{filter}/, sort readdir(DIR))) {
	print ".";
	my $mtime = (stat($sites{$site}{pdfdir} . '/' . $file))[9];
	next unless $mtime;
	my($y,$m,$d) = (localtime($mtime))[5,4,3];
	$y += 1900;
	$m++;
	my $lastmod = sprintf("%4d-%02d-%02d", $y, $m, $d);
	print MAP "<url>\n",
	    " <loc>", $sites{$site}{pdfroot}, '/', $file, "</loc>\n",
	    " <changefreq>monthly</changefreq>\n",
	    " <lastmod>$lastmod</lastmod>\n",
            "</url>\n";
    }
    print "\n";
    closedir DIR;
    print MAP "</urlset>\n";
    close MAP;

    # now tell Google about it
    my $url = "http://www.google.com/webmasters/tools/ping?sitemap=";
    $url .= uri_escape($sites{$site}{siteroot} . "/" . $sites{$site}{mapfile});
    print "HTTP get $url\n";
    get($url);
}

