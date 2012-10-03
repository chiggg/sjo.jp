<?php

Function GalleryNav($imgs) {
  // Used for no. of images per page, and old/new new/old sorting 
  // of images on Photo Gallery pages.
  global $blogrelurl, $gallerylimits, $imageurl;
  extract($gallerylimits);
  
  if ((count($imgs) > $quantities[0]) OR (count($imgs) > 1)) {
    echo '  <form action="./" method="post">'."\n";
    
    // Only display quantity pulldown if # images greater than first quantity option
    if (count($imgs) > $quantities[0]) {
      echo "    <fieldset>\n";
      echo '      <strong>Display how many photos?</strong>'."\n";
      echo '      <div><select name="quantity" id="quantity">'."\n";
      foreach ($quantities as $quantity) {
        $value = $quantity;
        if (is_string($value)) $value = strtoupper($value);
        // Only display this option if # images is greater than this option, or option is ALL
        if ((count($imgs) > $quantity) OR ($quantity == "all")) {
          echo '        <option value="'.$quantity.'"';
          // Determine which option is selected
          if ($quantity == $displaycount) echo ' selected="selected"';
          echo '>'.$value.'</option>'."\n";
        }
      }
      echo "      </select>\n";
      echo '      <label for="quantity">per page</label></div>'."\n";
      echo "    </fieldset>\n";
    }
    if (count($imgs) > 1) {
      echo "    <fieldset>\n";
      echo '      <strong>In what order?</strong>'."\n";
      $ordervalues = Array("old" => "old to new", "new" => "new to old");
      foreach ($ordervalues as $ordervalue => $orderlabel) {
        echo '      <div><input type="radio" name="order" id="order-'.$ordervalue.'" value="'.$ordervalue.'"';
        if ($ordervalue == $displayorder) echo ' checked="checked"';
        echo ' />'."\n";
        echo '        <label for="order-'.$ordervalue.'"';
        if ($ordervalue == $displayorder) echo ' class="selected"';
        echo '>'.$orderlabel.'</label></div>'."\n";
      }
      echo "    </fieldset>\n";
    }
    echo '    <p><input type="image" src="'.$imageurl.'meta/img/btn_save.gif" alt="Save" class="btn" /></p>'."\n";
    echo "  </form>\n";
  }

  // Position x1-x2 of y, and prev/next navigation
  echo "    <p>\n";
  echo '      <em class="count">Photos '.$lolimit.'-'.$hilimit.' of '.$gallerycount.'</em>';
  if (($prevstart) OR ($nextstart)) echo "\n      ";
  if ($prevstart) {
    echo '<a href="'.$prevstart.'" accesskey="z">&laquo; previous page</a>';
  }
  if (($prevstart) AND ($nextstart)) echo ' | ';
  if ($nextstart) {
    echo '<a href="'.$nextstart.'" accesskey="x">next page &raquo;</a>';
  }
  echo "\n    </p>\n";
}

?>
