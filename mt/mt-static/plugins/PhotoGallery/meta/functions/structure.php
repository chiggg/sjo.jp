<?php

Function ContentOpen() {
  global $img;
  echo "\n".'<div id="content"';
  if (IsVertical($img)) echo ' class="v"';
  echo ">\n";
}

Function ContentClose() {
  echo "</div>\n\n";
}

Function SecondaryOpen() {
  echo "\n".'<div id="secondary">'."\n";
}

Function SecondaryClose() {
  echo "</div>\n\n";
}

Function ModuleOpen() {
  echo "\n".'<div class="module">'."\n";
}

Function ModuleClose() {
  echo "</div>\n\n";
}

?>
