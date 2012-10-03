<?php

Function IsVertical($img) {
  // Returns true if <img> element is vertical (portrait) in orientation.
  // Could be done more efficiently with regex matching, but
  // that's beyond me.
  
  // verify <img> has a width and height specified
  // and uses double quotes
  if ((strstr($img,'width="')) AND (strstr($img,'height="'))) {
    $imgw = substr($img,strpos($img,'width="')+7);
    $imgw = substr($imgw,0,strpos($imgw,'"'));
    $imgh = substr($img,strpos($img,'height="')+8);
    $imgh = substr($imgh,0,strpos($imgh,'"'));
    if ((is_numeric($imgw)) AND (is_numeric($imgh))) {
      if ($imgw < $imgh) return true;
    }
  // OR uses single quotes
  } elseif ((strstr($img,"width='")) AND (strstr($img,"height='"))) {
    $imgw = substr($img,strpos($img,"width='")+7);
    $imgw = substr($imgw,0,strpos($imgw,'"'));
    $imgh = substr($img,strpos($img,"height='")+8);
    $imgh = substr($imgh,0,strpos($imgh,"'"));
    if ((is_numeric($imgw)) AND (is_numeric($imgh))) {
      if ($imgw < $imgh) return true;
    }
  }
}

?>
