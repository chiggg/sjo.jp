<?php
# Movable Type (r) (C) 2001-2008 Six Apart, Ltd. All Rights Reserved.
# This code cannot be redistributed without permission from www.sixapart.com.
# For more information, consult your Movable Type license.
#
# $Id$

function smarty_block_mtcommenteriftrusted($args, $content, &$ctx, &$repeat) {
    if (!isset($content)) {
        $a = $ctx->stash('commenter');
        $banned = $a ? (preg_match("/'comment'/", $a['permission_restrictions']) ? 1 : 0) : 0;
        $approved = $a ? (preg_match("/'(comment|administer_blog|manage_feedback)'/", $a['permission_permissions']) ? 1 : 0) : 0;
        return $ctx->_hdlr_if($args, $content, $ctx, $repeat, !$banned && $approved);
    } else {
        return $ctx->_hdlr_if($args, $content, $ctx, $repeat);
    }
}
?>
