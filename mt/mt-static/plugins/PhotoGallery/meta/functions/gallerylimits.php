<?php

Function GalleryLimits($gallerycount) {
  // Options for accepted quantities (also populates "Display how many photos?" quantity drop down)
  $quantities = Array(25,50,100,"all");
  $newquant = "";
  $neworder = "";
  
  if (isset($_POST['quantity'])) {
    $newquant = strip_tags($_POST['quantity']);  
    // If $newquant doesn't match one of our accepted $quantities, ignore it
    foreach ($quantities as $quantity) {
      if (strtolower($newquant) == $quantity) $quantmatch = true;
      if (is_string($newquant)) $newquant = strtolower($newquant);
    }
    if (!$quantmatch) $newquant = "";
    // If we have a new quantity, set a quantity cookie
    if ($newquant) {
      setcookie('galleryquantity', $newquant, time()+60*60*24*30, '/');
    }
  }
  
  if (isset($_POST['order'])) {
    $neworder = strip_tags($_POST['order']);
    // If $neworder has a value and is "new" or "old", set an order cookie
    if (($neworder == "new") OR ($neworder == "old")) {
      setcookie('galleryorder', $neworder, time()+60*60*24*30, '/');
    } else {
      $neworder = "";
    }
  }
  
  
  // Get the quantity cookie, if any
  if (isset($_COOKIE['galleryquantity'])) $setquant = $_COOKIE['galleryquantity'];
  if ($newquant) {
    $displaycount = $newquant;
  } elseif ($setquant) {
    $displaycount = $setquant;
  } else {
    $displaycount = 25;
  }

  // Get the order cookie, if any
  if (isset($_COOKIE['galleryorder'])) $setorder = $_COOKIE['galleryorder'];
  if ($neworder) {
    $displayorder = $neworder;
  } elseif ($setorder) {
    $displayorder = $setorder;
  } else {
    $displayorder = "old";
  }


  // Determine start position
  if (isset($_GET['start'])) {
    $start = $_GET['start'];
    $start = intval($start);
  } else {
    $start = 1;
  }
  // $gallerycount is taken from local galleryinfo.php in each gallery's directory
  if ($start > $gallerycount) $start = 1;
  if ($start < 1) $start = 1;
    
  $thiscount = $displaycount;
  
  // If viewing ALL images, start is first photo, 
  // and number of thumbnails to display = category count
  if ($displaycount == "all") {
    $start = 1;
    $thiscount = $gallerycount;
  }
  // If not starting from first photo, 
  // provide a link to previous set
  if ($start > 1) {
    $prevstart = $start - $thiscount;
    if ($prevstart <= 1) {
      $prevstart = "./";
    } else {
      $prevstart = "?start=".$prevstart;
    }
  }
  // If high limit is less than category count, 
  // provide a link to next set
  if (($start + $thiscount) < $gallerycount) {
    $nextstart = $start + $thiscount;
    $nextstart = "?start=".$nextstart;
  }
  
  // Determine low and high limits for thumbnails to display
  $lolimit = $start;
  $hilimit = $lolimit + $thiscount - 1;
  if ($hilimit > $gallerycount) $hilimit = $gallerycount;
  
  $gallerylimits['gallerycount'] = $gallerycount;
  $gallerylimits['quantities'] = $quantities;
  $gallerylimits['displaycount'] = $displaycount;
  $gallerylimits['displayorder'] = $displayorder;
  $gallerylimits['prevstart'] = $prevstart;
  $gallerylimits['nextstart'] = $nextstart;
  $gallerylimits['lolimit'] = $lolimit;
  $gallerylimits['hilimit'] = $hilimit;
  
  return $gallerylimits;
}

?>
