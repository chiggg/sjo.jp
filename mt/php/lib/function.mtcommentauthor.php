<?php
# Movable Type (r) (C) 2001-2008 Six Apart, Ltd. All Rights Reserved.
# This code cannot be redistributed without permission from www.sixapart.com.
# For more information, consult your Movable Type license.
#
# $Id: function.mtcommentauthor.php 1174 2008-01-08 21:02:50Z bchoate $

function smarty_function_mtcommentauthor($args, &$ctx) {
    $c = $ctx->stash('comment');
    if (!$c) {
        return $ctx->error("No comment available");
    }
    $a = isset($c['comment_author']) ? $c['comment_author'] : '';
    if (isset($args['default'])) {
        $a or $a = $args['default'];
    }
    $a or $a = '';
    return strip_tags($a);
}
?>
