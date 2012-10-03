<?php
# Movable Type (r) (C) 2001-2008 Six Apart, Ltd. All Rights Reserved.
# This code cannot be redistributed without permission from www.sixapart.com.
# For more information, consult your Movable Type license.
#
# $Id$

function smarty_function_mtcategorycommentcount($args, &$ctx) {
    global $mt;
    $db =& $mt->db;
    $category = $ctx->stash('category');
    $cat_id = (int)$category['category_id'];
    if (!$cat_id) return 0;
    return $db->category_comment_count(array( 'category_id' => $cat_id ));
}
?>
