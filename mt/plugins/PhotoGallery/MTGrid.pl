# Copyright 2003 Stepan Riha. This code cannot be redistributed without
# permission from www.nonplus.net.

=head1 <MTGrid*> tags

Free for personal or commercial use. 

Version 1.1.1 - June 18 2003
Fixed MT version being changed.

Version 1.1 - May 27 2003
Fixed passing conditions into cells (i.e. MTEntryIfExtended was alway true...)
Added right_to_left attribute.

Version 1.0 - January 27 2003
Initial release


	MTGridVersion
	MTGrid
		num_columns="5"
		num_rows=
		transpose="1"
		right_to_left="1"
		enum_rows="0,1"
		enum_columns="0,1"
	MTGridTrailingCells
	
	MTGridCell
		MTGridIfLeftColumn
		MTGridIfRightColumn
		MTGridIfFirstRow
		MTGridIfLastRow
		MTGridCellNumber
		MTGridRowNumber
		MTGridColumnNumber
		MTGridRowEnum
		MTGridColumnEnum

Example:

<table>
	<MTGrid num_columns="3">
		<MTEntries>
			<MTGridCell>
				<MTGridIfLeftColumn><tr></MTGridIfLeftColumn>
				<td>
					<a href="<$MTEntryPermalink$>"><$MTEntryTitle$></a><br/>
					<$MTEntryExcerpt$>
				</td>
				<MTGridIfRightColumn></tr></MTGridIfRightColumn>
			</MTGridCell>
		</MTEntries>
		<MTGridTrailingCells>
			<td>&nbsp;</td>
			<MTGridIfRightColumn></tr></MTGridIfRightColumn>
		</MTGridTrailingCells>
	</MTGrid>
</table>


=cut

## Declare modules we use
use strict;
use MT::Template::Context;
package plugins::MTGrid;
use vars qw($VERSION);
$VERSION = "1.1.1";

## Register MT handlers

MT::Template::Context->add_tag(GridVersion => sub { $VERSION } );
MT::Template::Context->add_container_tag(Grid => \&MTGrid );
MT::Template::Context->add_container_tag(GridCell => \&MTGridCell );
MT::Template::Context->add_container_tag(GridTrailingCells => \&MTGridTrailingCells );
MT::Template::Context->add_tag(GridCellNumber => \&MTGridCellNumber );
MT::Template::Context->add_tag(GridRowNumber => \&MTGridRowNumber );
MT::Template::Context->add_tag(GridRowEnum => \&MTGridRowEnum );
MT::Template::Context->add_tag(GridColumnNumber => \&MTGridColumnNumber );
MT::Template::Context->add_tag(GridColumnEnum => \&MTGridColumnEnum );
MT::Template::Context->add_conditional_tag(GridIfLeftColumn => \&MTGridIfLeftColumn);
MT::Template::Context->add_conditional_tag(GridIfRightColumn => \&MTGridIfRightColumn);
MT::Template::Context->add_conditional_tag(GridIfFirstRow => \&MTGridIfFirstRow);
MT::Template::Context->add_conditional_tag(GridIfLastRow => \&MTGridIfLastRow);

sub MTGrid {
    my($ctx, $args, $cond) = @_;
    my $tok = $ctx->stash('tokens');
    my $builder = $ctx->stash('builder');

	## Setup context
	my $savedGrid = $ctx->stash('grid');
    my %grid_context = ();
    my $grid = \%grid_context;
	$ctx->stash('grid', $grid);

	## 1st pass: Count cells
	$grid->{num_cells} = 0;
	$grid->{counting_cells} = 1;
	defined($builder->build($ctx, $tok, $cond)) or return;
	$grid->{counting_cells} = 0;

	## Setup parameters
    $grid->{transpose} = $args->{transpose} || 0;
    $grid->{rtl} = $args->{right_to_left} || 0;
	my @enum_rows = split /,/, $args->{enum_rows} || "0,1";
	my @enum_columns = split  /,/, $args->{enum_columns} || "0,1";
	$grid->{enum_rows} = \@enum_rows;
	$grid->{enum_columns} = \@enum_columns;

	## Compute dimensions
	if($args->{num_rows}) {
		$grid->{num_rows} = $args->{num_rows};
		$grid->{num_columns} = int(($grid->{num_cells}-1)/$grid->{num_rows} + 1);
	} else {
		$grid->{num_columns} = $args->{num_columns} || 3;
		$grid->{num_rows} = int(($grid->{num_cells}-1)/$grid->{num_columns} + 1);
	}
	$grid->{total_cells} = $grid->{num_rows} * $grid->{num_columns};

	## 2nd pass: Generate content
	$grid->{cell_number} = 0;
	my %cells = ();
	$grid->{cells} = \%cells;
	defined($builder->build($ctx, $tok, $cond)) or return;

	## Emit content
    my $res = '';
	for(my $row = 0; $row < $grid->{num_rows}; $row++) {
		for(my $column = 0; $column < $grid->{num_columns}; $column++) {
			$grid->{cell_number} = _cell_number($grid, $row, $column);
			$res .= $cells{_row_number($grid), _column_number($grid)} || '';
		}
	}

	## Cleanup
	$ctx->stash('grid', $savedGrid);

	return $res;
}

sub MTGridCell {
	my $grid = _get_grid(@_) or return;

	if($grid->{counting_cells}) {
		# Bump cell count
		$grid->{num_cells}++;
	} else {
		# Build content
		defined($grid->{cells}->{_row_number($grid), _column_number($grid)}
			= _pass_through(@_)) or return;
		# Bump current count
		$grid->{cell_number}++;
	}
	return 1;
}

sub MTGridTrailingCells {
    my $grid = _get_grid(@_) or return;

	return 1 if $grid->{counting_cells};

    my ($ctx, $args, $cond) = @_;
    my $tok = $ctx->stash('tokens');
    my $builder = $ctx->stash('builder');

	while($grid->{cell_number} < $grid->{total_cells}) {
		defined(my $cell = $builder->build($ctx, $tok, $cond)) or return;
		$grid->{cells}->{_row_number($grid), _column_number($grid)} = $cell;
		# Bump count
		$grid->{cell_number}++;
	}
	return 1;
}

sub MTGridCellNumber {
    my $grid = _get_grid(@_) or return;
	return $grid->{cell_number} + 1;
}

sub MTGridRowNumber {
    my $grid = _get_grid(@_) or return;
	return _row_number($grid) + 1;
}

sub MTGridColumnNumber {
    my $grid = _get_grid(@_) or return;
	return _column_number($grid) + 1;
}

sub MTGridRowEnum {
    my $grid = _get_grid(@_) or return;
	my $enum = $grid->{enum_rows};
	return ${$enum}[_row_number($grid) % scalar(@$enum)];
}

sub MTGridColumnEnum {
    my $grid = _get_grid(@_) or return;
	my $enum = $grid->{enum_columns};
	return ${$enum}[_column_number($grid) % scalar(@$enum)];
}

sub MTGridIfLeftColumn {
    my $grid = _get_grid(@_) or return;
	return _column_number($grid) == 0;
}

sub MTGridIfRightColumn {
    my $grid = _get_grid(@_) or return;
	return _column_number($grid) == ($grid->{num_columns}-1);
}

sub MTGridIfFirstRow {
    my $grid = _get_grid(@_) or return;
	return _row_number($grid) == 0;
}

sub MTGridIfLastRow {
    my $grid = _get_grid(@_) or return;
	return _row_number($grid) == ($grid->{num_rows}-1);
}

## _not_in_grid_error($ctx)
sub _not_in_grid_error {
    my($ctx) = @_;
    my $tag = "MT" . $ctx->stash('tag');
    return $ctx->error("$tag must be within the MTGrid tags!");
}

## $grid = _get_grid($ctx)
sub _get_grid {
    my($ctx) = @_;
    my $grid = $ctx->stash('grid');
    return _not_in_grid_error($ctx) unless defined($grid);
    return $grid;
}

## $res = _pass_through($ctx, $args, $cond)
sub _pass_through {
    my ($ctx, $args, $cond) = @_;
    my $tok = $ctx->stash('tokens');
    my $builder = $ctx->stash('builder');

	return $builder->build($ctx, $tok, $cond);
}

## cell_number = _cell_number($grid, row, column)
sub _cell_number {
	my ($grid, $row, $column) = @_;

	if($grid->{rtl}) {
		if($grid->{transpose}) {
			return ($grid->{num_columns} - $column - 1) * $grid->{num_rows} + $row;
		} else {
			return ($row+1) * $grid->{num_columns} - $column - 1;
		}
	}
	if($grid->{transpose}) {
		return $column * $grid->{num_rows} + $row;
	} else {
		return $row * $grid->{num_columns} + $column;
	}
}

## column_number = _column_number($grid)
sub _column_number {
	my $grid = $_[0];
	if($grid->{rtl}) {
		return $grid->{transpose}
					? ($grid->{num_columns} - 1 - int($grid->{cell_number} / $grid->{num_rows}))
					: ($grid->{num_columns} - 1 - ($grid->{cell_number} % $grid->{num_columns}));
	}
	return $grid->{transpose}
				? int($grid->{cell_number} / $grid->{num_rows})
				: ($grid->{cell_number} % $grid->{num_columns});
}

## row_number = _row_number($grid)
sub _row_number {
	my $grid = $_[0];
	if($grid->{rtl}) {
		return $grid->{transpose}
				? ($grid->{cell_number} % $grid->{num_rows})
					: int($grid->{cell_number} / $grid->{num_columns});
	}
	return $grid->{transpose}
				? ($grid->{cell_number} % $grid->{num_rows})
				: int($grid->{cell_number} / $grid->{num_columns});
}
