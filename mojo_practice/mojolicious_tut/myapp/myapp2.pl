#!/usr/bin/perl

use Mojolicious::Lite -signatures;

#Access request information
get '/agent' => sub ($c){
    my $host = $c->req->url->to_abs->host;
    my $ua = $c->req->headers->user_agent;
    $c->render(text => "Request by $ua reached $host.");
};

#Echo the request body and send custom header with response
post '/echo' => sub ($c) {
    $c->res->headers->header('X-Bender' => 'Bite mt shiny metal ass!');
    $c->render(data => $c->req->body);
};

app->start;
