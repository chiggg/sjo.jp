<?php
# Movable Type (r) (C) 2001-2008 Six Apart, Ltd. All Rights Reserved.
# This code cannot be redistributed without permission from www.sixapart.com.
# For more information, consult your Movable Type license.
#
# $Id$

function smarty_function_mtentriescount($args, &$ctx) {
    if ($ctx->stash('inside_mt_categories')) {
        return $ctx->tag('MTCategoryCount', $args);
    } elseif ($count = $ctx->stash('archive_count')) {
        return $count;
    } else {
        $entries = $ctx->stash('entries');
        if (!is_array($entries)){
            $blog = $ctx->stash('blog');
            $args['blog_id'] = $blog['blog_id'];
            $entries =& $ctx->mt->db->fetch_entries($args);
        }
    
        $lastn = $ctx->stash('_entries_lastn');
        if ($lastn && $lastn <= count($entries))
            return $lastn;
        else
            return count($entries);
    }
}
?>
