<?php
# Movable Type (r) (C) 2001-2008 Six Apart, Ltd. All Rights Reserved.
# This code cannot be redistributed without permission from www.sixapart.com.
# For more information, consult your Movable Type license.
#
# $Id: modifier.sanitize.php 1174 2008-01-08 21:02:50Z bchoate $

function smarty_modifier_sanitize($text, $spec) {
    if ($spec == '1') {
        global $mt;
        $ctx =& $mt->context();
        $blog = $ctx->stash('blog');
        $spec = $blog['blog_sanitize_spec'];
        $spec or $spec = $mt->config('GlobalSanitizeSpec');
    }
    require_once("sanitize_lib.php");
    return sanitize($text, $spec);
}
?>
