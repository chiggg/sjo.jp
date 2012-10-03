<?php
# Movable Type (r) (C) 2001-2008 Six Apart, Ltd. All Rights Reserved.
# This code cannot be redistributed without permission from www.sixapart.com.
# For more information, consult your Movable Type license.
#
# $Id$

function smarty_function_mtblogpingcount($args, &$ctx) {
    $args['blog_id'] = $ctx->stash('blog_id');
    return $ctx->mt->db->blog_ping_count($args);
}
?>
