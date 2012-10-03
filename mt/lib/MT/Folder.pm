# Movable Type (r) (C) 2001-2008 Six Apart, Ltd. All Rights Reserved.
# This code cannot be redistributed without permission from www.sixapart.com.
# For more information, consult your Movable Type license.
#
# $Id: Folder.pm 83433 2008-06-18 21:44:24Z bchoate $

package MT::Folder;

use strict;
use base qw( MT::Category );

__PACKAGE__->install_properties({
    class_type => 'folder',
    child_of => 'MT::Blog',
    child_classes => ['MT::Placement', 'MT::FileInfo'],
});

sub class_label {
    return MT->translate("Folder");
}

sub class_label_plural {
    MT->translate("Folders");
}

sub basename_prefix {
    "folder";
}

1;
