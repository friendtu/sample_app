require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  test 'Invalide signup information' do
    get signup_path
    assert_select 'form[action="/signup"]'
    assert_no_difference 'User.count' do
      post signup_path,params:{user:{name:"",
        email:"user@invalid",
        password:"foo",
        password_confirmation:"bar"}}
    end
    assert_template 'users/new'
    assert_select 'div#error_explaination'
    assert_select 'div.alert'
    assert_select 'div.alert-danger'
  end
  
  
  test 'valide signup information' do
    get signup_path
    assert_select 'form[action="/signup"]'
    assert_difference 'User.count',1 do
      post users_path,params:{user:{name:"tt",
        email:"user1@valid.com",
        password:"foo123",
        password_confirmation:"foo123"}}
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
  end
end
