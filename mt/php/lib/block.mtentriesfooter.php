<?php
# Movable Type (r) (C) 2001-2008 Six Apart, Ltd. All Rights Reserved.
# This code cannot be redistributed without permission from www.sixapart.com.
# For more information, consult your Movable Type license.
#
# $Id: block.mtentriesfooter.php 1174 2008-01-08 21:02:50Z bchoate $

function smarty_block_mtentriesfooter($args, $content, &$ctx, &$repeat) {
    if (!isset($content)) {
        $entries =& $ctx->stash('entries');
        $counter = $ctx->stash('_entries_counter');
        return $ctx->_hdlr_if($args, $content, $ctx, $repeat, $counter == count($entries));
    } else {
        return $ctx->_hdlr_if($args, $content, $ctx, $repeat);
    }
}
?>
