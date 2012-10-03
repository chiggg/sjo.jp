<?php
# Movable Type (r) (C) 2001-2008 Six Apart, Ltd. All Rights Reserved.
# This code cannot be redistributed without permission from www.sixapart.com.
# For more information, consult your Movable Type license.
#
# $Id$

function smarty_modifier_setvar($text, $name) {
    global $mt;
    $ctx =& $mt->context();
    $vars =& $ctx->__stash['vars'];
    $vars[$name] = $text;
    return '';
}
?>