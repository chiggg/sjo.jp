<?php
# Movable Type (r) (C) 2007 Six Apart, Ltd. All Rights Reserved.
# This code cannot be redistributed without permission from www.sixapart.com.
# For more information, consult your Movable Type license.
#
# $Id$

# Original Copyright (c) 2005-2007 Arvind Satyanarayan

global $mt;
$ctx = &$mt->context();

define('CUSTOMFIELDS_ENABLED', 1);

global $customfield_types;
$customfield_types or $customfield_types = array();
init_core_customfield_types();

# Because it's hard to map tags back to their fields, we store them in a hash
global $customfields_custom_handlers;
$customfields_custom_handlers = array();

# Loop through fields and register the custom template tag handlers
$fields = $ctx->mt->db->get_results("select * from mt_field", ARRAY_A);
foreach ($fields as $field) {
    $tag_name = strtolower($field['field_tag']);
    $customfields_custom_handlers[$tag_name] = $field;

    $fn = <<<CODE
function customfield_$tag_name (\$args, &\$ctx) {
    return _hdlr_customfield_value(\$args, \$ctx, '$tag_name');
}
CODE;
    eval($fn);
    $ctx->add_tag($tag_name, 'customfield_' . $tag_name);

    if(preg_match('/^asset/', $field['field_type'])) {
        $asset_fn = <<<CODE
function customfield_asset_$tag_name(\$args, \$content, &\$ctx, &\$repeat) {
    return _hdlr_customfield_asset(\$args, \$content, \$ctx, \$repeat, '$tag_name');
}
CODE;
        eval($asset_fn);
        $ctx->add_container_tag($tag_name . 'asset', 'customfield_asset_' . $tag_name);
    }
}

# Loop through all the custom field object types and register the MT*CustomField(s) tags
$customfield_object_types = array('entry', 'page', 'category', 'folder', 'author');
foreach ($customfield_object_types as $type) {
    $customfields_fn = <<<CODE
function customfields_$type(\$args, \$content, &\$ctx, &\$repeat) {
    return _hdlr_customfields(\$args, \$content, \$ctx, \$repeat, '$type');
}
CODE;

    $customfield_name_fn = <<<CODE
function customfield_name_$type(\$args, &\$ctx) {
    return _hdlr_customfield_name(\$args, \$ctx);
}
CODE;

    $customfield_description_fn = <<<CODE
function customfield_description_$type(\$args, &\$ctx) {
    return _hdlr_customfield_description(\$args, \$ctx);
}
CODE;

    $customfield_value_fn = <<<CODE
function customfield_value_$type(\$args, &\$ctx) {
    return _hdlr_customfield_value(\$args, \$ctx);
}
CODE;

    eval($customfields_fn);
    eval($customfield_name_fn);
    eval($customfield_description_fn);
    eval($customfield_value_fn);

    $ctx->add_container_tag($type.'customfields', 'customfields_'.$type);
    $ctx->add_tag($type.'customfieldname', 'customfield_name_'.$type);
    $ctx->add_tag($type.'customfielddescription', 'customfield_description_'.$type);
    $ctx->add_tag($type.'customfieldvalue', 'customfield_value_'.$type);
}
$ctx->add_tag('customfieldname', '_hdlr_customfield_name');
$ctx->add_tag('customfielddescription', '_hdlr_customfield_description');
$ctx->add_tag('customfieldvalue', '_hdlr_customfield_value');
$ctx->add_tag('customfieldhtml', '_hdlr_customfield_html');

# PHP implementation of CustomFields::Util::get_meta
function get_meta(&$ctx, $obj, $obj_type) {
    $real_type = $obj_type;
    if ('page' == strtolower($obj_type))
        $real_type = 'entry';
    elseif ('folder' == strtolower($obj_type))
        $real_type = 'category';

    $obj_id = $obj[$real_type.'_id'];
    $blog_id = $obj[$real_type.'_blog_id'];

    $meta = $ctx->stash("${obj_type}_meta_${obj_id}");
    if (!$meta) {
        $datasource = $real_type;
        $datasource = preg_replace("/^mt_/", "", $datasource);
        $result = $ctx->mt->db->get_results("select * from mt_$datasource where ${datasource}_id = $obj_id", ARRAY_A);
        if ($result && array_key_exists("${real_type}_customfields", $result[0])) {
            $meta = $result[0]["${real_type}_customfields"];
        } else {
            $meta = $ctx->mt->db->fetch_plugin_data('CustomFields', "${obj_type}_${obj_id}");
            if ($meta)
                $meta = $meta['customfields'];
        }
        $ctx->stash("${obj_type}_meta_${obj_id}", $meta);
    }

    return $meta;
}

# PHP implementation of CustomFields::Template::ContextHandlers::_hdlr_customfield_obj
function _hdlr_customfield_obj(&$ctx, $obj_type) {
    # Pages and folders stash as entries and categories respectively so lets change $obj_type
    if($obj_type == 'page')
        $obj_type = 'entry';
    elseif($obj_type == 'folder')
        $obj_type = 'category';

    $obj = $ctx->stash($obj_type);

    # In PHP, we only need to test for this because archive_category doesn't exist
    if(!$obj && $obj_type == 'author') {
        $entry = $ctx->stash('entry');
        if(!$entry) return '';

        $entry_id = $entry['entry_id'];
        # We need to cache this puppy as much as possible
        $obj = $ctx->stash("entry_${entry_id}_author");
        if(!$obj) {
            $author_id = $entry['entry_author_id'];
            $obj = $ctx->mt->db->get_row("select * from mt_author where author_id = $author_id", ARRAY_A);
            $ctx->stash("entry_${entry_id}_author", $obj);
        }
    }

    return $obj;
}

# PHP implementation of CustomFields::Template::ContextHandlers::_hdlr_customfields
function _hdlr_customfields($args, $content, &$ctx, &$repeat, $obj_type = null) {
    $localvars = array('fields', '_fields_counter', 'field', 'blog', 'blog_id');
    if (!isset($content)) {
        $ctx->localize($localvars);
        global $mt;
        $blog_id = $ctx->stash('blog_id');

        $exclude = array();
        if (isset($args['exclude'])) {
            foreach ( preg_split('/\s*,\s*/', $args['exclude']) as $f )
                $exclude[strtolower($f)] = 1;
        }

        $include = array();
        if (isset($args['include'])) {
            foreach ( preg_split('/\s*,\s*/', $args['include']) as $f )
                array_push($include, "'" . $mt->db->escape($f) . "'");
        }

        $sql = "select * from mt_field where field_blog_id in (0, $blog_id) and field_obj_type = '$obj_type'";
        if ( count($include) ) {
            $sql .= " and field_name in (";
            $sql .= implode( ',', $include );
            $sql .= ")";
        }

        $all_fields = $ctx->mt->db->get_results($sql);
        $fields = array();
        foreach ( $all_fields as $f ) {
            if ( array_key_exists( strtolower($f['field_name']), $exclude ) )
                continue;
            array_push( $fields, $f );
        }
        $ctx->stash('fields', $fields);
        $counter = 0;
    } else {
        $fields = $ctx->stash('fields');
        $counter = $ctx->stash('_fields_counter');
    }
    if ($counter < count($fields)) {
        $field = $fields[$counter];
        $ctx->stash('field', $field);
        $ctx->stash('_fields_counter', $counter + 1);
        $repeat = true;
    } else {
        $ctx->restore($localvars);
        $repeat = false;
    }
    return $content;
}

# PHP implementation of CustomFields::Template::ContextHandlers::_hdlr_customfield_name
function _hdlr_customfield_name($args, &$ctx) {
    $field = $ctx->stash('field');
    return $field['field_name'];
}

# PHP implementation of CustomFields::Template::ContextHandlers::_hdlr_customfield_description
function _hdlr_customfield_description($args, &$ctx) {
    $field = $ctx->stash('field');
    return $field['field_description'];
}

# PHP implementation of CustomFields::Template::ContextHandlers::_hdlr_customfield_value
function _hdlr_customfield_value($args, &$ctx, $tag = null) {
    global $customfields_custom_handlers;
    $field = $ctx->stash('field');
    $field or $field = $customfields_custom_handlers[$tag];
    if(!$field) return '';

    $obj = _hdlr_customfield_obj($ctx, $field['field_obj_type']);

    if(!isset($obj) || empty($obj)) return '';

    $meta = get_meta($ctx, $obj, $field['field_obj_type']);
    $text = $meta[$field['field_basename']];
    if (preg_match('/\smt:asset-id="\d+"/', $text) && !$args['no_asset_cleanup']) {
        require_once("MTUtil.php");
        $text = asset_cleanup($text);
    }

    if($field['field_type'] == 'textarea') {
        $cb = $obj['entry_convert_breaks'];
        if (isset($args['convert_breaks'])) {
            $cb = $args['convert_breaks'];
        } elseif (!isset($cb)) {
            $blog = $ctx->stash('blog');
            $cb = $blog['blog_convert_paras'];
        }
        if ($cb) {
            if (($cb == '1') || ($cb == '__default__')) {
                # alter EntryBody, EntryMore in the event that
                # we're doing convert breaks
                $cb = 'convert_breaks';
            }
            if ($cb) {
                # invoke modifier to format
                if ($ctx->load_modifier($cb)) {
                    $mod = 'smarty_modifier_'.$cb;
                    $text = $mod($text);
                }
            }
        }
    }

    if($field['field_type'] == 'datetime') {
        $text = preg_replace('/\D/', '', $text);
        if (($text == '') or ($text == '00000000'))
            return '';
        if (strlen($text) == 8) {
            $text .= '000000';
        }
        $args['ts'] = $text;
        return $ctx->_hdlr_date($args, $ctx);
    }

    return $text;
}

function _hdlr_customfield_asset($args, $content, &$ctx, &$repeat, $tag = null) {
    $localvars = array('assets', 'asset', '_assets_counter', 'blog', 'blog_id');
    if (!isset($content)) {
        $ctx->localize($localvars);
        $blog_id = $ctx->stash('blog_id');

        $args['no_asset_cleanup'] = 1;
        $value = _hdlr_customfield_value($args, $ctx, $tag);

        $args['blog_id'] = $blog_id;
        if(preg_match('!<form[^>]*?\smt:asset-id=["\'](\d+)["\'][^>]*?>(.+?)</form>!gis', $value, $matches)) {
            $args['id'] = $matches[1];
        }

        $assets = $ctx->mt->db->fetch_assets($args);
        $ctx->stash('assets', $assets);
        $counter = 0;
    } else {
        $assets = $ctx->stash('assets');
        $counter = $ctx->stash('_assets_counter');
    }
    if ($counter < count($assets)) {
        $asset = $assets[$counter];
        $ctx->stash('asset', $asset);
        $ctx->stash('_assets_counter', $counter + 1);
        $repeat = true;
    } else {
        $ctx->restore($localvars);
        $repeat = false;
    }
    return $content;
}

function _hdlr_customfield_html($args, &$ctx) {
    global $customfield_types;

    $field = $ctx->stash('field');
    $type = $field['field_type'];
    $basename = $field['field_basename'];

    $type_obj = $customfield_types[$type];
    if (!$type_obj) return '';

    $row = $field;
    $row['field_blog_id'] or $row['field_blog_id'] = 0;
    $row['field_value'] = _hdlr_customfield_value(array(), $ctx);
    if (array_key_exists('options_delimiter', $type_obj)) {
        $option_loop = array();
        $expr = '\s*' . preg_quote($type_obj['options_delimiter']) . '\s*';
        $options = preg_split('/' . $expr . '/', $field['field_options']);
        foreach ($options as $option) {
            $option_row = array( 'option' => $option );
            $option_row['is_selected'] = isset($row['field_value']) ? ($row['field_value'] == $option) : 0;
            $option_loop[] = $option_row;
        }
        $row['option_loop'] = $option_loop;
    }
    $row['show_field'] = ($field['field_obj_type'] == 'entry') ? 0 : 1;
    $row['show_hint'] = $type != 'checkbox' ? 1 : 0;
    $row['field_id'] = $row['field_name'] = "customfield_$basename";
    $row['simple'] = 1;

    $fn = $type_obj['field_html'];
    if ( is_array($fn) ) {
        $buf = $fn[ $field['field_obj_type'] ];
        if (!isset($buf))
            $buf = $fn['default'];
        $fn = $buf;
    }
    if (function_exists($fn)) {
        $contents = call_user_func_array($fn, array(&$ctx, $row));
    } else {
        $contents = '';
    }
    return $contents;
}

function customfield_html_textarea(&$ctx, $param) {
    extract($param);
    require_once("MTUtil.php");
    $field_name = encode_html($field_name);
    $field_value = encode_html($field_value);
    return <<<EOT
<textarea name="$field_name" id="$field_id" class="full-width ta" rows="3" cols="72">$field_value</textarea>
EOT;
}

function customfield_html_textarea_author(&$ctx, $param) {
    extract($param);
    require_once("MTUtil.php");
    $field_name = encode_html($field_name);
    $field_value = encode_html($field_value);
    return <<<EOT
<textarea name="$field_name" id="$field_id" class="half-width" rows="3" cols="72">$field_value</textarea>
EOT;
}

function customfield_html_text(&$ctx, $param) {
    extract($param);
    require_once("MTUtil.php");
    $field_name = encode_html($field_name);
    $field_value = encode_html($field_value);
    return <<<EOT
<div class="textarea-wrapper">
<input type="text" name="$field_name" id="$field_id" value="$field_value" class="full-width ti" />
</div>
EOT;
}

function customfield_html_text_author(&$ctx, $param) {
    extract($param);
    require_once("MTUtil.php");
    $field_name = encode_html($field_name);
    $field_value = encode_html($field_value);
    return <<<EOT
<input type="text" name="$field_name" id="$field_id" value="$field_value" class="half-width" />
EOT;
}

function customfield_html_checkbox(&$ctx, $param) {
    extract($param);
    require_once("MTUtil.php");
    $field_name = encode_html($field_name);
    $field_value = encode_html($field_value);
    $field_description = encode_html($field_description);
    $checked = '';
    if ($field_value)
        $checked = ' checked="checked"';
    return <<<EOT
<p class="hint"><input type="hidden" name="${field_name}_cb_beacon" value="1" /><input type="checkbox" name="$field_name" value="1" id="$field_id"$checked class="cb" /> <label for="$field_id">$field_description</label></p>
EOT;
}

function customfield_html_url(&$ctx, $param) {
    extract($param);
    require_once("MTUtil.php");
    $field_name = encode_html($field_name);
    $field_value = encode_html($field_value);
    return <<<EOT
<div class="textarea-wrapper">
    <input type="text" name="$field_name" id="$field_id" value="$field_value" class="full-width ti" />
</div>
EOT;
}

function customfield_html_url_author(&$ctx, $param) {
    extract($param);
    require_once("MTUtil.php");
    $field_name = encode_html($field_name);
    $field_value = encode_html($field_value);
    return <<<EOT
    <input type="text" name="$field_name" id="$field_id" value="$field_value" class="half-width" />
EOT;
}

function customfield_html_datetime(&$ctx, $param) {
    extract($param);
    require_once("MTUtil.php");
    $blog =& $ctx->stash('blog');
    $field_name = encode_html($field_name);
    $field_value = encode_html($field_value);
    $ts = $field_value;
    $ts = preg_replace('/\D/', '', $ts);
    $date = format_ts("%Y-%m-%d", $ts, $blog);
    $time = format_ts("%H:%M:%S", $ts, $blog);

    if ($field_options != 'time') {
        $html1 = <<<EOT
<input id="d_$field_name" class="entry-date" name="d_$field_name" value="$date" />
EOT;
    } else {
        $html1 = <<<EOT
<input type="hidden" id="d_$field_name" name="d_$field_name" value="" />
EOT;
    }
    if ($field_options != 'date') {
        $html2 = <<<EOT
<input class="entry-time" name="t_$field_name" value="$time" />
EOT;
    } else {
        $html2 = <<<EOT
<input type="hidden" id="t_$field_name" name="t_$field_name" value="" />
EOT;
    }
    return <<<EOT
<span class="date-time-fields">
$html1
$html2
</span>
EOT;
}

function customfield_html_select(&$ctx, $param) {
    extract($param);
    require_once("MTUtil.php");
    $blog =& $ctx->stash('blog');
    $field_name = encode_html($field_name);
    $field_value = encode_html($field_value);

    $loop = '';
    foreach ($option_loop as $option) {
        $opt = encode_html($option['option']);
        if ($option['is_selected'])
            $selected = " selected='selected'";
        else
            $selected = '';
        $loop .= <<<EOT
    <option value="$opt"$selected>$opt</option>
EOT;
    }

    return <<<EOT
<select name="$field_name" id="$field_id" class="se">
$loop
</select>
EOT;
}

function customfield_html_radio(&$ctx, $param) {
    extract($param);
    require_once("MTUtil.php");
    $blog =& $ctx->stash('blog');
    $field_name = encode_html($field_name);
    $field_value = encode_html($field_value);

    $html = '';
    $i = 0;
    foreach ($option_loop as $option) {
        $i++;
        $opt = encode_html($option['option']);
        if (isset($option['is_selected']))
            $selected = " checked='checked'";
        else
            $selected = '';
        $html .= <<<EOT
<label for="${field_id}_${i}"><input type="radio" name="$field_name" value="$opt" id="${field_id}_{$i}>"$selected class="rb" /> $opt</label>
EOT;
    }

    return $html;
}

function customfield_html_image(&$ctx, $param) {
    $param['asset_type'] = 'image';
    return customfield_html_asset($ctx, $param);
}
function customfield_html_video(&$ctx, $param) {
    $param['asset_type'] = 'video';
    return customfield_html_asset($ctx, $param);
}
function customfield_html_audio(&$ctx, $param) {
    $param['asset_type'] = 'audio';
    return customfield_html_asset($ctx, $param);
}
function customfield_html_file(&$ctx, $param) {
    $param['asset_type'] = 'file';
    return customfield_html_asset($ctx, $param);
}
function customfield_html_asset(&$ctx, $param) {
    extract($param);
    require_once("MTUtil.php");
    $field_name = encode_html($field_name);
    $field_value = encode_html($field_value);

    return <<<EOT
<div class="field-content ">
    <input type="file" name="file_$field_name" id="entry-file" class="fi" />
    <input type="hidden" name="type_$field_name" value="$asset_type" />
</div>
EOT;
}
function init_core_customfield_types() {
    global $customfield_types;
    $customfield_types['text'] = array(
        'field_html' => array (
            'default' => 'customfield_html_text',
            'author' => 'customfield_html_text_author'
        )
    );
    $customfield_types['textarea'] = array(
        'field_html' => array (
            'default' => 'customfield_html_textarea',
            'author' => 'customfield_html_textarea_author'
        )
    );
    $customfield_types['checkbox'] = array(
        'field_html' => 'customfield_html_checkbox'
    );
    $customfield_types['url'] = array(
        'field_html' => array (
            'default' => 'customfield_html_url',
            'author' => 'customfield_html_url_author'
        )
    );
    $customfield_types['datetime'] = array(
        'field_html' => 'customfield_html_datetime'
    );
    $customfield_types['select'] = array(
        'field_html' => 'customfield_html_select',
        'options_delimiter' => ','
    );
    $customfield_types['radio'] = array(
        'field_html' => 'customfield_html_radio',
        'options_delimiter' => ','
    );
    $customfield_types['asset'] = array(
        'field_html' => 'customfield_html_file'
    );
    $customfield_types['asset.image'] = array(
        'field_html' => 'customfield_html_image'
    );
    $customfield_types['asset.audio'] = array(
        'field_html' => 'customfield_html_audio'
    );
    $customfield_types['asset.video'] = array(
        'field_html' => 'customfield_html_video'
    );
}
?>
