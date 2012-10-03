# Movable Type (r) (C) 2001-2008 Six Apart, Ltd. All Rights Reserved.
# This code cannot be redistributed without permission from www.sixapart.com.
# For more information, consult your Movable Type license.
#
# $Id: ObjectTag.pm 83433 2008-06-18 21:44:24Z bchoate $

package MT::ObjectTag;

use strict;

use MT::Blog;
use base qw( MT::Object );

__PACKAGE__->install_properties({
    column_defs => {
        'id' => 'integer not null auto_increment',
        'blog_id' => 'integer',
        'object_id' => 'integer not null',
        'object_datasource' => 'string(50) not null',
        'tag_id' => 'integer not null',
    },
    indexes => {
        blog_id => 1,
        object_id => 1,
        tag_id => 1,
        object_datasource => 1,
    },
    child_of => 'MT::Blog',
    datasource => 'objecttag',
    primary_key => 'id',
});

sub class_label {
    MT->translate("Tag Placement");
}

sub class_label_plural {
    MT->translate("Tag Placements");
}

1;
__END__

=head1 NAME

MT::ObjectTag

=head1 AUTHOR & COPYRIGHT

Please see L<MT/AUTHOR & COPYRIGHT>.

=cut
