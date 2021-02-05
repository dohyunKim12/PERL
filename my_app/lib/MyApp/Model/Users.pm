package MyApp::Model::Users;

use strict; #엄격한 coding rule적용
use warnings;   #문제가 될 법한 code들을 알려줌
#use experimental qw(signatures);

#use Mojo::Util qw(secure_compare);

my $USERS = {
  joel      => 'las3rs',
  marcus    => 'lulz',
  sebastian => 'secr3t'
};

sub new { 
    my $class = shift;
    return bless({}, $class);
}   #Moose, Mouse가 아님. 원래 방식으로 생성해야함/.

sub check {

    my $self = shift;
    my $user = shift;
    my $pass = shift;
  # Success
  return 1 if $USERS->{$user} && $USERS->{$user} eq $pass;

  # Fail
  return undef;
}

1;
