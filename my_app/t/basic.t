use Mojo::Base -strict;

use Test::More;
use Test::Mojo;

#include application
use MyApp;

my $t = Test::Mojo->new(MyApp->new()); #test객체

# Allow 302 redirect responses  #302로 redirect하는것을 생략.
$t->ua->max_redirects(1);   #ua == UserAgent (Client의 max)redirects를 1로 지정. (redirect를 너무 많이 하지 못하게.)

#Test if the HTML login form exists
$t->get_ok('/')     #맨 root에다가 GET이 잘 들어오는지 .
    ->status_is(200)
  ->element_exists('form input[name="user"]')   #html code에서(source) form아래input이 있고 이름이 user인가?
  ->element_exists('form input[name="pass"]')
  ->element_exists('form input[type="submit"]');

#Test login with valid credentials
$t->post_ok('/' => form => {user => 'sebastian', pass => 'secr3t'}) #form이 보여지지않게 body에 실림. POST메소드의 특징. value를 채워주는 user와pass를 보냄.
  ->status_is(200)
  ->text_like('html body' => qr/Welcome sebastian/);    #text matching을 함. welcome ~~ 이 떳는지. html 아래 body 의 텍스트를 확인해서 매칭함. 

# Test accessing a protected page
$t->get_ok('/protected')
    ->status_is(200)
    ->text_like('a' => qr/Logout/);     #마찬가지로 Logout 텍스트를 비교. a는 anker tag를 뜻함. (이러한 anker tag가 있는지)

# Test if HTML login form shows up again after logout
$t->get_ok('/logout')   #마지막으로 logout시 확인.
  ->status_is(200)
  ->element_exists('form input[name="user"]')
  ->element_exists('form input[name="pass"]')
  ->element_exists('form input[type="submit"]');    #이러이러한 항목들이존재하는지.확인

done_testing();
