<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta name="keywords" content="" />
<meta name="description" content="" />
<link href="/default.css" rel="stylesheet" type="text/css" />
<title></title><!-- page title -->
</head>
<body>
<?php include($_SERVER['DOCUMENT_ROOT'] . "/s_header.php"); ?>
<div id="page">
<?php include($_SERVER['DOCUMENT_ROOT'] . "/s_topmenu.php"); ?>
<h1></h1><!-- main title, perhaps same as page title -->
<div id="sidebar"><!-- if sidebar desired, put it here -->
  <div class="orangebox"><!-- always nest inside sidebar -->
    <h1></h1><!-- super-important sidebar title, usually omit -->
    <h2></h2><!-- regular sidebar section title(s) -->
    <p></p><!-- sidebar content -->
  </div><!-- end sidebar's orangebox -->
</div><!--   end sidebar -->
<h2 class='hr'></h2><!-- page section title, first one has an 'hr' -->
<img src="" alt="" width="" class="left" /><!-- interpolated images -->
<p></p><!-- regular page content -->
<blockquote></blockquote><!-- use for inline quote sections -->
<h2></h2><!-- additional page content header -->
<p></p><!--   additional page content -->
<?php include($_SERVER['DOCUMENT_ROOT'] . "/s_footer.php"); ?>
</div><!-- end page -->
</body></html>