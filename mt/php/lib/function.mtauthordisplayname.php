<?php
# Movable Type (r) (C) 2001-2008 Six Apart, Ltd. All Rights Reserved.
# This code cannot be redistributed without permission from www.sixapart.com.
# For more information, consult your Movable Type license.
#
# $Id$

function smarty_function_mtauthordisplayname($args, &$ctx) {
    // status: complete
    // parameters: none
    $author = $ctx->stash('author');
    $author_name = $author['author_nickname'];
    $author_name or $author_name =
        $ctx->mt->translate('(Display Name not set)');
    return $author_name;
}
?>
