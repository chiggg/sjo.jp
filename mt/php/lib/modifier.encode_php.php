<?php
# Movable Type (r) (C) 2001-2008 Six Apart, Ltd. All Rights Reserved.
# This code cannot be redistributed without permission from www.sixapart.com.
# For more information, consult your Movable Type license.
#
# $Id: modifier.encode_php.php 1174 2008-01-08 21:02:50Z bchoate $

function smarty_modifier_encode_php($text, $type) {
    switch ($type) {
        case 'qq':
            $out = encode_phphere($text);
            $out = str_replace('"','\"',$out);
            break;
        case 'here':
            $out = encode_phphere($text);
            break;
        default:  // 'q'
            $out = str_replace("\\","\\\\",$text);
            $out = str_replace("'","\\'",$out);
            break;
    }
    return $out;
}
function encode_phphere($text) {
    $out = str_replace("\\","\\\\",$text);
    $out = str_replace('$','\$',$out);
    $out = str_replace("\n",'\n',$out);
    $out = str_replace("\r",'\r',$out);
    $out = str_replace("\t",'\t',$out);
    return $out;
}
?>
