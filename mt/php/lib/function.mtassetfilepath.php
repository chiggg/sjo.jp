<?php
# Movable Type (r) (C) 2001-2008 Six Apart, Ltd. All Rights Reserved.
# This code cannot be redistributed without permission from www.sixapart.com.
# For more information, consult your Movable Type license.
#
# $Id$

function smarty_function_mtassetfilepath($args, &$ctx) {
    $asset = $ctx->stash('asset');
    if (!$asset) return '';

    $blog = $ctx->stash('blog');

    $asset_file = $asset['asset_file_path'];

    $blog_site_path = $blog['blog_site_path'];
    $blog_site_path = preg_replace('/\/$/', '', $blog_site_path);
    $asset_file = preg_replace('/^%a/', $blog_site_path, $asset_file);

    $blog_archive_path = $blog['blog_archive_path'];
    if (!$blog_archive_path) $blog_archive_path = $blog_site_path;
    if ($blog_archive_path) {
        $blog_archive_path = preg_replace('/\/$/', '', $blog_archive_path);
        $asset_file = preg_replace('/^%r/', $blog_archive_path, $asset_file);
    }

    return $asset_file;
}
?>
