<?php
# Movable Type (r) (C) 2001-2008 Six Apart, Ltd. All Rights Reserved.
# This code cannot be redistributed without permission from www.sixapart.com.
# For more information, consult your Movable Type license.
#
# $Id: function.mtcommenterauthiconurl.php 1174 2008-01-08 21:02:50Z bchoate $

function smarty_function_mtcommenterauthiconurl($args, &$ctx) {
    $a =& $ctx->stash('commenter');
    if (!isset($a)) {
        return '';
    }
    require_once "function.mtstaticwebpath.php";
    $static_path = smarty_function_mtstaticwebpath($args, $ctx);
    require_once "commenter_auth_lib.php";
    return _auth_icon_url($static_path, $a);
}
?>
