require 'test_helper'

# TODO Figure out why this not being here throws an error.
# Seems to be particular to this method, because a basic hello world
# method in test_helper doesn't seem to be affected by this
# changing the name doesn't work either

def is_logged_in?
    !session[:user_id].nil?
end

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { name:  "",
        email: "user@invalid",
        password: "foo",
        password_confirmation: "bar" }
      end
      assert_template 'users/new'
    end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: { name:  "Example User",
                                            email: "user@example.com",
                                            password:              "password",
                                            password_confirmation: "password" }
    end
    # assert_template 'users/show'
    # assert is_logged_in?
  end
end
