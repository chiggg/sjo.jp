# Movable Type (r) (C) 2001-2008 Six Apart, Ltd. All Rights Reserved.
# This code cannot be redistributed without permission from www.sixapart.com.
# For more information, consult your Movable Type license.
#
# $Id: default-templates.pl 83433 2008-06-18 21:44:24Z bchoate $

package MT::default_templates;

use strict;
require MT::DefaultTemplates;

delete $INC{'MT/default-templates.pl'};

MT::DefaultTemplates->templates;
