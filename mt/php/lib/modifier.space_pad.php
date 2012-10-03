<?php
# Movable Type (r) (C) 2001-2008 Six Apart, Ltd. All Rights Reserved.
# This code cannot be redistributed without permission from www.sixapart.com.
# For more information, consult your Movable Type license.
#
# $Id: modifier.space_pad.php 1174 2008-01-08 21:02:50Z bchoate $

function smarty_modifier_space_pad($text, $len) {
    return sprintf("%".$len."s", $text);
}
?>
