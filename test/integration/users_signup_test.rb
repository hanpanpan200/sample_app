require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid sign up information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: {name: "", email: "valid@example.com", password: "123", password_confirmation: "456"}
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert-danger'
  end

  test "valid sign up information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: {name: "pennyhan", email: "pennyhan20102010@sina.com", password: "password", password_confirmation: "password"}
    end
    assert_template 'users/show'
    assert is_logged_in?
    assert_not flash.nil?
  end

end
