require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest
  test "invalid submission" do
  
    get signup_path
    assert_no_difference "User.count" do
      post signup_path, params: { user: {  username: "",
                                          email: "foobar",
                                          password: "duke",
                                          password_confirmation: "doodoo"
                                        }
                                }
    end
    assert_template 'users/new'
    assert_select 'form[action="/signup"]'
  end
  
  test "valid submission" do
    get signup_path
    assert_difference "User.count", 1 do
      post signup_path, params: { user: { username: "example",
                                          email: "example@example.com",
                                          password: "password",
                                          password_confirmation: "password"
                                        }
                                }
    end
    follow_redirect!
    assert_template "users/show"
  end
  
end
