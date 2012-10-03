<?php
# Movable Type (r) (C) 2001-2008 Six Apart, Ltd. All Rights Reserved.
# This code cannot be redistributed without permission from www.sixapart.com.
# For more information, consult your Movable Type license.
#
# $Id$

function smarty_function_mtwidgetmanager($args, &$ctx) {
    $blog_id = $ctx->stash('blog_id');
    $widgetmanager = $args['name']; // Should we try to load is there's only one?
    if (!$widgetmanager) 
        return;

    if (! $config = widgetmanager_config($ctx)) 
        return;

    foreach (explode(",",$config['modulesets'][$widgetmanager]) as $template_id) {
      if ($template_id)
          $widget_source[] = $ctx->mt->fetch('mt:'.$template_id);
    }
    $source = '';
    if ($widget_source) {
        $source = implode('',$widget_source);
    }
    return $source;
}

function widgetmanager_config($ctx) {
    $config = $ctx->stash('widget-manager-config');
    if ($config)
        return $config;
    $blog_id = $ctx->stash('blog_id');
    $config = $ctx->mt->db->fetch_plugin_config('widget-manager', 'blog:' . $blog_id);
    if (!$config)
        $config = $ctx->mt->db->fetch_plugin_config('widget-manager');

    if ($config) {
        $ctx->stash('widget-manager-config', $config);
    }
    return $config;
}
?>
