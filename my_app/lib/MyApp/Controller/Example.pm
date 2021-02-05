package MyApp::Controller::Example;
use Mojo::Base 'Mojolicious::Controller', -signatures;

# This action will render a template
sub welcome ($self) {

  # Render template "example/welcome.html.ep" with message
  $self->render(msg => 'Welcome hojuwerwjefojweh to the Mojolicious real-time web framework!');
}
sub hello {
    my $self = shift;

    $self->render(data => '<html>Hello!</html>');
}


1;
