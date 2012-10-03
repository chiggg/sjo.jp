<?php
# Movable Type (r) (C) 2001-2008 Six Apart, Ltd. All Rights Reserved.
# This code cannot be redistributed without permission from www.sixapart.com.
# For more information, consult your Movable Type license.
#
# $Id: block.mtparentcategory.php 1174 2008-01-08 21:02:50Z bchoate $

function smarty_block_mtparentcategory($args, $content, &$ctx, &$repeat) {
    if (!isset($content)) {
        $ctx->localize(array('category', 'conditional', 'else_content'));
        require_once("MTUtil.php");
        $cat = get_category_context($ctx);
        if (($cat) && ($cat['category_parent'])) {
            $parent_cat = $ctx->mt->db->fetch_category($cat['category_parent']);
            $ctx->stash('category', $parent_cat);
        }
        $ctx->stash('conditional', isset($parent_cat));
        $ctx->stash('else_content', null);
    } else {
        if (!$ctx->stash('conditional')) {
            $content = $ctx->stash('else_content');
        }
        $ctx->restore(array('category', 'conditional', 'else_content'));
    }
    return $content;
}
?>
