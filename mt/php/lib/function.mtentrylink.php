<?php
# Movable Type (r) (C) 2001-2008 Six Apart, Ltd. All Rights Reserved.
# This code cannot be redistributed without permission from www.sixapart.com.
# For more information, consult your Movable Type license.
#
# $Id: function.mtentrylink.php 1174 2008-01-08 21:02:50Z bchoate $

function smarty_function_mtentrylink($args, &$ctx) {
    $args['no_anchor'] = 1;
    $link = $ctx->tag('EntryPermalink', $args);
    if ($args['with_index'] && preg_match('/\/(#.*)$/', $link)) {
        $blog = $ctx->stash('blog');
        $index = $ctx->mt->config('IndexBasename');
        $ext = $blog['blog_file_extension'];
        if ($ext) $ext = '.' . $ext; 
        $index .= $ext;
        $link = preg_replace('/\/(#.*)?$/', "/$index\$1", $link);
    }
    return $link;
}
?>
