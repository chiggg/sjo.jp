# Movable Type (r) (C) 2007 Six Apart, Ltd. All Rights Reserved.
# This code cannot be redistributed without permission from www.sixapart.com.
# For more information, consult your Movable Type license.
#
# $Id$

# Original Copyright (c) 2005-2007 Arvind Satyanarayan

package CustomFields::Field;

use strict;
use base qw( MT::Object );

__PACKAGE__->install_properties({
    column_defs => {
        'id' => 'integer not null auto_increment',
        'blog_id' => 'integer',
        'name' => 'string(255) not null',
        'description' => 'text',
        'obj_type' => 'string(50) not null',
        'type' => 'string(50) not null',
        'tag' => 'string(255) not null',
        'default' => 'text',
        'options' => 'string(255)',
        'required' => 'boolean',
        'basename' => 'string(255)'
    },
    indexes => {
        blog_id => 1,
        name => 1,
        obj_type => 1,
        type => 1,
        basename => 1
    },
    primary_key => 'id',
    datasource => 'field',
});

sub class_label {
    return MT->translate("Field");
}

sub class_label_plural {
    return MT->translate("Fields");
}

sub save {
    my $field = shift;

    ## If there's no basename specified, create a unique basename.
    if (!defined($field->basename) || ($field->basename eq '')) {
        require CustomFields::Util;
        my $name = CustomFields::Util::make_unique_field_basename($field);
        $field->basename($name);
    }

    $field->SUPER::save(@_) or return;
}

sub parents {
    my $obj = shift;
    {
        blog_id => { class => MT->model('blog'), optional => 1 },
    };
}

1;
