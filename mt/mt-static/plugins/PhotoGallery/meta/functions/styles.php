<?php

Function Styles() {
  global $blogrelurl, $galleryurl, $customcss, $staticurl;
  echo '  <link rel="stylesheet" type="text/css" media="screen, projection" href="'.$staticurl.'plugins/PhotoGallery/meta/css/master.css" />'."\n";
  if ($customcss) {
    echo '  <link rel="stylesheet" type="text/css" media="screen, projection" href="'.$galleryurl.$customcss.'" />'."\n";
  }
}

?>
