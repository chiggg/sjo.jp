<?php
# Movable Type (r) (C) 2001-2008 Six Apart, Ltd. All Rights Reserved.
# This code cannot be redistributed without permission from www.sixapart.com.
# For more information, consult your Movable Type license.
#
# $Id$

function smarty_block_mtcommenteruserpicasset($args, $content, &$ctx, &$repeat) {
    $comment = $ctx->stash('comment');
    if (!$comment) {
        return $ctx->error("No comment available");
    }
    $cmntr = $ctx->stash('commenter');
    if (!$cmntr) return '';

    $asset_id = isset($cmntr['author_userpic_asset_id']) ? $cmntr['author_userpic_asset_id'] : 0;
    $asset = $ctx->mt->db->fetch_assets(array('id' => $asset_id));
    if (!$asset) return '';

    $ctx->stash('asset',  $asset[0]);

    return $content;
}
?>
