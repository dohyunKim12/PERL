package MyApp::Controller::Users;

use strict;
use warnings;

use Mojo::Base 'Mojolicious::Controller';


sub welcome
{
    my $c = shift;

    my $user = $c->param('user') || '';
    my $pass = $c->param('pass') || '';

    if ($c->users->check($user, $pass))
    {
        return $c->render(json => {msg => 'Welcome $user.'});
    }

    $c->render(json => {msg =>'Wrong username or password.'});
}
1;
