# Copyright 2003 Stepan Riha. This code cannot be redistributed without
# permission from www.nonplus.net.

=head1 MTCategoryOfArchive

Free for personal or commercial use. 

Version 1.10 - July 21, 2003
Added MTIfCategoryOfArchive and MTIfNotCategoryOfArchive.

Version 1.00 - June 8, 2003
Initial release

=cut

## Declare modules we use
package MT::plugins::MTCategoryOfArchive;
use strict;
use MT::Template::Context;
use vars qw( $VERSION @comparison );
my $VERSION = '1.10';

## Register MT handlers

MT::Template::Context->add_tag(CategoryOfArchiveVersion => sub { $VERSION } );
MT::Template::Context->add_container_tag(CategoryOfArchive => \&MTCategoryOfArchive );
MT::Template::Context->add_conditional_tag(IfCategoryOfArchive => \&MTIfCategoryOfArchive );
MT::Template::Context->add_conditional_tag(IfNotCategoryOfArchive => \&MTIfNotCategoryOfArchive );

sub MTCategoryOfArchive() {
	my ($ctx, $args, $cond) = @_;

    my $cat = $_[0]->stash('archive_category')
		or return $ctx->error("MTCategoryOfArchive can only be called in a Category archive");

	local $ctx->{__stash}->{category} = $cat;
    my $builder = $ctx->stash('builder');
    my $tokens = $ctx->stash('tokens');
	
	return $builder->build($ctx, $tokens, $cond);
}

sub MTIfCategoryOfArchive {
	my ($ctx, $args) = @_;
	## Check if we're in an archive
	my $cat_ar = $ctx->stash('archive_category')
		or return 0;
	my $cat;
	if(my $category = $args->{'category'}) {
		use MT::Category;
		$cat = MT::Category->load({ label => $category})
			or return $ctx->error("The specified category '$category' does not exist!");
	} else {
		$cat = $ctx->stash('category')
			or return 0;
	}
	return $cat->id == $cat_ar->id;
}

sub MTIfNotCategoryOfArchive {
	my ($ctx, $args) = @_;
	## Check if we're in an archive
	my $cat_ar = $ctx->stash('archive_category')
		or return 1;
	my $cat;
	if(my $category = $args->{'category'}) {
		use MT::Category;
		$cat = MT::Category->load({ label => $category})
			or return $ctx->error("The specified category '$category' does not exist!");
	} else {
		$cat = $ctx->stash('category')
			or return 1;
	}
	return $cat->id != $cat_ar->id;
}
