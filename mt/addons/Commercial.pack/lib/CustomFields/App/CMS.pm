# Movable Type (r) (C) 2007 Six Apart, Ltd. All Rights Reserved.
# This code cannot be redistributed without permission from www.sixapart.com.
# For more information, consult your Movable Type license.
#
# $Id$

# Original Copyright (c) 2005-2007 Arvind Satyanarayan

package CustomFields::App::CMS;

use strict;
use CustomFields::Util qw( get_meta save_meta field_loop _get_html );
use MT::Util qw( remove_html dirify encode_html );

sub load_list_filters {
    my $plugin = shift;
    my $app = MT->app;
    my $blog_id = $app->param('blog_id') || undef;
    my %filters;
    my $objects = MT->registry('customfield_objects');
    foreach my $object ( keys %$objects ) {
        next if defined($blog_id) && $objects->{$object}{context} eq 'system';

        my $class = MT->model($object);
        $filters{"cf_list_$object"} = {
            label   => sub {
                $plugin->translate('[_1] Fields', $class->class_label_plural)
            },
            handler => sub {
                my ( $terms, $args ) = @_;
                $terms->{obj_type} = $object;
            },
        };
    }
    my @objects =
      sort { $filters{$a}{label} cmp $filters{$b}{label} } keys %filters;
    my $order = 100;
    foreach (@objects) {
        $filters{$_}{order} = $order;
        $order += 100;
    }
    $filters{cf_list_entry}{order} = 0;
    return { field => \%filters };
}

sub load_customfield_types {
    my $customfield_types = {
        # type_key => {
        #   label => ' ',
        #   order => 999,
        #   field_html => ''
        #   options_field => '',
        #   options_delimiter => '',
        #   default_value => '',
        #   column_def => ''
        # },
        'text' => {
            label => 'Single-Line Text',
            field_html => {
                default => q{
                    <div class="textarea-wrapper">
                        <input type="text" name="<mt:var name="field_name">" id="<mt:var name="field_id">" value="<mt:var name="field_value" escape="html">" class="full-width ti" />
                    </div>
                },
                author => q{
                    <input type="text" name="<mt:var name="field_name">" id="<mt:var name="field_id">" value="<mt:var name="field_value" escape="html">" class="half-width" />
                },
            },
            column_def => 'string(255)',
            order => 100
        },
        'textarea' => {
            label => 'Multi-Line Textfield',
            field_html => {
                default => q{
                    <div class="textarea-wrapper"><textarea name="<mt:var name="field_name">" id="<mt:var name="field_id">" class="full-width ta" rows="3" cols="72"><mt:var name="field_value" escape="html"></textarea></div>
                },
                author => q{
                    <textarea name="<mt:var name="field_name">" id="<mt:var name="field_id">" class="half-width" rows="3" cols="72"><mt:var name="field_value" escape="html"></textarea>
                },
            },
            column_def => 'text',
            order => 200
        },
        'checkbox' => {
            label => 'Checkbox',
            field_html => q{
                <p class="hint"><input type="hidden" name="<mt:var name="field_name">_cb_beacon" value="1" /><input type="checkbox" name="<mt:var name="field_name">" value="1" id="<mt:var name="field_id">"<mt:if name="field_value"> checked="checked"</mt:if> class="cb" /> <label for="<mt:var name="field_id">"><mt:var name="description"></label></p>
            },
            column_def => 'boolean',
            order => 300
        },
        'url' => {
            label => 'URL',
            field_html => {
                default => q{
                    <div class="textarea-wrapper">
                        <input type="text" name="<mt:var name="field_name">" id="<mt:var name="field_id">" value="<mt:var name="field_value" escape="html">" class="full-width ti" />
                    </div>
                },
                author => q{
                    <input type="text" name="<mt:var name="field_name">" id="<mt:var name="field_id">" value="<mt:var name="field_value" escape="html">" class="half-width" />
                },
            },
            default_value => 'http://',
            column_def => 'string(255)',
            order => 400,           
        },
        'datetime' => {
            label => 'Date and Time',
            field_html => 'date-picker.tmpl',
            field_html_params => sub {
                my ($key, $tmpl_key, $tmpl_param) = @_;

                my $app = MT->instance;
                my $blog = $app->blog;
                my $ts = $tmpl_param->{value} || '';
                if (ref $ts) {
                    $tmpl_param->{'date'} = $ts->{'date'};
                    $tmpl_param->{'time'} = $ts->{'time'};
                    return;
                }
                $ts =~ s/\D//g;

                if ($ts) {
                    require MT::Util;
                    $tmpl_param->{date} = MT::Util::format_ts( "%Y-%m-%d", $ts, $blog, $app->user ? $app->user->preferred_language : undef );
                    $tmpl_param->{time} = MT::Util::format_ts( "%H:%M:%S", $ts, $blog, $app->user ? $app->user->preferred_language : undef );
                }
            },
            options_field => q{
                <__trans phrase="Show">: <select name="options" id="options">
                    <option value="datetime"<mt:if name="options" eq="datetime"> selected="selected"</mt:if>><__trans phrase="Date & Time"></option>
                    <option value="date"<mt:if name="options" eq="date"> selected="selected"</mt:if>><__trans phrase="Date Only"></option>
                    <option value="time"<mt:if name="options" eq="time"> selected="selected"</mt:if>><__trans phrase="Time Only"></option>
                </select>
            },
            no_default => 1,
            order => 500,
            column_def => 'datetime'
        },
        'select' => {
            label => 'Drop Down Menu',
            field_html => q{
                    <select name="<mt:var name="field_name">" id="<mt:var name="field_id">" class="se" mt:watch-change="1">
                        <mt:loop name="option_loop">
                            <option value="<mt:var name="option" escape="html">"<mt:if name="is_selected"> selected="selected"</mt:if>><mt:var name="option" escape="html"></option>
                        </mt:loop>
                    </select>
            },
            options_field => q{
                <div class="textarea-wrapper"><input type="text" name="options" value="<mt:var name="options" escape="html">" id="options" class="full-width" /></div>
                <p class="hint"><__trans phrase="Please enter all allowable options for this field as a comma delimited list"></p>
            },
            options_delimiter => ',',
            column_def => 'string(255)',
            order => 600
        },
        'radio' => {
            label => 'Radio Buttons',
            field_html => q{
                    <mt:loop name="option_loop">
                        <label for="<mt:var name="field_id">_<mt:var name="__counter__">"><input type="radio" name="<mt:var name="field_name">" value="<mt:var name="option" escape="html">" id="<mt:var name="field_id">_<mt:var name="__counter__">"<mt:if name="is_selected"> checked="checked"</mt:if> class="rb" /> <mt:var name="option" escape="html"></label>
                    </mt:loop>
            },
            options_field => q{
                <div class="textarea-wrapper"><input type="text" name="options" value="<mt:var name="options" escape="html">" id="options" class="full-width" /></div>
                <p class="hint"><__trans phrase="Please enter all allowable options for this field as a comma delimited list"></p>
            },
            options_delimiter => ',',
            column_def => 'string(255)',
            order => 700
        }
    };

    # Add asset choosers
    require MT::Asset;
    my $asset_types = MT::Asset->class_labels;
    my @asset_types =
      sort { $asset_types->{$a} cmp $asset_types->{$b} } keys %$asset_types;

    my $order = 800;
    foreach my $a_type (@asset_types) {
        my $asset_type = $a_type;
        $asset_type =~ s/^asset\.//;
        $customfield_types->{$a_type} = {
            label   => sub { MT::Asset->class_handler($a_type)->class_label },
            field_html => 'asset-chooser.tmpl',
            field_html_params => sub {
                $_[2]->{asset_type} = $asset_type;
                $_[2]->{asset_type_label} = MT->translate($asset_type);
            },
            no_default => 1,
            column_def => 'text',
            order => $order,
            context => 'blog'
        };
        $order += 100;
    }

    return $customfield_types;
}

sub list_field {
    my ($app) = @_;
    my $plugin = $app->component('Commercial');
    my $q = $app->param;

    my $blog_id = $q->param('blog_id');
    return $app->errtrans("Permission denied.") if !$app->user->is_superuser && !$blog_id;
    my (@customfield_objs);

    my $hasher = sub {
        my ($obj, $row) = @_;
        my $type_def = $app->registry('customfield_types', $obj->type);
        my $class = $app->model($obj->obj_type);

        $row->{type_label} = $type_def->{label};
        $row->{obj_type_label} = $class->class_label;

        my $fld_blog_id = $obj->blog_id;
        if(!$blog_id && $fld_blog_id) {
            require MT::Blog;
            my $fld_blog = MT::Blog->load($fld_blog_id);
            $row->{blog_name} = $fld_blog ? $fld_blog->name : "* " . $app->translate('Orphaned') . " *";
        }

    };

    $app->add_breadcrumb($app->translate("Custom Fields"));

    return $app->listing({
        terms => {
            $blog_id ? ( blog_id => [ $blog_id, 0 ] ) : ()
        },
        args => { sort => 'name', 'direction' => 'ascend' },
        no_limit => 1,
        type => 'field',
        code => $hasher,
        template => File::Spec->catdir($plugin->path,'tmpl','list_field.tmpl'),
        params => {
            ($blog_id ? (
                blog_id => [ $blog_id, 0 ],
                edit_blog_id => $blog_id,
            ) : ( system_overview => 1 )),
            list_noncron => 1,
            saved_deleted => $q->param('saved_deleted') || 0,
            saved => $q->param('saved') || 0,
            obj_types_loop => \@customfield_objs,
            cfg_customfield => 1,
            use_plugins => $app->config->UsePlugins
        },
    });
}

sub edit_field {
    my ($app, $param) = @_;
    my $q = $app->param;
    my $plugin = $app->component("Commercial");

    my $blog = $app->blog;
    my $blog_id = $blog ? $blog->id : 0;
    return $app->errtrans("Permission denied.") if !$app->user->is_superuser && !$blog_id;
    my $id = $app->param('id');

    my (@obj_types, @types_loop);

    require CustomFields::Field;
    for my $key (@{ CustomFields::Field->column_names() }) {
        if (my $val = $q->param($key)) {
            $param->{$key} = $val;
        }
    }
    $param->{object_label} = CustomFields::Field->class_label;

    my $obj_type = $q->param('obj_type');

    if ($id) {
        my $field = CustomFields::Field->load( { blog_id => $blog_id, id => $id } );
        $app->redirect(
            $app->uri( mode => 'list_field', args => { blog_id => $blog_id } ) ) if !$field;
        $obj_type ||= $field->obj_type;
        while (my ($key, $val) = each %{ $field->column_values() }) {
            $param->{$key} ||= encode_html($val);
        }
    }

    $param->{basename_limit} = ( $blog ? $blog->basename_limit : 0 ) || 30;

    my $customfield_objs = $app->registry('customfield_objects');

    foreach my $key (keys %$customfield_objs) {
        my $context = $customfield_objs->{$key}->{context};
        next if $context eq 'blog' && !$blog_id;
        next if $context eq 'system' && $blog_id;

        my $class = $app->model($key);
        push @obj_types, {
            obj_type => $key,
            obj_type_label => ucfirst($class->class_label),
            ($obj_type && $key eq $obj_type) ? ( selected => 1) : ()
        };
    }

    my $customfield_types = $app->registry('customfield_types');
    my @customfield_types_loop;

    # Resort it by the order key
    my @cf_types =
      sort { $customfield_types->{$a}{order} <=> $customfield_types->{$b}{order} } keys %$customfield_types;

    foreach my $key (@cf_types) {
        next if ref $key eq 'HASH';
        my $type = $customfield_types->{$key};

        my $context = $customfield_types->{$key}->{context} || '';
        next if $context eq 'blog' && !$blog_id;
        next if $context eq 'system' && $blog_id;

        # This $tmpl_param is used to build the default field and options field
        my $tmpl_param = $param;
        $tmpl_param->{key} = $key;
        $tmpl_param->{field_name} = 'default';
        $tmpl_param->{field_id} = 'default';
        $tmpl_param->{field_value} = $id ? $param->{default} : ( $param->{default} || $type->{default_value} );
        $tmpl_param->{options} = $param->{options};

        # If an options_delimiter is present, we need to populate an option_loop        
        if($type->{options_delimiter} && $param->{options}) {
            my @option_loop;
            my $expr = '\s*' . $type->{options_delimiter} . '\s?';
            my @options = split /$expr/, $param->{options};
            foreach my $option (@options) {
                my $option_row = { option => $option };
                $option_row->{is_selected} = defined $tmpl_param->{field_value} ? ($tmpl_param->{field_value} eq $option) : 0;          
                push @option_loop, $option_row;
            }
            $tmpl_param->{option_loop} = \@option_loop;         
        }

        my $row = {
            key => $key,
            label => $type->{label},
            $type->{no_default} ? ( ) : ( default_field => _get_html($key, 'field_html', $tmpl_param) ),
            $type->{options_field} ? ( options_field => _get_html($key, 'options_field', $tmpl_param) ) : (),
            options_delimiter => $type->{options_delimiter}
        };

        foreach my $k (keys %$row) {
            my $value = $row->{$k};
            if (ref($value) eq 'CODE') { # handle coderefs
                $value = $value->(@_);
            }
            $row->{$k} = $value;
        }

        push @customfield_types_loop, $row;
    }

    $param->{customfield_types_loop} = \@customfield_types_loop;
    $param->{obj_type_loop} = \@obj_types;

    eval { require MT::Image; MT::Image->new or die; };
    $param->{do_thumb} = !$@ ? 1 : 0;
    $param->{saved} = $app->param('saved') || 0;
    $param->{cfg_customfield} = 1;
    # $param->{return_args} = $app->param('return_args');
    $app->add_breadcrumb($app->translate("Custom Fields"), 
        $app->uri('mode' => 'list_field', args => { $blog_id ? (blog_id => $blog_id) : () }));

    $app->add_breadcrumb($app->translate('Edit Field'));
    $app->build_page($plugin->load_tmpl('edit_field.tmpl'), $param);
}

# This routine decrements the schema_version stored for the plugin
# to automatically trigger an "upgrade"
sub prep_customfields_upgrade {
    my $plugin = shift;
    my ($app) = @_;

    my $cfg = MT->config;
    my $plugin_schema = $cfg->PluginSchemaVersion || {};
    $plugin_schema->{$plugin->id} = $plugin->schema_version - '0.0001';
    if (keys %$plugin_schema) {
        $cfg->PluginSchemaVersion($plugin_schema, 1);
    }
    $cfg->save_config;

    $app->call_return;
}

sub save_field_order {
    my $app = shift;

    return '' if !$app->user;

    my $author_id = $app->user->id;
    my $blog_id = $app->param('blog_id') || 0;
    my $obj_type = $app->param('_type');

    require MT::PluginData;
    my $plugindata = MT::PluginData->get_by_key({ plugin => 'CustomFields', key => "field_order_$author_id" });
    my $data = $plugindata->data || {};
    $data->{$blog_id} ||= {};
    $data->{$blog_id}->{$obj_type} = $app->param('order');
    $plugindata->data($data);
    $plugindata->save or die $plugindata->errstr;
}

sub CMSPostSave_customfield_objs {
    my ($cb, $app, $obj) = @_;
    my $q = $app->param;

    return 1 if !$q->param('customfield_beacon');

    my $meta;
    foreach ($q->param()) {
        next if $_ eq 'customfield_beacon';
        if (m/^customfield_(.*?)$/) {
            my $field_name = $1;
            if ( m/^customfield_(.+?)_cb_beacon$/ ) {
                $field_name = $1;
                $meta->{$field_name} = defined( $q->param("customfield_$field_name") )
                  ? $q->param("customfield_$field_name")
                  : '0';
            }
            else {
                $meta->{$field_name} = $q->param("customfield_$field_name");
            }
        }
    }

    save_meta($obj, $meta);
    1;
}

sub CMSSaveFilter_customfield_objs {
    my ( $eh, $app ) = @_;
    my $q = $app->param;
    return 1 if !$q->param('customfield_beacon');

    my $blog_id = $q->param('blog_id') || 0;
    my $obj_type = $app->param('_type');

    require CustomFields::Field;
    my $iter = CustomFields::Field->load_iter(
        {
            $blog_id ? ( blog_id => [ $blog_id, 0 ] ) : (),
            obj_type => $obj_type,
        }
    );

    my %fields;
    while ( my $field = $iter->() ) {
        my $row = $field->column_values();
        my $field_name = "customfield_" . $row->{basename};
        if ( $row->{type} eq 'datetime' ) {
            my $ts = '';
            if ($q->param("d_$field_name") || $q->param("t_$field_name")) {
                my $date = $q->param("d_$field_name");
                $date = '1970-01-01' if $row->{options} eq 'time';
                my $time = $q->param("t_$field_name");
                $time = '00:00:00' if $row->{options} eq 'date';
                my $ao =  $date . ' ' . $time;
                unless ( $ao =~
                    m!^(\d{4})-(\d{2})-(\d{2})\s+(\d{2}):(\d{2})(?::(\d{2}))?$! )
                {
                    return $eh->error(
                        $app->translate(
"Invalid date '[_1]'; dates must be in the format YYYY-MM-DD HH:MM:SS.",
                            $ao
                        )
                    );
                }
                my $s = $6 || 0;
                return $eh->error(
                    $app->translate(
"Invalid date '[_1]'; dates should be real dates.",
                        $ao
                    )
                  )
                  if (
                       $s > 59
                    || $s < 0
                    || $5 > 59
                    || $5 < 0
                    || $4 > 23
                    || $4 < 0
                    || $2 > 12
                    || $2 < 1
                    || $3 < 1
                    || ( MT::Util::days_in( $2, $1 ) < $3
                        && !MT::Util::leap_day( $0, $1, $2 ) )
                  );
                $ts = sprintf "%04d%02d%02d%02d%02d%02d", $1, $2, $3, $4, $5, $s;
            }
            $q->param( "$field_name", $ts );
        }
        elsif ( $row->{type} =~ m/^asset/ ) {
            if (my $file = $q->param("file_$field_name")) { # see asset-chooser.tmpl for parameter
                $q->param( "$field_name", $file );
            }
        }
        elsif ( ( $row->{type} eq 'url' ) && $q->param($field_name) ) {
            require MT::Util;
            return $eh->error( $app->translate("Please enter valid URL for the URL field: [_1]", $row->{name}) )
                unless MT::Util::is_url( $q->param($field_name) );
        }

        if ( $row->{required} ) {
            return $eh->error(
                $app->translate(
                    "Please enter some value for required '[_1]' field.", $row->{name})
            ) if !defined $q->param($field_name) || $q->param($field_name) eq '';
        }
    }

    1;
}

# Fixes bug where required checkbox became uncheckable
sub CMSPreSave_field {
    my ($cb, $app, $obj, $original) = @_;

    if($app->param('required') eq '') {
        $obj->required(0);
        $original->required(0);
    }

    if ( 'checkbox' eq $app->param('type')
      && ( $app->param('default_cb_beacon')
        && !$app->param('default') ) )
    {
        $obj->default('0');
    }    

    1;
}

# This callback is run only if the basename of the field changes
# and updates $meta to use the basename. Why am I sticking with basename
# and not using the field_id as in v2.0? Because basename makes a lot of
# operations (such as custom sorting and posting from a 3rd party client)
# MUCH faster since I don't need to LOAD customfields and can just use the 
# basenames in the key => value

sub CMSPostSave_field {
    my ($cb, $app, $field) = @_;
    my $q = $app->param;

    # If 'required' was not found, this field changes to not required.
    if (!$app->param('required')) {
        $field->required(0);
        $field->save;
    }

    # Dirify to tag name
    my $tag = MT::Util::dirify($field->tag);
    if ($tag ne $field->tag) {
        $field->tag($tag);
        $field->save;
    }

    # Sanitize
    my $sanitize_spec = $app->config->GlobalSanitizeSpec;
    my $blog = $app->blog;
    $sanitize_spec = $blog->sanitize_spec
        if $blog && $blog->sanitize_spec;
    require MT::Sanitize;
    my $description = $q->param('description');
    if ($description) {
        $description = MT::Sanitize->sanitize($description, $sanitize_spec);
        $field->description($description);
        $field->save;
    }

    # Skip if the basename hasn't been manually changed (or if it's for a new field)
    return 1 unless ($q->param('basename_manual') && $q->param('basename_old'));

    my $basename_old = $q->param('basename_old');
    my $basename_new = $field->basename;

    my $class = $app->model($field->obj_type);
    my $iter = $class->load_iter({
        $field->blog_id ? ( blog_id => $field->blog_id ) : ()
    });
    while (my $obj = $iter->()) {
        my $meta = get_meta($obj);
        next if !$meta->{$basename_old};
        # TODO: shouldn't we delete the old one?
        $meta->{$basename_new} = $meta->{$basename_old};
        save_meta($obj, $meta);
    }

    1;
}

sub CMSSaveFilter_field {
    my ($eh, $app) = @_;
    my $q = $app->param;

    # Are the required fields supplied?
    my @required_fields = qw( obj_type name type tag );
    if ($q->param('basename_manual')) {
        push @required_fields, 'basename';
    }
    for my $field (@required_fields) {
        if (!$q->param($field)) {
            return $eh->error( $app->translate("Please ensure all required fields have been filled in.") );
        }
    }

    my %terms;

    my $tag = MT::Util::dirify($q->param('tag'));
    return $eh->error( $app->translate("The template tag '[_1]' is an invalid tag name.", $q->param('tag')) )
        unless $tag;

    %terms = ( tag => $tag );
    if (my $id = $q->param('id')) {
        $terms{id} = { op => '!=', value => $id };
    }
    require CustomFields::Field;
    return $eh->error( $app->translate("The template tag '[_1]' is already in use.", $tag) )
        if CustomFields::Field->count(\%terms);

    # Is the basename already used?
    my $basename = $q->param('basename') || MT::Util::dirify($q->param('name'));

    %terms = ( basename => $basename );
    if (my $id = $q->param('id')) {
        $terms{id} = { op => '!=', value => $id };
    }
    if (my $blog_id = $q->param('blog_id')) {
        $terms{blog_id} = $blog_id;
    }
    return $eh->error( $app->translate("The basename '[_1]' is already in use.", $basename) )
        if CustomFields::Field->count(\%terms);

    if ( 'url' eq $q->param('type') && $q->param('default') ) {
        require MT::Util;
        return $eh->error( $app->translate("Default value must be valid URL.") )
            unless MT::Util::is_url( $q->param('default') );
    }

    1;
}

sub CMSPrePreview_customfield_objs {
    my ($cb, $app, $obj, $data) = @_;
    my $q = $app->param;

    return 1 if !$q->param('customfield_beacon');

    my $meta;
    foreach ($q->param()) {
        if (m/^(d_|t_)?customfield_(.*?)$/) {
            push @$data,
              {
                  data_name  => "$1customfield_$2",
                  data_value => scalar $q->param("$1customfield_$2")
              };
            next if $_ eq 'customfield_beacon';
            if ($1 eq 'd_' || $1 eq 't_') {
                my $date = $q->param("d_customfield_$2");
                $date = '1970-01-01' if $date eq '';
                my $time = $q->param("t_customfield_$2");
                $time = '00:00:00' if $time eq '';
                my $ts =  $date . ' ' . $time;
                $meta->{"$2"} = $ts;
            } else {
                $meta->{"$2"} = $q->param("customfield_$2");
            }
        }
    }

    $obj->meta('customfields', $meta);
    1;
}

# Transformer callbacks

sub add_reorder_widget {
    my ($cb, $app, $param, $tmpl) = @_;
    my $plugin = $cb->plugin;

    # Get our header include using the DOM
    my ($header);
    my $includes = $tmpl->getElementsByTagName('include');
    foreach my $include (@$includes) {
        if($include->[1]->{name} =~ /header.tmpl$/) {
            $header = $include;
            last;
        }
    }

    return 1 unless $header;

    require MT::Template;
    bless $header, 'MT::Template::Node';

    require File::Spec;
    my $reorder_widget_tmpl = File::Spec->catdir($plugin->path,'tmpl','reorder_fields.tmpl');
    my $reorder_widget = $tmpl->createElement('include', { name => $reorder_widget_tmpl });

    $tmpl->insertBefore($reorder_widget, $header);
}

sub add_app_fields {
    my ($cb, $app, $param, $tmpl, $marker, $where) = @_;

    # For some reason, directly calling app:fields doesn't populate
    # a field_loop param. So
    populate_field_loop($cb, $app, $param, $tmpl);

    # Where should include the DOM method to insert app:fields relative to the marker
    $where ||= 'insertAfter';

    # Marker can contain either a node or an ID of a node
    unless(ref $marker eq 'MT::Template::Node') {
        $marker = $tmpl->getElementById($marker);
    }

    my $appfields = $tmpl->createElement('app:fields');
    $tmpl->$where($appfields, $marker); 
}

# Although app:fields gives us the entire field loop, on the entry page
# we actually want the field_loop *before* we add the app:fields tag
sub populate_field_loop {
    my ($cb, $app, $param, $tmpl) = @_;
    my $plugin = $cb->plugin;
    my $q = $app->param;

    my $mode = $app->mode;
    my $blog_id = $q->param('blog_id');
    my $object_id = $q->param('id');
    my $object_type = $q->param('_type');
    my $is_entry = ($object_type eq 'entry' || $object_type eq 'page' || $mode eq 'cfg_entry');

    my %param = (
        $blog_id ? ( blog_id => $blog_id ) : (),
        ($mode eq 'cfg_entry') ? ( object_type => 'entry' ) :
                ( object_type => $object_type, object_id => $object_id )
    );
    $param->{field_loop} = field_loop(%param);
    foreach my $field (@{$param->{field_loop}}) {
        my $basename = $field->{basename};
        my $show = !$is_entry                                        ? 1
                 : $field->{required}                                ? 1
                 : $param->{"disp_prefs_show_customfield_$basename"} ? 1
                 :                                                     0
                 ;
        $field->{show_field} = $show;
    }
}

sub add_calendar_src {
    my ($cb, $app, $tmpl) = @_;
    my $plugin = $cb->plugin;

    my $js_include = <<TMPL;
<mt:setvarblock name="js_include" append="1">
<!--// this MUST loaded after mt.js // -->
<script type="text/javascript" src="<mt:var name="static_uri">js/edit.js?v=<mt:var name="mt_version" escape="url">"></script>
<mt:include name="include/calendar.tmpl">
</mt:setvarblock>
TMPL
    $$tmpl = $js_include . $$tmpl;
}

sub edit_entry_param {
    my ($cb, $app, $param, $tmpl) = @_;
    my $plugin = $cb->plugin;

    # YAY DOM
    # Add the custom fields to the customizable_fields and custom_fields javascript variables
    # for Display Options toggline
    my $header = $tmpl->getElementById('header_include');
    my $html_head = $tmpl->createElement('setvarblock', { name => 'html_head', append => 1 });
    my $innerHTML = q{
<script type="text/javascript">
/* <![CDATA[ */
    <mt:loop name="field_loop">
    customizable_fields.push('customfield_<mt:var name="basename">');
    <mt:if name="show_field">custom_fields.push('customfield_<mt:var name="basename">');</mt:if>
    </mt:loop>
/* ]]> */
</script>   
};
    $html_head->innerHTML($innerHTML);
    $tmpl->insertBefore($html_head, $header);

    # Add custom fields to the display options widget
    my $entry_fields = $tmpl->getElementById('entry_fields');
    my $text = <<HTML;
<ul>
<mt:loop name="field_loop">
    <li><label><input type="checkbox" name="custom_prefs" id="custom-prefs-customfield_<mt:var name="basename">" value="customfield_<mt:var name="basename">" onclick="setCustomFields(); return true"<mt:if name="show_field"> checked="checked"</mt:if><mt:if name="required"> disabled="disabled"</mt:if> class="cb" /> <mt:var name="name"></label></li>
</mt:loop>
</ul>
HTML
    my $fields_ul = $tmpl->createTextNode($text);
    $entry_fields->appendChild($fields_ul);

    # Add <mtapp:fields> before tags
    add_app_fields($cb, $app, $param, $tmpl, 'tags', 'insertBefore');

    # Finally display our reorder widget
    add_reorder_widget($cb, $app, $param, $tmpl);
}

sub edit_category_param {
    my ($cb, $app, $param, $tmpl) = @_;

    # Add <mtapp:fields> after description
    add_app_fields($cb, $app, $param, $tmpl, 'description', 'insertAfter');

    # Finally display our reorder widget
    add_reorder_widget($cb, $app, $param, $tmpl);
}

sub edit_author_param {
    my ($cb, $app, $param, $tmpl) = @_;

    # Add <mtapp:fields> after description
    add_app_fields($cb, $app, $param, $tmpl, 'url', 'insertAfter');

    # Finally display our reorder widget
    add_reorder_widget($cb, $app, $param, $tmpl);
}

sub asset_insert_param {
    my ($cb, $app, $param, $tmpl) = @_;
    my $plugin = $cb->plugin;

    return 1 unless $app->param('edit_field') =~ /customfield/;

    my $block = $tmpl->getElementById('insert_script');
    return 1 unless $block;
    $block->innerHTML(qq{top.insertCustomFieldAsset('<mt:var name="upload_html" escape="js">', '<mt:var name="edit_field">') });
}

sub cfg_content_nav_param {
    my ($cb, $app, $param, $tmpl) = @_;
    my $plugin = $cb->plugin;

    my $more = $tmpl->getElementById('more_items');
    return 1 unless $more;

    my $existing = $more->innerHTML;
    $more->innerHTML(<<HTML);
$existing
<li<mt:if name="cfg_customfield"> class="active"</mt:if>><a href="<mt:var name="script_url">?__mode=list_field<mt:if name="blog_id">&amp;blog_id=<mt:var name="blog_id"></mt:if>"><b><__trans_section component="commercial"><__trans phrase="Custom Fields"></__trans_section></b></a></li>  
HTML
}

sub cfg_entry_param {
    my ($cb, $app, $param, $tmpl) = @_;
    my $plugin = $cb->plugin;

    my $more = $tmpl->getElementById('more_fields');
    return 1 unless $more;

    my $existing = $more->innerHTML;
    $more->innerHTML(<<HTML);
$existing
    <mt:loop name="field_loop">
    <li><input type="checkbox" name="custom_prefs" id="custom-prefs-customfield_<mt:var name="basename">" value="customfield_<mt:var name="basename">" <mt:if name="show_field"> checked="checked"</mt:if> class="cb" /> <label for="custom-prefs-<mt:var name="basename">"><mt:var name="name"></label></li>
    </mt:loop>  
HTML
    populate_field_loop($cb, $app, $param, $tmpl);
}

sub new_version_widget {
    my ($cb, $app, $param, $tmpl) = @_;
    
    $param->{feature_loop} ||= [];
    unshift @{ $param->{feature_loop} },
      {
        feature_label => MT->translate('Custom Fields'),
        feature_url  => $app->help_url('professional/custom-fields.html'),
        feature_description => MT->translate('Customize the forms and fields for entries, pages, folders, categories, and users, storing exactly the information you need.')
      };
}

sub post_remove_object {
    my ($eh, $obj) = @_;
    return 1 if $obj->has_meta();

    my $type = $obj->class_type || $obj->datasource;
    my $id   = $obj->id;
    require MT::PluginData;
    MT::PluginData->remove({ plugin => 'CustomFields', key => "${type}_${id}" });
}

1;

