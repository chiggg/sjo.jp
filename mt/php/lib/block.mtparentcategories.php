<?php
# Movable Type (r) (C) 2001-2008 Six Apart, Ltd. All Rights Reserved.
# This code cannot be redistributed without permission from www.sixapart.com.
# For more information, consult your Movable Type license.
#
# $Id: block.mtparentcategories.php 1174 2008-01-08 21:02:50Z bchoate $

function get_parent_categories(&$cat, &$ctx, &$list) {
    if ($cat['category_parent']) {
        $parent = $ctx->mt->db->fetch_category($cat['category_parent']);
        if ($parent) {
            $cat['_parent'] =& $parent;
            array_unshift($list, 0); $list[0] =& $parent;
            get_parent_categories($parent, $ctx, $list);
        }
    }
}

function smarty_block_mtparentcategories($args, $content, &$ctx, &$repeat) {
    $localvars = array('_categories', 'category', '_categories_counter','glue');
    if (!isset($content)) {
        $ctx->localize($localvars);
        require_once("MTUtil.php");
        $cat = get_category_context($ctx);
        $parents = array();
        get_parent_categories($cat, $ctx, $parents);
        if (!isset($args['exclude_current'])) {
            $parents[] = $cat;
        }
        if (isset($args['glue'])) {
            $glue = $args['glue'];
        } else {
            $glue = '';
        }
        $ctx->stash('_categories', $parents);
        $ctx->stash('glue', $glue);
        $counter = 0;
    } else {
        $parents = $ctx->stash('_categories');
        $counter = $ctx->stash('_categories_counter');
        $glue = $ctx->stash('glue');
    }

    if ($counter < count($parents)) {
        $ctx->stash('category', $parents[$counter]);
        $ctx->stash('_categories_counter', $counter + 1);
        $repeat = true;
    } else {
        $repeat = false;
        $glue = '';
        $ctx->restore($localvars);
    }
    return $content.$glue;
}
?>