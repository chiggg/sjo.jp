<?php
  
Function Dochead() {
  global $blogrelurl, $pgtitle, $section, $opencomments;
  
  Doctype();

  echo '<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">'."\n";
  echo "<head>\n";
  
  
  // DOC TITLE
  echo "  <title>";
  echo ($pgtitle) ? $pgtitle : "Untitled";
  echo "</title>\n";

  echo '  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />'."\n";
  Styles();
  if ($opencomments) {
    echo '  <script type="text/javascript">var blogrelurl = "'.$blogrelurl.'";</script>'."\n";
    echo '  <script type="text/javascript" src="'.$blogrelurl.'meta/scripts/rememberMe.js"></script>'."\n";
    echo '  <script type="text/javascript" src="'.$blogrelurl.'meta/scripts/comments.js"></script>'."\n";
  }
  echo "</head>\n\n";
  
  echo "<body";
  if ($section) echo ' class="'.$section.'"';
  echo ">\n\n";
}

?>
