<?php
# Movable Type (r) (C) 2001-2008 Six Apart, Ltd. All Rights Reserved.
# This code cannot be redistributed without permission from www.sixapart.com.
# For more information, consult your Movable Type license.
#
# $Id$

function smarty_function_mtentrybasename($args, &$ctx) {
    $entry = $ctx->stash('entry');
    if (!$entry) return '';
    return $entry['entry_basename'];
}
?>
