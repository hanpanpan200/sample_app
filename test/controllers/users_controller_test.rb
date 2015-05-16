require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def setup
    @user=User.new(name:"Example User",email:"Example@example.com",
    password:"foobar",password_confirmation:"foobar")
  end

  test "should be valid" do
     assert @user.valid?
  end

  test "should name be present" do
    @user.name=" "
    assert_not @user.valid?
  end

  test "should email be present" do
    @user.email=" "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name="a"*500
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email="a"*200+"@example.com"
    assert_not @user.valid?
  end

  test "emails should be unique" do
    duplicate_user=@user.dup
    @user.save
    assert_not duplicate_user.valid?
  end




  test "should get new" do
    get :new
    assert_response :success
  end

end
