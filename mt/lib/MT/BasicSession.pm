# Movable Type (r) (C) 2001-2008 Six Apart, Ltd. All Rights Reserved.
# This code cannot be redistributed without permission from www.sixapart.com.
# For more information, consult your Movable Type license.
#
# $Id: BasicSession.pm 83433 2008-06-18 21:44:24Z bchoate $

package MT::BasicSession;

# fake out the require for this package since we're
# declaring it inline...

use MT::Object;
@MT::BasicSession::ISA = qw( MT::Object );
__PACKAGE__->install_properties({
    column_defs => {
        'id' => 'string(80) not null primary key',
        'data' => 'blob',
        'email' => 'string(255)',
        'name' => 'string(255)',
        'kind' => 'string(2)',
        'start' => 'integer not null',
    },
    indexes => {
        'start' => 1,
        'kind' => 1
    },
    datasource => 'session',
});

# sub load {
#     SUPER::load(@_) or return undef;
# }

1;
__END__

=head1 NAME

MT::BasicSession

=head1 AUTHOR & COPYRIGHT

Please see L<MT/AUTHOR & COPYRIGHT>.

=cut
