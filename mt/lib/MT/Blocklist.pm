# Movable Type (r) (C) 2001-2008 Six Apart, Ltd. All Rights Reserved.
# This code cannot be redistributed without permission from www.sixapart.com.
# For more information, consult your Movable Type license.
#
# $Id: Blocklist.pm 83433 2008-06-18 21:44:24Z bchoate $

package MT::Blocklist;
use strict;

use MT::Object;
@MT::Blocklist::ISA = qw( MT::Object );
__PACKAGE__->install_properties({
    columns => [
       'id', 'blog_id', 'text', 'action'
    ],
    indexes => {
        name => 1,
        blog_id => 1,
        text => 1,
    },
    audit => 1,
    datasource => 'blocklist',
    primary_key => 'id',
});

# valid 'action' values:
#  * discard
#  * moderate
#  * nothing

sub block_these {
    my $class = shift;
    my ($blog_id, $action, @urls) = @_;
    foreach my $url (@urls) {
        next if $class->count({blog_id => $blog_id, text => $url});
        my $this = $class->new();
        $this->set_values({blog_id => $blog_id, text => $url,
                           action => $action});
        $this->save() or return $class->error($this->errstr());
    }
    1;
}
