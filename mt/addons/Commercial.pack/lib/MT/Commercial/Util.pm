package MT::Commercial::Util;

use strict;

sub init_request {
    my $cb = shift;
    my $plugin = $cb->plugin;
    my ($app) = @_;
    return if $app->id eq 'wizard';

    if (($app->mode || '') =~ /^stylecatcher_/) {
        my $r = $plugin->registry;
        my $path = $app->static_path;
        if ($path !~ m!^https?://!) {
            $path = $app->base . $path;
        }
        $path .= '/' unless $path =~ m!/$!;
        $r->{stylecatcher_libraries}{universal_themes}{url} = $path . 'addons/Commercial.pack/themes/universal.html';
    }
}

sub on_template_set_change {
    my ($cb, $param) = @_;
    return 1
        if 'universal_website' ne $param->{blog}->template_set;
    my $component = MT->component("Commercial");
    MT->log("Blog " . $param->{blog}->name . " using template set " . $param->{blog}->template_set);
    require MT::Page;
    require MT::Folder;
    my ($page, $page2, $text);
    my $author = MT->instance->{author}->id;

    if (!(_page_exists_with_tag($param,'@about'))) {
        $page = MT::Page->new;
        $page->title($component->translate('About'));
        $page->blog_id($param->{blog}->id);
        $page->status(MT::Entry::RELEASE());
        $page->basename('index');
        $page->author_id($author);
        $text =
            $component->translate('_UTS_REPLACE_THIS')
          . $component->translate('_UTS_SAMPLE_ABOUT')
          . $component->translate('_UTS_EDIT_LINK');
        $page->text($text);
        $page->tags( '@about' );
        $page->allow_comments(0);
        $page->allow_pings(0);
        $page->save() or MT->log("Could not create page: " . $page->errstr);

        my $f = MT::Folder->new;
        $f->blog_id($param->{blog}->id);
        $f->label('About');
        $f->basename('about');
        $f->author_id($author);
        $f->save
            or die $f->errstr;
        _assign_folder($param->{blog}->id, $page->id, $f->id);
        MT->log("Created page '" . $page->title() . "'");
    }

    if (!(_page_exists_with_tag($param,'@contact'))) {
        $page = MT::Page->new;
        $page->title($component->translate('_UTS_CONTACT'));
        $page->blog_id($param->{blog}->id);
        $page->status(MT::Entry::RELEASE());
        $page->basename('index');
        $page->author_id($author);
        $text =
            $component->translate('_UTS_REPLACE_THIS')
          . $component->translate('_UTS_SAMPLE_CONTACT')
          . $component->translate('_UTS_EDIT_LINK');
        $page->text($text);
        $page->tags( '@contact' );
        $page->allow_comments(0);
        $page->allow_pings(0);
        $page->save() or MT->log("Could not create page: " . $page->errstr);

        my $f = MT::Folder->new;
        $f->blog_id($param->{blog}->id);
        $f->label('Contact');
        $f->basename('contact');
        $f->author_id($author);
        $f->save
            or die $f->errstr;
        _assign_folder($param->{blog}->id, $page->id, $f->id);
        MT->log("Created page '" . $page->title() . "'");
    }
    
    if (!(_page_exists_with_tag($param,'@home'))) {
        $page = MT::Page->new;
        $page->title($component->translate('Welcome to our new website!'));
        $page->blog_id($param->{blog}->id);
        $page->status(MT::Entry::RELEASE());
        $page->basename('homepage');
        $page->author_id($author);
        $text =
            $component->translate('_UTS_REPLACE_THIS')
          . $component->translate('_UTS_SAMPLE_WELCOME')
          . $component->translate('_UTS_EDIT_LINK');
        $page->text($text);
        $page->tags( '@home' );
        $page->allow_comments(0);
        $page->allow_pings(0);
        $page->save() or MT->log("Could not create page: " . $page->errstr);

        MT->log("Created page '" . $page->title() . "'");
    }
    require MT::Entry;
    if (MT::Entry->count({ blog_id => $param->{blog}->id }) == 0) {
        $page = MT::Entry->new;
        $page->title($component->translate('New design launched using Movable Type'));
        $page->blog_id($param->{blog}->id);
        $page->status(MT::Entry::RELEASE());
        $page->author_id($author);
        $text = $component->translate('_UTS_SAMPLE_NEWDESIGN');
        $page->text($text);
        $page->tags( 'awesome', 'design', 'movable type', 'universal' );
        $page->allow_comments(1);
        $page->allow_pings(0);
        $page->save() or MT->log("Could not create entry: " . $page->errstr);

        require MT::Comment;
        my $comment = MT::Comment->new;
        $comment->blog_id($page->blog_id);
        $comment->entry_id($page->id);
        $comment->author('John Doe');
        $comment->text("Great new site. I can't wait to try Movable Type. Congrats!");
        $comment->save
           or die $comment->errstr;

        MT->log("Created entry and comment '" . $page->title() . "'");
    }
}

sub _assign_folder {
    my ($blog_id, $entry_id, $category_id) = @_;

    require MT::Placement;
    my $place = MT::Placement->new;
    $place->entry_id($entry_id);
    $place->blog_id($blog_id);
    $place->category_id($category_id);
    $place->is_primary(1);
    $place->save
        or die $place->errstr;
    return 1;
}

sub _page_exists_with_tag {
    my ($param,$tag) = @_;

    my %terms = ( 
        'blog_id' => $param->{blog}->id,
        'class' => 'page',
    ); 
    my %args = ( 'lastn' => 1 );

    require MT::Tag;
    require MT::ObjectTag;
    my @tag_names = MT::Tag->split(',', $tag);
    my %tags = map { $_ => 1, MT::Tag->normalize($_) => 1 } @tag_names;
    my @tags = MT::Tag->load({ name => [ keys %tags ] });
    my @tag_ids;
    foreach (@tags) {
        push @tag_ids, $_->id;
        my @more = MT::Tag->load({ n8d_id => $_->n8d_id ? $_->n8d_id : $_->id });
        push @tag_ids, $_->id foreach @more;
    }
    @tag_ids = ( 0 ) unless @tags;
    $args{'join'} = ['MT::ObjectTag', 'object_id',
        { tag_id => \@tag_ids, object_datasource => MT::Entry->datasource }, { unique => 1 } ];
    my $p = MT::Page->load(\%terms, \%args);
    return 1 if $p;
    return 0;
}

1;
