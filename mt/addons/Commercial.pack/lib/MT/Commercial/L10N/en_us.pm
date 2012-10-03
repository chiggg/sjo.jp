# Movable Type (r) (C) 2001-2008 Six Apart, Ltd. All Rights Reserved.
# This code cannot be redistributed without permission from www.sixapart.com.
# For more information, consult your Movable Type license.
#
# $Id: en_us.pm 71542 2008-01-21 06:54:14Z fyoshimatsu $

package MT::Commercial::L10N::en_us;

use strict;

use base 'MT::Commercial::L10N';
use vars qw( %Lexicon );
%Lexicon = (
    '_CF_BASENAME' => 'Basename',
    '_UTS_CONTACT' => 'Contact',
    '_UTS_REPLACE_THIS' => '<p><strong>Replace sample text with your own information.</strong></p>',
    '_UTS_SAMPLE_ABOUT' => q{
<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. In nec tellus sed turpis varius sagittis. Nullam pulvinar. Fusce dapibus neque pellentesque nulla. Maecenas condimentum quam. Vestibulum pretium fringilla quam. Nam elementum. Suspendisse odio magna, aliquam vitae, vulputate et, dignissim at, pede. Integer pellentesque orci at nibh. Morbi ante.</p>

<p>Maecenas convallis mattis justo. Ut mauris sapien, consequat a, bibendum vitae, sagittis ac, nisi. Nulla et sapien. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. Ut condimentum turpis ut elit. Quisque ultricies sollicitudin justo. Duis vitae magna nec risus pulvinar ultricies.</p>
},
    '_UTS_EDIT_LINK' => q{
<!-- remove this link after editing -->
<p class="admin-edit-link">
<script type="text/javascript">document.write('<a href="' + adminurl + '?__mode=view&_type=page&id=' + page_id + '&blog_id=' + blog_id + '" target="_blank">Edit this content</a>')</script>
</p>
},
    '_UTS_SAMPLE_CONTACT' => q{
<p>We'd love to hear from you. Send email to email (at) domainname.com</p>
},
    '_UTS_SAMPLE_WELCOME' => q{
<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. In nec tellus sed turpis varius sagittis. Nullam pulvinar. Fusce dapibus neque pellentesque nulla. Maecenas condimentum quam. Aliquam erat volutpat. Ut placerat porta nibh. Donec vitae nulla. Pellentesque nisi leo, pretium a, gravida quis, sollicitudin non, eros. Vestibulum pretium fringilla quam. Nam elementum. Suspendisse odio magna, aliquam vitae, vulputate et, dignissim at, pede. Integer pellentesque orci at nibh. Morbi ante.</p>

<p>Maecenas convallis mattis justo. Ut mauris sapien, consequat a, bibendum vitae, sagittis ac, nisi. Nulla et sapien. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. Ut condimentum turpis ut elit. Quisque ultricies sollicitudin justo. Duis vitae magna nec risus pulvinar ultricies. Aliquam sagittis volutpat metus.</p>

<p>Sed enim. Integer hendrerit, arcu ac pretium nonummy, velit turpis faucibus risus, pulvinar egestas enim elit sed ante. Curabitur orci diam, placerat a, faucibus id, condimentum vitae, magna. Etiam enim massa, convallis quis, rutrum vitae, porta quis, turpis.</p>
},
    '_UTS_SAMPLE_NEWDESIGN' => q{
<p>Our web site is sporting a new look and feel thanks to <a href="http://www.movabletype.com/">Movable Type</a> and the Universal Template Set. The Universal Template Set makes it possible for just about anyone to get up and running with a new web site using Movable Type. It is literally as easy as just a few clicks. Just pick a new for your web site, select the Universal Template Set and publish. Then viola! a new web site. Thank you Movable Type!</p>
},
);

1;
