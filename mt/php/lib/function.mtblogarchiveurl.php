<?php
# Movable Type (r) (C) 2001-2008 Six Apart, Ltd. All Rights Reserved.
# This code cannot be redistributed without permission from www.sixapart.com.
# For more information, consult your Movable Type license.
#
# $Id: function.mtblogarchiveurl.php 1174 2008-01-08 21:02:50Z bchoate $

function smarty_function_mtblogarchiveurl($args, &$ctx) {
    // status: complete
    // parameters: none
    $blog = $ctx->stash('blog');
    $url = $blog['blog_archive_url'];
    if ($url == '') {
        $url = $blog['blog_site_url'];
    }
    if (!preg_match('/\/$/', $url)) $url .= '/';
    return $url;
}
?>
