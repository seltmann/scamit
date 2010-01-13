<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta name="keywords" content="" />
<meta name="description" content="" />
<link href="/default.css" rel="stylesheet" type="text/css" />
<link href="/php_file_tree.css" rel="stylesheet" type="text/css" />
<?php include("php_file_tree.php"); ?>
<title>Taxonomic Toolbox</title><!-- page title -->
</head>
<body>
<style>
#header h1 {background: url(/s_images/anemone_Bonaire_Richard_Hogg_1966-sm.jpg) no-repeat;}
</style>
<?php include($_SERVER['DOCUMENT_ROOT'] . "/s_header.php"); ?>
<div id="page">
<?php include($_SERVER['DOCUMENT_ROOT'] . "/s_topmenu.php"); ?>
<h1>SCAMIT Taxonomic Toolbox</h1>
<table class="cutepic right" cellspacing='0' cellpadding='0'>
  <tr><td class="cutepic"><img class="cutepic"
       src="/images/Isocladus_armatus.jpg"
       alt="Isocladus armatus" /></td></tr>
  <tr><td class="cutepic" style='padding-bottom:2ex;'><i>Isocladus armatus</i></td></tr>
  <tr><td style='border:1px solid #909090;padding:0.5ex 0.5em;'><p
      class='smallsize'
      style='text-align:left;margin-top:0;'><b>Toolbox notes:</b></p>
      <p class='smallsize'
      style='text-align:left;margin-top:1ex;border:2px solid red;padding:0.5ex 0.5em;'<i>Taxon
      names in older documents may not be current, but will be listed
      as a synonym under the current accepted name usage in the
      <a href='/publications/SCAMIT-ed5.pdf' target='_blank'>Edition 5
      species list</a>.</p>
      <p class='smallsize' style='text-align:left;margin-top:1ex;'>If
      you find that the taxon hierarchy collapses when you select a
      file, <i>right-click</i> on taxon files and select</i>
      &ldquo;Open link in new window&rdquo;.</p></td></tr>
</table>
<p class='hr' style='line-height:0;'>&nbsp;</p> <!-- just for horiz. line -->
<script src="php_file_tree.js" type="text/javascript"></script>
  <?php $allowed_extensions = array("doc",  "ppt",  "xls",
                                    "docx", "pptx", "xlsx",
                                    "pdf",  "rtf",  "odt",
                                    "jpg",  "tif",  "bmp", "gif", "png",
                                    "jpeg", "tiff"); ?>
  <span class="stdsize">
    <?php echo php_file_tree("toolbox",     "[link]", $allowed_extensions); ?>
  </span>
  <h1>SCAMIT/SAFIT Workshops</h1>
  <p class='hr' style='line-height:0;'>&nbsp;</p> <!-- just for horiz. line -->
  <span class="stdsize">
    <?php echo php_file_tree("scamitsafit", "[link]", $allowed_extensions); ?>
  </span>
<p class='whiteonwhite'>
This is just filler text to get us to the wrap margin.
This is lame, but so it goes.
Better suggestions are welcome!
This is just filler text to get us to the wrap margin.
This is lame, but so it goes.
Better suggestions are welcome!
</p>
<?php include($_SERVER['DOCUMENT_ROOT'] . "/s_footer.php"); ?>
</div><!-- end page -->
</body></html>
