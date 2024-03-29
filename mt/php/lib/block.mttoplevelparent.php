<?php
# Movable Type (r) (C) 2001-2008 Six Apart, Ltd. All Rights Reserved.
# This code cannot be redistributed without permission from www.sixapart.com.
# For more information, consult your Movable Type license.
#
# $Id: block.mttoplevelparent.php 1174 2008-01-08 21:02:50Z bchoate $

function smarty_block_mttoplevelparent($args, $content, &$ctx, &$repeat) {
    if (!isset($content)) {
        $ctx->localize(array('category','conditional','else_content'));
        require_once("MTUtil.php");
        $cat = get_category_context($ctx);
        require_once("block.mtparentcategories.php");
        $list = array();
        get_parent_categories($cat, $ctx, $list);
        $ctx->stash('else_content', null);
        if (count($list) > 0) {
            $cat = array_pop($list);
            $ctx->stash('category', $cat);
        }
        $ctx->stash('conditional', $cat ? 1 : 0);
    } else {
        if (!$ctx->stash('conditional')) {
            $content = $ctx->stash('else_content');
        }
        $ctx->restore(array('category','conditional','else_content'));
    }
    return $content;
}
?>
