<?php
# Movable Type (r) (C) 2001-2008 Six Apart, Ltd. All Rights Reserved.
# This code cannot be redistributed without permission from www.sixapart.com.
# For more information, consult your Movable Type license.
#
# $Id: function.mtentryexcerpt.php 1174 2008-01-08 21:02:50Z bchoate $

function smarty_function_mtentryexcerpt($args, &$ctx) {
    // todo: needs work
    $e = $ctx->stash('entry');
    if ($excerpt = $e['entry_excerpt']) {
        if ((!isset($args['convert_breaks'])) || (!$args['convert_breaks'])) {
            return $excerpt;
        }
        #$filters = $e['entry_text_filters'];
        #push @$filters, '__default__' unless @$filters;
        #return MT->apply_text_filters($excerpt, $filters, $ctx);
    } elseif ($args['no_generate']) {
        return '';
    }
    $blog = $ctx->stash('blog');
    $words = $blog['blog_words_in_excerpt'];
    if (!isset($words) or empty($words)) {
        $words = 40;
    }
    $args['words'] = $words;
    $excerpt = $ctx->tag('MTEntryBody', $args);
    if (!$excerpt) {
        return '';
    }
    return $excerpt . '...';
}
/*
    $cb = $entry['entry_convert_breaks'];
    if ($cb) {
        if (($cb == '1') || ($cb == '__default__')) {
            # alter EntryBody, EntryMore in the event that
            # we're doing convert breaks
            $cb = 'convert_breaks';
        }
        if ($cb) {
            # invoke modifier to format
            $ctx->load_modifier($cb);
            $mod = 'smarty_modifier_'.$cb;
            $text = $mod($text);
        }
    }
*/
?>
