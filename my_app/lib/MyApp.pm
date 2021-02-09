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
  $r->any('/')->to('Users#index')->name('index');  #    (컨트롤러 # 메서드)
  $r->get('/hello')->to('example#hello');  #    (컨트롤러 # 메서드)

  my $auth_route = $r->under(   #perl:under메소드가 제일 먼저 실행됨.
     '/',
     sub{
         my $c = shift;
  
        if ($c->session('user')){ #user라는게 있으면 로그인된걸로가정
            return 1;
        }
        $c->redirect_to('index'); #index template으로 redirect시킴.
 
        return undef;
    }
 );

 $auth_route->get('/protected');
 $auth_route->get('/logout')->to('Users#logout');
}

1;
