
# FirstNWords.pl
# Movable Type plugin tag for printing the first N words of tag's contents
# by Kevin Shay
# http://www.staggernation.com/mtplugins/
# last modified July 12, 2004

use strict;
package MT::Plugin::FirstNWords;

use vars qw( $VERSION );
$VERSION = '1.3';

use MT;
use MT::Template::Context;
use MT::Util qw( remove_html decode_html );

eval{ require MT::Plugin };
unless ($@) {
    my $plugin = {
        name => "FirstNWords $VERSION",
        description => 'Display an excerpt consisting of the first N words of any text.',
        doc_link => 'http://www.staggernation.com/mtplugins/FirstNWords'
    }; 
    MT->add_plugin(new MT::Plugin($plugin));
}

MT::Template::Context->add_container_tag('FirstNWords' => sub{&_hdlr_first_n_words;});

sub _hdlr_first_n_words {
# handler for MT container tag to print the first N words of its contents
	my ($ctx, $args, $cond) = @_;
	defined(my $n = $args->{'n'}) || return $ctx->error('No "n" passed');
	my $builder = $ctx->stash('builder');
	my $tokens = $ctx->stash('tokens');
	defined(my $text = $builder->build($ctx, $tokens, $cond))
		|| return $ctx->error($ctx->errstr);
		# there may be some initial space (i.e. if MTEntryBody tag is on a
		# new line), which will throw off the word count, so strip it off
	$text =~ s/^\s+//;
	return first_n_words($text, $n, $ctx, $args);
}

sub first_n_words {
# enhanced version of the MT::Util first_n_words() routine
    my($text, $n, $ctx, $args) = @_;
    $text = remove_html($text);
    my @words = split(/\s+/, $text);
    if (@words > $n) {
    	my $max = $n;
    	my $append = (defined $args->{'append'}) ? $args->{'append'} : '';
		if ($args->{'append_decode_html'}) {
			$append = decode_html($append);
		}
		$append = build_value($ctx, $append);
    	$text = (join ' ', @words[0..$max-1]);
    	if ($args->{'keep_trailing'}) {
    		if ($args->{'keep_trailing'} ne '1') {
    			$text =~ s/[^\w$args->{'keep_trailing'}]+$//;
    		}
    	} else {
    		$text =~ s/\W+$//;
    	}
    	$text .= $append;
    }
    return $text;    
}

sub build_value {
# convert and build MT template tags within a passed value.
	my ($ctx, $value) = @_;
		# within a value argument, you can use MT tags, but with
		# square brackets instead of angle brackets and single quotes
		# instead of double quotes; literal square brackets and single
		# quotes must be escaped with a backslash
		# convert non-escaped []'
	$value =~ s/(?<!\\)\[/</g;
	$value =~ s/(?<!\\)\]/>/g;
	$value =~ s/(?<!\\)'/"/g;
		# de-escape escaped []'
	$value =~ s/\\([\[\]'])/$1/g;
		# any MT tags?
	if ($value =~ /<MT/) {
		my $builder = $ctx->stash('builder');
		my $tok = $builder->compile($ctx, $value);
		$value = $builder->build($ctx, $tok);
		return $ctx->error($builder->errstr) unless defined($value);
	}
	return $value;
}

1;