<?php
# Movable Type (r) (C) 2001-2008 Six Apart, Ltd. All Rights Reserved.
# This code cannot be redistributed without permission from www.sixapart.com.
# For more information, consult your Movable Type license.
#
# $Id: block.mthasparentcategory.php 1174 2008-01-08 21:02:50Z bchoate $

function smarty_block_mthasparentcategory($args, $content, &$ctx, &$repeat) {
    if (!isset($content)) {
        require_once("MTUtil.php");
        $cat = get_category_context($ctx);
        $has_parent = $cat['category_parent'];
        return $ctx->_hdlr_if($args, $content, $ctx, $repeat, ($has_parent > 0 ? 1 : 0));
    } else {
        return $ctx->_hdlr_if($args, $content, $ctx, $repeat);
    }
}
?>
