<?php
# Movable Type (r) (C) 2001-2008 Six Apart, Ltd. All Rights Reserved.
# This code cannot be redistributed without permission from www.sixapart.com.
# For more information, consult your Movable Type license.
#
# $Id$

function smarty_block_mtauthorhaspage($args, $content, &$ctx, &$repeat) {
    if (!isset($content)) {
        $author = $ctx->stash('author');
        if (!$author) {
            return $ctx->error($ctx->mt->translate("No author available"));
        }
        $args['blog_id'] = $ctx->stash('blog_id');
        $args['author_id'] = $author['author_id'];
        $args['class'] = 'page';
        $count = $ctx->mt->db->author_entry_count($args);
        return $ctx->_hdlr_if($args, $content, $ctx, $repeat, $count);
    } else {
        return $ctx->_hdlr_if($args, $content, $ctx, $repeat);
    }
}
?>
