<?php
# Movable Type (r) (C) 2001-2008 Six Apart, Ltd. All Rights Reserved.
# This code cannot be redistributed without permission from www.sixapart.com.
# For more information, consult your Movable Type license.
#
# $Id: block.mtblogs.php 1174 2008-01-08 21:02:50Z bchoate $

function smarty_block_mtblogs($args, $content, &$ctx, &$repeat) {
    if (!isset($content)) {
        $ctx->localize(array('_blogs', '_blogs_counter', 'blog', 'blog_id'));
        $blogs = $ctx->mt->db->fetch_blogs($args);
        $ctx->stash('_blogs', $blogs);
        $counter = 0;
    } else {
        $blogs = $ctx->stash('_blogs');
        $counter = $ctx->stash('_blogs_counter');
    }
    if ($counter < count($blogs)) {
        $blog = $blogs[$counter];
        $ctx->stash('blog', $blog);
        $ctx->stash('blog_id', $blog['blog_id']);
        $ctx->stash('_blogs_counter', $counter + 1);
        $repeat = true;
    } else {
        $ctx->restore(array('_blogs', '_blogs_counter', 'blog', 'blog_id'));
        $repeat = false;
    }
    return $content;
}
?>
