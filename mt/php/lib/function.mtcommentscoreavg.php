<?php
# Movable Type (r) (C) 2001-2008 Six Apart, Ltd. All Rights Reserved.
# This code cannot be redistributed without permission from www.sixapart.com.
# For more information, consult your Movable Type license.
#
# $Id: function.mtcommentscoreavg.php 1174 2008-01-08 21:02:50Z bchoate $

require_once('rating_lib.php');

function smarty_function_mtcommentscoreavg($args, &$ctx) {
    return hdlr_score_avg($ctx, 'comment', $args['namespace']);
}
?>
