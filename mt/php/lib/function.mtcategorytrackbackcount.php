<?php
# Movable Type (r) (C) 2001-2008 Six Apart, Ltd. All Rights Reserved.
# This code cannot be redistributed without permission from www.sixapart.com.
# For more information, consult your Movable Type license.
#
# $Id$

function smarty_function_mtcategorytrackbackcount($args, &$ctx) {
    $cat = $ctx->stash('category');
    $cat_id = $cat['category_id'];
    return $ctx->mt->db->category_ping_count($cat_id);
}
?>
