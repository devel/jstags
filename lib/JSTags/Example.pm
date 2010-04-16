package JSTags::Example;

use strict;
use warnings;

use base 'JSTags::Controller';

# This action will render a template
sub welcome {
    my $self = shift;

    my $tags = $self->app->tags;
    my $user_tags = $tags->user( $self->user );
    $self->stash->{user_tags} = $user_tags;

    $self->render(message => 'Welcome to the tags server!');
}

sub login {
    my $self = shift;
    my $username = $self->req->param('user');
    $self->user( $username );
    return $self->render;
}

sub edit_tags {
    my $self = shift;

    return $self->render_json( { error => 'Must be logged in' } )
      unless $self->user;

    my $delete = $self->req->param('delete') ? 1 : 0;

    my $tags = $self->req->param('tags');
    my @tags = $tags && split /\s*,\s*/, $tags;

    my $user_tags = $self->tags->user($self->user);

    my @added;
    my @deleted;

    for my $tag (@tags) {
        if ( $delete ) {
            next unless $user_tags->{$tag};
            delete $user_tags->{$tag};
            push @deleted, $tag;
        }
        else {
            next if $user_tags->{$tag};
            $user_tags->{$tag} = 1;
            push @added, $tag;
        }
    }
    $self->tags->user( $self->user, $user_tags );

    $self->tags->save;

    return $self->render_json( { added => \@added, deleted => \@deleted } )
}




1;
