package JSTags::Tags;
use Storable qw(retrieve nstore);

use base 'Mojo::Base';

__PACKAGE__->attr( file );
__PACKAGE__->attr( tags => 0);

sub user {
    my ($self, $user) = (shift, shift);
    return {} unless $user;
    $self->load unless $self->tags;
    $self->tags->{$user} = shift if @_;
    return $self->tags->{$user} || {};
}

sub load {
    my $self = shift;
    $self->tags( eval { retrieve( $self->file ) } || {} );
}

sub save {
    my $self = shift;
    nstore $self->tags, $self->file;
}

1;
