<?php

Function CatOrder($entryids, $entryid) {
  // Used to determine X in Photo X of Y
  for ($i = 0; $i < count($entryids); $i++) {
    if ($entryids[$i] == $entryid) $catorder = $i;
  }
  return $catorder;
}

?>
