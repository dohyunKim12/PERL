package MyApp;
use Mojo::Base 'Mojolicious', -signatures;
use Mojo::Util;
use MyApp::Model::Users;

our $users;

# This method will run once at server start
sub startup ($self) {

  # Load configuration from config file
  my $config = $self->plugin('NotYAMLConfig');

  # Configure the application
  $self->secrets($config->{secrets});
    
  $self->helper(
      users => sub{
          if(!$users)
          {
              $users = MyApp::Model::Users->new();
          }
          return $users;
      }
  );
  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/')->to('Users#welcome');  #    (컨트롤러 # 메서드)
  $r->get('/hello')->to('example#hello');  #    (컨트롤러 # 메서드)
}

1;
