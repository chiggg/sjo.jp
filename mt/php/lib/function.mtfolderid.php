<?php
# Movable Type (r) (C) 2001-2008 Six Apart, Ltd. All Rights Reserved.
# This code cannot be redistributed without permission from www.sixapart.com.
# For more information, consult your Movable Type license.
#
# $Id$

require_once('function.mtcategoryid.php');
function smarty_function_mtfolderid($args, &$ctx) {
    return smarty_function_mtcategoryid($args, $ctx);
}
?>
