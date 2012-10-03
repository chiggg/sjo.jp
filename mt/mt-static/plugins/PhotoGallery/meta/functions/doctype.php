<?php

Function Doctype() {
  global $dtd;
  switch($dtd) :
    case 'transitional':
      echo '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" ';
      echo '"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">'."\n\n";
    break;
    default:
      echo '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" ';
      echo '"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">'."\n\n";
    break;
  endswitch;
}

?>
