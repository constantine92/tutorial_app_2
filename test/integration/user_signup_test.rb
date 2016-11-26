require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest
  test "invalid submission" do
  
    get signup_path
    assert_no_difference "User.count" do
      post users_path, params: { user: {  username: "",
                                          email: "foobar",
                                          password: "duke",
                                          password_confirmation: "doodoo"
                                        }
                                }
    end
    assert_template 'users/new'
  end
end
