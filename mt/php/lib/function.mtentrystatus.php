<?php
# Movable Type (r) (C) 2001-2008 Six Apart, Ltd. All Rights Reserved.
# This code cannot be redistributed without permission from www.sixapart.com.
# For more information, consult your Movable Type license.
#
# $Id: function.mtentrystatus.php 1174 2008-01-08 21:02:50Z bchoate $

define('STATUS_HOLD', 1);
define('STATUS_RELEASE', 2);
define('STATUS_REVIEW', 3);
define('STATUS_FUTURE', 4);

function status_text($s) {
    // TODO: translations of these statuses
    return $s == STATUS_HOLD ? "Draft" :
        ($s == STATUS_RELEASE ? "Publish" :
            ($s == STATUS_REVIEW ? "Review" :
                ($s == STATUS_FUTURE ? "Future" : '')));
}

function smarty_function_mtentrystatus($args, &$ctx) {
    $entry = $ctx->stash('entry');
    return status_text($entry['entry_status']);
}
?>
