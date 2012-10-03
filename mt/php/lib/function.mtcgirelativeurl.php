<?php
# Movable Type (r) (C) 2001-2008 Six Apart, Ltd. All Rights Reserved.
# This code cannot be redistributed without permission from www.sixapart.com.
# For more information, consult your Movable Type license.
#
# $Id: function.mtcgirelativeurl.php 1174 2008-01-08 21:02:50Z bchoate $

function smarty_function_mtcgirelativeurl($args, &$ctx) {
    // status: complete
    // parameters: none
    $url = $ctx->mt->config('CGIPath');
    if (substr($url, strlen($url) - 1, 1) != '/')
        $url .= '/';
    if (preg_match('!^(?:https?://[^/]+)?(/.*)$!', $url, $matches)) {
        return $matches[1];
    } else {
        return $url;
    }
}
?>
