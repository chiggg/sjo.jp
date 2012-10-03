<?php
# Movable Type (r) (C) 2001-2008 Six Apart, Ltd. All Rights Reserved.
# This code cannot be redistributed without permission from www.sixapart.com.
# For more information, consult your Movable Type license.
#
# $Id: function.mtcaptchafields.php 1174 2008-01-08 21:02:50Z bchoate $

require_once('captcha_lib.php');
function smarty_function_mtcaptchafields($args, &$ctx) {
    // status: complete
    // parameters: none
    global $_captcha_providers;
    $blog = $ctx->stash('blog');
    $key = $blog['blog_captcha_provider'];
    if (!isset($key)) {
        return '';
    }
    $provider = $_captcha_providers[$key];
    if (isset($provider)) {
        $fields = $provider->form_fields($blog['blog_id']);
        $fields = preg_replace('/[\r\n]/', '', $fields);
        $fields = preg_replace("/[\\']/", '\\"', $fields);
        return $fields;
    } else {
        return '';
    }
}
?>

