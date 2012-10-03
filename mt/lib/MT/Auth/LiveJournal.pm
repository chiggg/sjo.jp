# Movable Type (r) (C) 2001-2008 Six Apart, Ltd. All Rights Reserved.
# This code cannot be redistributed without permission from www.sixapart.com.
# For more information, consult your Movable Type license.
#
# $Id: LiveJournal.pm 83433 2008-06-18 21:44:24Z bchoate $

package MT::Auth::LiveJournal;
use strict;

use base qw( MT::Auth::OpenID );

sub url_for_userid {
    my $class = shift;
    my ($uid) = @_;
    return "http://www.livejournal.com/users/$uid";
};

sub _get_nickname {
    my ($vident, $blog_id) = @_;
    ## LJ username
    my $url = $vident->url;
    if( $url =~ m(^https?://www\.livejournal\.com\/users/([^/]+)/$) ||
        $url =~ m(^https?://www\.livejournal\.com\/~([^/]+)/$) ||
        $url =~ m(^https?://([^\.]+)\.livejournal\.com\/$)
    ) {
        return $1;
    }
    *MT::Auth::OpenID::_get_nickname->(@_);
}

1;
