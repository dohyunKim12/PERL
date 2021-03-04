#!/usr/bin/perl
use Mojolicious::Lite -signatures;

get '/foo' => sub ($c) {
    #my $user = $c>param('user');
    #$c->render(text => 'Hello $user.');
    $c->stash(one => 23);
    $c->render(template => 'magic', 'two' => 24);
};

app->start;
__DATA__

@@ magic.html.ep
The magic numbers are <%= $one %> and <%= $two %>.
