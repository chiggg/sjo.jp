<?php
# Movable Type (r) (C) 2001-2008 Six Apart, Ltd. All Rights Reserved.
# This code cannot be redistributed without permission from www.sixapart.com.
# For more information, consult your Movable Type license.
#
# $Id: block.mtifcommenterisauthor.php 1174 2008-01-08 21:02:50Z bchoate $

function smarty_block_mtifcommenterisauthor($args, $content, &$ctx, &$repeat) {
    # status: complete
    if (!isset($content)) {
        $cmtr = $ctx->stash('commenter');
        if (!isset($cmtr)) {
            return $ctx->_hdlr_if($args, $content, $ctx, $repeat, 0);
        }
        $is_author = $cmtr['author_type'] == 1 ? 1 : 0;
            return $ctx->_hdlr_if($args, $content, $ctx, $repeat, $is_author);
    } else {
        return $ctx->_hdlr_if($args, $content, $ctx, $repeat);
    }
}
?>
