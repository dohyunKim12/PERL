package MyApp::Controller::Users;

use strict;
use warnings;

use Mojo::Base 'Mojolicious::Controller';


sub index
{
    my $c = shift;

    my $user = $c->param('user') || '';
    my $pass = $c->param('pass') || '';

    #Check password
    if (!$c->users->check($user, $pass))
    {
        return $c->render();    # check 실패시 바로 render를 탐. (template아래에 index를 mapping시켜줌)
    }

    # Store username in session
    $c->session(user => $user);

    #Store a friendly message for the next page in fla
    $c->flash(message => 'Thanks for logging in.'); # 한번 깜빡.

    # Redirct to protected page with a 302 resposne
    $c->redirect_to('protected');   # prtected라는 uri로 리다이렉트. template밑의 protected로 바로 렌더링 해보림.
}
sub logout
{
    my $c = shift;

    #Expire and in turn clear session automatically.
    $c->session(expires => 1);    

    # Redirect to main page with a 302 response. (302는 page redirection을 나타냄)
    $c->redirect_to('index');
}
1;

