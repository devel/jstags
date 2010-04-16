package JSTags::Controller;
use strict;
use base 'Mojolicious::Controller';

sub user {
    my $self = shift;
    if (@_) {
        $self->session->{user} = shift;
    }
    return $self->session->{user};
}

sub tags {
    my $self = shift;
    return $self->app->tags;
}

1;
