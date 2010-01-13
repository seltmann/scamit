<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="keywords" content="" />
<meta name="description" content="" />
<link href="/default.css" rel="stylesheet" type="text/css" />
<title>Resource Links</title><!-- page title -->

<!-- Hack for suppressing failed link lines in table 
     using a CSS style override (also tweaking link text). -->
<?php
# check 'see=xxx' argument on web page to determine display status
if (strncmp($_GET["see"], "failed", 6) == 0) {
  $failcomment = "<a href='/links.php?see=none'>hide the failed links</a>";
} else {
  echo "<style>#links tr.fail {display:none;}</style>\n";
  $failcomment = "<a href='/links.php?see=failed'>show the failed links</a>";
}
?>

</head>
<body>
<?php include($_SERVER['DOCUMENT_ROOT'] . "/s_header.php"); ?>
<div id="page">
<?php include($_SERVER['DOCUMENT_ROOT'] . "/s_topmenu.php"); ?>
<h1>Resource Links</h1><!-- main title, perhaps same as page title -->
<p><i>This list contains some links that have failed a check for
existence (<span style='color:#909090;'>grayed out</span> in appearance).
If you wish, you can <?php echo $failcomment ?>.</i></p>
</p>
<?php include("links.html"); ?>
<?php include($_SERVER['DOCUMENT_ROOT'] . "/s_footer.php"); ?>
</div><!-- end page -->
</body></html>
