<?php
# Movable Type (r) (C) 2001-2008 Six Apart, Ltd. All Rights Reserved.
# This code cannot be redistributed without permission from www.sixapart.com.
# For more information, consult your Movable Type license.
#
# $Id$

function smarty_function_mtcommentlink($args, &$ctx) {
    $args['no_anchor'] = 1;
    $entry_link = $ctx->tag('EntryPermaink', $args);
    $entry_link .= '#comment-' . $ctx['comment_id'];
    return $link;
}
?>