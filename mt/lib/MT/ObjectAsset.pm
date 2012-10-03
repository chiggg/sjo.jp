# Movable Type (r) (C) 2001-2008 Six Apart, Ltd. All Rights Reserved.
# This code cannot be redistributed without permission from www.sixapart.com.
# For more information, consult your Movable Type license.
#
# $Id: ObjectAsset.pm 83433 2008-06-18 21:44:24Z bchoate $

package MT::ObjectAsset;

use strict;
use MT::Blog;
use base qw( MT::Object );

__PACKAGE__->install_properties({
    column_defs => {
        id => 'integer not null auto_increment',
        blog_id => 'integer',
        object_id => 'integer not null',
        object_ds => 'string(50) not null',
        asset_id => 'integer not null',
    },
    indexes => {
        blog_id => 1,
        object_id => 1,
        asset_id => 1,
        object_ds => 1,
    },
    child_of => 'MT::Blog',
    datasource => 'objectasset',
    primary_key => 'id',
});

sub class_label {
    MT->translate("Asset Placement");
}

1;
