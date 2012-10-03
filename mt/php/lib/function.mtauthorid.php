<?php
# Movable Type (r) (C) 2001-2008 Six Apart, Ltd. All Rights Reserved.
# This code cannot be redistributed without permission from www.sixapart.com.
# For more information, consult your Movable Type license.
#
# $Id$

function smarty_function_mtauthorid($args, &$ctx) {
    $author = $ctx->stash('author');
    if (!$author) {
        return $ctx->error("No author available");
    }
    return $author['author_id'];
}
?>
