require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:constantine)
  end

  test "unsuccessful edit bro" do
    log_in_as(@user)
    get edit_user_url(@user)
    assert_template "users/edit"
    patch user_path(@user), params: { user: { username: "",
                                              email: "fsdfs",
                                              password: "lol",
                                              pasword_confirmation: ""
                                            }
                                    }
    assert_template "users/edit"
  
  end
  
  test "successful edit bro" do
    log_in_as(@user)
    get edit_user_url(@user)
    assert_template "users/edit"
    username = "constantine92haha"
    email = "constantine92haha@email.com"
    
    patch user_path(@user), params: { user: {  username: username,
                                              email: email,
                                              password: "",
                                              password_confirmation: ""
                                            }
                                    }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal username, @user.username
    assert_equal email, @user.email
  
  end

  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)
    username = "constantine92haha"
    email = "constantine92haha@email.com"
    
    patch user_path(@user), params: { user: {  username: username,
                                              email: email,
                                              password: "",
                                              password_confirmation: ""
                                            }
                                    }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal username, @user.username
    assert_equal email, @user.email
  
  end

  test "should redirect edit when not logged in " do
    get edit_user_url(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should redirect update when not logged in" do
    patch user_path(@user), params: {  user: { username: @user.username,
                                              email: @user.email,
                                              password: "",
                                              password_confirmation: ""
                                            }
                                    }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

end
