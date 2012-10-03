<?php
# Movable Type (r) (C) 2001-2008 Six Apart, Ltd. All Rights Reserved.
# This code cannot be redistributed without permission from www.sixapart.com.
# For more information, consult your Movable Type license.
#
# $Id: modifier.filters.php 1174 2008-01-08 21:02:50Z bchoate $

function smarty_modifier_filters($text,$filters) {
    // status: complete
    $f = preg_split('/\s*,\s*/', $filters);
    global $mt;
    $ctx =& $mt->context();
    if (is_array($f) && count($f) > 0) {
        foreach ($f as $filter) {
            if ($filter == '__default__') {
                $filter = 'convert_breaks';
            }
            if ($ctx->load_modifier($filter)) {
                $mod = 'smarty_modifier_'.$filter;
                $text = $mod($text);
            }
        }
    }
    return $text;
}
?>
