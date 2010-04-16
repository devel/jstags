package JSTags;

use strict;
use warnings;

use base 'Mojolicious';
use JSTags::Tags;

__PACKAGE__->attr( 'tags' );


# This method will run once at server start
sub startup {
    my $self = shift;

    $self->tags( JSTags::Tags->new( file => $self->home . '/tags.store' ));

    # Routes
    my $r = $self->routes;

    # Default route
    $r->route('/:controller/:action/:id')->to('example#welcome', id => 1);
}

1;
