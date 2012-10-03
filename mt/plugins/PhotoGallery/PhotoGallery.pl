# Photo Gallery
# Copyright (c) 2005-2008, Byrne Reese
#
# $Id: spamlookup.pl 16210 2005-08-15 18:00:45Z bchoate $

package MT::Plugin::PhotoGallery;

use strict;
use MT;
use base qw(MT::Plugin);
our $VERSION = '2.0';
my $plugin = MT::Plugin::PhotoGallery->new({
    id      => 'PhotoGallery',
    name    => 'Photo Gallery',
    version => $VERSION,
    description =>
	'<MT_TRANS phrase="The Photo Gallery plugin allows users to easily create photo galleries and to upload photos to them.">',
    doc_link    => '',
    author_name => 'Byrne Reese',
    author_link => 'http://www.majordojo.com/',
});
MT->add_plugin($plugin);

sub instance { $plugin }

sub init_registry {
    my $plugin = shift;
    $plugin->registry({
	object_types => {
            'asset.photo' => 'MT::Asset::ImagePhoto',
	},
	template_sets => {
	    stopdesign_photogallery_html => {
		label => 'Stop Design Photo Gallery (HTML)',
		base_path => 'templates/html',
		order => '500',
		templates => {
		    index => {
			main_index => {
			    label => 'Gallery Index',
			    outfile => 'index.php',
			    rebuild_me => 1,
			},
			javascript => {
			    label => 'Site Javascript',
			    outfile => 'mt-site.js',
			    rebuild_me => 1,
			},
			galleries_index => {
			    label => 'Gallery Archive',
			    outfile => 'galleries/index.php',
			    rebuild_me => 1,
			},
			galleries_feed => {
			    label => 'Gallery Archive (RSS)',
			    outfile => 'galleries/galleries.xml',
			    rebuild_me => 1,
			},
			comments_index => {
			    label => 'Recent Comments',
			    outfile => 'comments/index.php',
			    rebuild_me => 1,
			},
			comments_feed => {
			    label => 'Recent Comments (RSS)',
			    outfile => 'comments/comments.xml',
			    rebuild_me => 1,
			},
			photos_feed => {
			    label => 'Recent Photos (RSS)',
			    outfile => 'index.xml',
			    rebuild_me => 1,
			}
		    },
		    archive => {
			gallery_info => {
			    label => 'Gallery Info',
			    mappings => {
				category => {
				    archive_type => 'Category',
				    file_template => '<$MTArchiveTitle dirifyplus="pld"$>/galleryinfo.php',
				    preferred => '0',
				},
			    },
			},
			gallery_title => {
			    label => 'Gallery Title',
			    mappings => {
				category => {
				    archive_type => 'Category',
				    file_template => '<MTIf tag="MTArchiveTitle" eq="Favorites">favorites/title.php<MTElse><$MTArchiveTitle dirifyplus="pld"$>/index.php</MTElse></MTIf>',
				    preferred => '0',
				},
			    },
			},
			gallery => {
			    label => 'Photo Gallery',
			    mappings => {
				category => {
				    archive_type => 'Category',
				    file_template => '<MTIf tag="MTArchiveTitle" eq="Favorites">favorites/index.php<MTElse><$MTArchiveTitle dirifyplus="pld"$>/gallery/index.php</MTElse></MTIf>',
				    preferred => '0',
				},
			    },
			},
			gallery_feed => {
			    label => 'Photo Gallery (RSS)',
			    mappings => {
				category => {
				    archive_type => 'Category',
				    file_template => '<$MTArchiveTitle dirifyplus="pld"$>/index.xml',
				    preferred => '0',
				},
			    },
			},
		    },
		    individual => {
			photo => {
			    label => 'Individual Photo',
			    mappings => {
				entry_archive => {
				    archive_type => 'Individual',
				    file_template => '<$MTEntryCategory dirifyplus="pld"$>/gallery/<$MTEntryBasename dirifyplus="pld"$>.php',
				    preferred => '1',
				},
			    },
			},
		    },
		    module => {
			photo_macro => {
			    label => "Photo Macro",
			},
			footer => {
			    label => 'Footer',
			},
			comment_fields => {
			    label => 'Comment Fields',
			},
		    },
		    system => {
                        'comment_preview' => {
                            label => 'Comment Preview',
                        },
                        'comment_response' => {
                            label => 'Comment Response',
                        },
                        'dynamic_error' => {
                            label => 'Dynamic Error',
                        },
		    },
		},
	    },
	    stopdesign_photogallery_php => {
		label => 'Stop Design Photo Gallery (PHP)',
		base_path => 'templates/php',
		order => '500',
		templates => {
		    index => {
			main_index => {
			    label => 'Gallery Index',
			    outfile => 'index.php',
			    rebuild_me => 1,
			},
			javascript => {
			    label => 'Site Javascript',
			    outfile => 'mt-site.js',
			    rebuild_me => 1,
			},
			galleries_index => {
			    label => 'Gallery Archive',
			    outfile => 'galleries/index.php',
			    rebuild_me => 1,
			},
			galleries_feed => {
			    label => 'Gallery Archive (RSS)',
			    outfile => 'galleries/galleries.xml',
			    rebuild_me => 1,
			},
			comments_index => {
			    label => 'Recent Comments',
			    outfile => 'comments/index.php',
			    rebuild_me => 1,
			},
			comments_feed => {
			    label => 'Recent Comments (RSS)',
			    outfile => 'comments/comments.xml',
			    rebuild_me => 1,
			},
			photos_feed => {
			    label => 'Recent Photos (RSS)',
			    outfile => 'index.xml',
			    rebuild_me => 1,
			}
		    },
		    archive => {
			gallery_info => {
			    label => 'Gallery Info',
			    mappings => {
				category => {
				    archive_type => 'Category',
				    file_template => '<$MTArchiveTitle dirifyplus="pld"$>/galleryinfo.php',
				    preferred => '0',
				},
			    },
			},
			gallery_title => {
			    label => 'Gallery Title',
			    mappings => {
				category => {
				    archive_type => 'Category',
				    file_template => '<MTIf tag="MTArchiveTitle" eq="Favorites">favorites/title.php<MTElse><$MTArchiveTitle dirifyplus="pld"$>/index.php</MTElse></MTIf>',
				    preferred => '0',
				},
			    },
			},
			gallery => {
			    label => 'Photo Gallery',
			    mappings => {
				category => {
				    archive_type => 'Category',
				    file_template => '<MTIf tag="MTArchiveTitle" eq="Favorites">favorites/index.php<MTElse><$MTArchiveTitle dirifyplus="pld"$>/gallery/index.php</MTElse></MTIf>',
				    preferred => '0',
				},
			    },
			},
			gallery_feed => {
			    label => 'Photo Gallery (RSS)',
			    mappings => {
				category => {
				    archive_type => 'Category',
				    file_template => '<$MTArchiveTitle dirifyplus="pld"$>/index.xml',
				    preferred => '0',
				},
			    },
			},
		    },
		    individual => {
			photo => {
			    label => 'Individual Photo',
			    mappings => {
				entry_archive => {
				    archive_type => 'Individual',
				    file_template => '<$MTEntryCategory dirifyplus="pld"$>/gallery/<$MTEntryBasename dirifyplus="pld"$>.php',
				    preferred => '1',
				},
			    },
			},
		    },
		    module => {
			photo_macro => {
			    label => "Photo Macro",
			},
			footer => {
			    label => 'Footer',
			},
			comment_fields => {
			    label => 'Comment Fields',
			},
		    },
		    system => {
                        'comment_preview' => {
                            label => 'Comment Preview',
                        },
                        'comment_response' => {
                            label => 'Comment Response',
                        },
                        'dynamic_error' => {
                            label => 'Dynamic Error',
                        },
		    },
		},
	    },
	},
	callbacks => {
	    'MT::App::CMS::template_output.list_category' => sub {
		return unless $plugin->in_gallery;
		my ( $cb, $app, $output_ref ) = @_;
		$$output_ref =~ s/Create top level category/Create new photo album/g;
		$$output_ref =~ s/No categories could be found/Please create an album before uploading photos/g;
		$$output_ref =~ s/\bCategories\b/\bPhoto Albums\b/g;
		$$output_ref =~ s/\bYour category\b/\bYour photo album\b/g;
	    },
	},
	applications => {
	    cms => {
		methods => {
                    'PhotoGallery.start'         => '$PhotoGallery::PhotoGallery::App::CMS::start_upload',
                    'PhotoGallery.upload_photo'  => '$PhotoGallery::PhotoGallery::App::CMS::upload_photo',
                    'PhotoGallery.save_photo'    => '$PhotoGallery::PhotoGallery::App::CMS::save_photo',
		    'PhotoGallery.upgrade'       => '$PhotoGallery::PhotoGallery::App::CMS::upgrade',
		},
		menus => sub {
		    $plugin->in_gallery
			? {
			'create:entry' => {
			    label      => 'Upload Photo',
			    order      => 100,
			    dialog     => 'PhotoGallery.start',
			    view       => "blog",
			    permission => 'edit_templates',
			},
			'manage:category' => {
			    label      => "Albums",
			    mode       => 'list_cat',
			    order      => 6000,
			    permission => 'edit_categories',
			    view       => "blog",
			},
			
		    }
		    : {}
		},
	    },
	}, 
    });
}

sub in_gallery {
    local $@;
    return 0 if !MT->instance->blog;
    return MT->instance->blog->template_set =~ /^stopdesign_photogallery/;
}

1;
