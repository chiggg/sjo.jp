# Movable Type (r) (C) 2007 Six Apart, Ltd. All Rights Reserved.
# This code cannot be redistributed without permission from www.sixapart.com.
# For more information, consult your Movable Type license.
#
# $Id$

# Original Copyright (c) 2005-2007 Arvind Satyanarayan

package CustomFields::Util;

use Exporter;
@CustomFields::Util::ISA = qw( Exporter );
use vars qw( @EXPORT_OK );
@EXPORT_OK = qw( get_meta save_meta field_loop _get_tmpl _get_html sync_assets );
use MT::Util qw( format_ts );

sub init_app {
    my $plugin = shift;
    my ($app) = @_;
    return if $app->id eq 'wizard';

    my $r = $plugin->registry;
    if ($app->id eq 'cms') {
        require CustomFields::App::CMS;
        $r->{customfield_types} = sub { CustomFields::App::CMS::load_customfield_types() };
        $r->{applications}{cms}{list_filters} = sub { CustomFields::App::CMS::load_list_filters(@_) };
    }
    elsif ($app->id eq 'search') {
        # set up for search app
    }
    elsif ($app->id eq 'community') {
        require CustomFields::App::CMS;
        $r->{customfield_types} = sub { CustomFields::App::CMS::load_customfield_types() };
        $r->{applications}{cms}{list_filters} = sub { CustomFields::App::CMS::load_list_filters(@_) };
    } else {
        # For Publish Queue building and other types of
        # apps we can't anticipate; the types should be known
        $r->{customfield_types} = sub {
            require CustomFields::App::CMS;
            CustomFields::App::CMS::load_customfield_types()
        };
    }
    $r->{tags} = sub { load_customfield_tags($plugin) };
}

sub load_customfield_tags {
    require MT::Object;
    my $driver = MT::Object->driver;

    require CustomFields::Field;

    if ($driver->table_exists('CustomFields::Field')) {
        my $iter = CustomFields::Field->load_iter;
        while (my $field = $iter->()) {
            my $tag = $field->tag;
            next unless $tag;
            $tags->{function}->{$tag} = sub { 
                $_[0]->stash('field', $field);
                runner('_hdlr_customfield_value', 'CustomFields::Template::ContextHandlers', @_); 
            };
            if ($field->type =~ m/^asset/) {
                $tags->{block}->{$tag . 'Asset'} = sub {
                    $_[0]->stash('field', $field);
                    runner('_hdlr_customfield_asset', 'CustomFields::Template::ContextHandlers', @_);
                };
            }
        }
    }

    # Having to hardcode this now because of a stupid bug in MT4 that prevents you dynamically loading tags
    # otherwise I would do it as I populate field list_filters
    foreach my $type (qw( Entry Page Category Folder Author )) {
        $tags->{block}->{"${type}CustomFields"} = sub { runner('_hdlr_customfields', 'CustomFields::Template::ContextHandlers', @_); };
        $tags->{function}->{"${type}CustomFieldName"} = sub { runner('_hdlr_customfield_name', 'CustomFields::Template::ContextHandlers', @_); };
        $tags->{function}->{"${type}CustomFieldDescription"} = sub { runner('_hdlr_customfield_description', 'CustomFields::Template::ContextHandlers', @_); };
        $tags->{function}->{"${type}CustomFieldValue"} = sub { runner('_hdlr_customfield_value', 'CustomFields::Template::ContextHandlers', @_); };
    }
    $tags->{block}{'App:Fields'} = '$Commercial::CustomFields::Template::ContextHandlers::_hdlr_app_fields';
    # XXX should be moved config.yaml?
    $tags->{function}->{"CustomFieldBasename"} = sub { runner('_hdlr_customfield_basename', 'CustomFields::Template::ContextHandlers', @_); };
    $tags->{function}->{"CustomFieldName"} = sub { runner('_hdlr_customfield_name', 'CustomFields::Template::ContextHandlers', @_); };
    $tags->{function}->{"CustomFieldDescription"} = sub { runner('_hdlr_customfield_description', 'CustomFields::Template::ContextHandlers', @_); };
    $tags->{function}->{"CustomFieldValue"} = sub { runner('_hdlr_customfield_value', 'CustomFields::Template::ContextHandlers', @_); };
    $tags->{function}{'CustomFieldHTML'} = '$Commercial::CustomFields::Template::ContextHandlers::_hdlr_customfield_html';

    return $tags;
}

sub runner {
    my $method = shift;
    my $class = shift;
    eval "require $class;";
    if ($@) { die $@; $@ = undef; return 1; }
    my $method_ref = $class->can($method);
    return $method_ref->($plugin, @_) if $method_ref;
    my $plugin = MT->component("Commercial");
    die $plugin->translate("Failed to find [_1]::[_2]", $class, $method);
}

sub field_loop {
    my $app = MT->instance;
    my (%param) = @_;
    my $blog_id = $param{blog_id} || 0;
    my $obj_type = $param{object_type};
    my $id = $param{object_id};
    my $simple = $param{simple} || 0;

    return '' if !$obj_type;
    my $obj_class = MT->model($obj_type);

    my ($obj, $meta_data, @pre_sort, %markers, @post_sort, $out);

    # TODO: does this really need to be not-reedit only?
    if ($id && !$app->param('reedit')) {
        $obj = $obj_class->load($id);
        $meta_data = get_meta($obj);
    }

    my $q = $app->param;
    my %date_fields;
    for my $form_field ($q->param()) {
        if ($form_field =~ m/^([td]_)?customfield_(.*?)$/) {
            my ($td, $field_name) = ($1, $2);
            if ($td) {
                $date_fields{$field_name} = 1;
            }
            else {
                $meta_data->{$field_name} = $q->param($form_field);
            }
        }
    }
    for my $field_name (keys %date_fields) {
        $meta_data->{$field_name} = {
            'date' => $q->param("d_customfield_$field_name"),
            'time' => $q->param("t_customfield_$field_name"),
        };
    }

    my $terms = {
        obj_type => $obj_type,
        $blog_id ? ( blog_id => [ $blog_id, 0 ] ) : ()
    };

    require CustomFields::Field;
    my $iter = CustomFields::Field->load_iter($terms);
    while (my $field = $iter->()) {
        my ($id, $type, $basename) = ($field->id, $field->type, $field->basename);
        my $type_obj = MT->registry('customfield_types', $type);

        my $row = $field->column_values();
        $row->{blog_id} ||= ($obj && $obj_class->has_column('blog_id')) ? $obj->blog_id : 0;
        $row->{value} =
            ( $meta_data && defined( $meta_data->{$basename} ) )
            ? $meta_data->{$basename}
            : $field->default;

        # If an options_delimiter is present, we need to populate an option_loop
        if($type_obj->{options_delimiter}) {
            my @option_loop;
            my $expr = '\s*' . $type_obj->{options_delimiter} . '\s?';
            my @options = split /$expr/, $field->options;
            foreach my $option (@options) {
                my $option_row = { option => $option };
                $option_row->{is_selected} = defined $row->{value} ? ($row->{value} eq $option) : 0;            
                push @option_loop, $option_row;
            }
            $row->{option_loop} = \@option_loop;
        }

        $row->{show_field} = ($field->obj_type eq 'entry') ? 0 : 1;
        $row->{show_hint} = $type ne 'checkbox' ? 1 : 0;

        # Now build the field_content using field_html
        $row->{field_id} = $row->{field_name} = "customfield_$basename";
        if ( $row->{type} eq 'datetime' ) {
            my $blog = $app->blog;
            my $ts = $row->{value};
            if ( $row->{options} eq 'datetime' ) {
                $row->{field_value} = format_ts( "%x %X", $ts, $blog, $app->user ? $app->user->preferred_language : undef );
            }
            elsif ( $row->{options} eq 'date' ) {
                $row->{field_value} = format_ts( "%x", $ts, $blog, $app->user ? $app->user->preferred_language : undef );
            }
            elsif ( $row->{options} eq 'time' ) {
                $row->{field_value} = format_ts( "%H:%M:%S", $ts, $blog, $app->user ? $app->user->preferred_language : undef );
            }
        }
        else {
            $row->{field_value} = $row->{value};
        }
        $row->{simple} = $simple if $simple;
        $row->{label_class} = $field->obj_type eq 'author' ? 'left-label' : 'top-label';
        $row->{field_html} = _get_html($type, 'field_html', $row);

        push @pre_sort, $row;
    }

    # Populate where the fields are in @pre_sort
    for (my $i = 0; $i < scalar @pre_sort; $i++) {
        my $basename = $pre_sort[$i]->{basename};
        $markers{$basename} = $i;
    }

    if($app->user) {
        my $author_id = $app->user->id;

        require MT::PluginData;
        my $plugindata = MT::PluginData->get_by_key({ plugin => 'CustomFields', key => "field_order_$author_id" });
        my $data = $plugindata->data || {};
        $data->{$blog_id} ||= {};

        my $order = $data->{$blog_id}->{$obj_type};
        if($order) {
            # Break up order and populate @post_sort from the markers
            foreach my $basename (split ',', $order) {
                my $i = $markers{$basename};
                next if !defined($i);
                push @post_sort, $pre_sort[$i];
            }

            # Now we add any fields that weren't in our order 
            # For example if someone set the order and then added fields
            foreach my $basename (keys %markers) {
                my $found = index $order, $basename;
                next unless $found == -1;

                my $i = $markers{$basename};
                push @post_sort, $pre_sort[$i];
            }

            return \@post_sort;
        }
    }

    return \@pre_sort;
}

sub get_meta {
    my $plugin = MT->component("Commercial");
    my $obj = shift;
    my $blog_id = $obj->can('blog_id') ? $obj->blog_id : '';
    # my $datasources = $plugin->get_config_hash("blog:$blog_id");
    my $obj_type = $obj->can('class_type') ? $obj->class_type : $obj->datasource;

    if($obj->has_meta) {
        return $obj->meta('customfields') || {};
    } else {
        my $id = $obj->id;

        require MT::PluginData;
        my $meta_data = MT::PluginData->get_by_key({ plugin => 'CustomFields', key => "${obj_type}_${id}" });

        return (ref $meta_data->data eq 'HASH') ? $meta_data->data->{customfields} : {};
    }
}

sub save_meta { 
    my $plugin = MT->component("Commercial");
    my ($obj, $meta) = @_;
    my $blog_id = $obj->can('blog_id') ? $obj->blog_id : '';
    my $obj_type = $obj->can('class_type') ? $obj->class_type : $obj->datasource;

    if($obj->has_meta) {
        $obj->meta('customfields', $meta);
        $obj->save or die $obj->errstr;
    } else {
        my $id = $obj->id;

        require MT::PluginData;
        my $meta_data = MT::PluginData->get_by_key({ plugin => 'CustomFields', key => "${obj_type}_${id}" });
        $meta_data->data({ customfields => $meta });
        $meta_data->save or die $meta_data->errstr;
    }

    # Update asset placement
    sync_assets($obj);

    return 1;
}

# Inspired by (well really copied from!) MT::Entry::sync_assets
sub sync_assets {
    my $obj = shift;
    my $meta = get_meta($obj);
    my $class = MT->model($obj->datasource);

    require MT::ObjectAsset;
    my @assets = MT::ObjectAsset->load({
        object_id => $obj->id,
        ($class->has_column('blog_id')) ? (blog_id => $obj->blog_id) : (),
        object_ds => $obj->datasource
    });
    my %assets = map { $_->asset_id => $_->id } @assets;

    foreach my $basename (keys %$meta) {
        my $text = $meta->{$basename};
        while ($text =~ m!<form[^>]*?\smt:asset-id=["'](\d+)["'][^>]*?>(.+?)</form>!gis) {
            my $id = $1;
            my $innards = $2;

            # is asset exists?
            my $asset = MT->model('asset')->load({ id => $id }) or next;

            # reference to an existing asset...
            if (exists $assets{$id}) {
                $assets{$id} = 0;
            } else {
                my $map = new MT::ObjectAsset;
                $map->blog_id($obj->blog_id)
                    if $class->has_column('blog_id');
                $map->asset_id($id);
                $map->object_ds($obj->datasource);
                $map->object_id($obj->id);
                $map->save;
                $assets{$id} = 0;
            }
        }
    }

    if (my @old_maps = grep { $assets{$_->asset_id} } @assets) {
        if ( UNIVERSAL::isa($obj, 'MT::Entry') ) {
            my $text = ($entry->text || '') . "\n" . ($entry->text_more || '');
            while ($text =~ m!<form[^>]*?\smt:asset-id=["'](\d+)["'][^>]*?>(.+?)</form>!gis) {
                my $id = $1;
                my $innards = $2;

                if (exists $assets{$id}) {
                    $assets{$id} = 0;
                }
            }
            @old_maps = grep { $assets{$_->asset_id} } @old_maps;
        }
        my @old_ids = map { $_->id } @old_maps;
        MT::ObjectAsset->remove( { id => \@old_ids });
    }
    return 1;
}

sub make_unique_field_basename {
    my ($field) = @_;
    my ($blog, $limit);
    require MT::Blog;
    $blog = MT::Blog->load($field->blog_id)
        if $field->blog_id;
    my $label = $field->name;
    $label = '' if !defined $label;
    $label =~ s/^\s+|\s+$//gs;

    require MT::Util;
    my $name = MT::Util::dirify($label);

    $limit = $blog ? ($blog->basename_limit || 30) : 30;
    $limit = 15 if $limit < 15; $limit = 250 if $limit > 250;
    my $base = substr($name, 0, $limit);
    $base =~ s/_+$//;

    my $i = 1;
    my $base_copy = $base;

    my $class = ref $field;
    while ($class->count({ basename => $base })) {
        $base = $base_copy . '_' . $i++;
    }
    $base;
}

sub _get_tmpl {
    my ($type_obj, $tmpl_key, $obj_type) = @_;

    my $tmpl = $type_obj->{$tmpl_key};
    if ( 'HASH' eq ref($tmpl) ) {
        $tmpl = defined $tmpl->{$obj_type}
          ? $tmpl->{$obj_type}
          : $tmpl->{default};
    }
    return q() unless $tmpl;
    return $tmpl->($type_obj) if ref $tmpl eq 'CODE';
    if ( $tmpl =~ /\s/ ) {
        return $tmpl;
    }
    else {    # no spaces in $tmpl; must be a filename...
        my $plugin = MT->component("Commercial");
        return $plugin->load_tmpl($tmpl) or die $plugin->errstr;
    }
}

sub _get_html {
    my ($key, $tmpl_key, $tmpl_param) = @_;
    my $plugin = MT->component("Commercial");
    my $type_obj = MT->registry('customfield_types', $key);
    return q() unless $type_obj;

    my $snip_tmpl = _get_tmpl($type_obj, $tmpl_key, $tmpl_param->{obj_type});
    return q() unless $snip_tmpl;

    require MT::Template;
    my $tmpl;
    if ( ref $snip_tmpl ne 'MT::Template' ) {
        $tmpl = MT::Template->new(
            type   => 'scalarref',
            source => ref $snip_tmpl ? $snip_tmpl : \$snip_tmpl
        );
    }
    else {
        $tmpl = $snip_tmpl;
    }

    # $plugin->set_default_tmpl_params($tmpl);
    if ( my $p = $type_obj->{field_html_params} ) {
        $p = MT->handler_to_coderef($p) unless ref $p;
        $p->(@_);
    }

    $tmpl->param($tmpl_param);
    my $html = $tmpl->output();
    $html =~ s/<\/?form[^>]*?>//gis;  # strip any enclosure form blocks
    $html = $plugin->translate_templatized($html);
    $html;
}

1;
