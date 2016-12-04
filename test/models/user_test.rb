require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup 
    @user = User.create(username: "constantine92", email: "constantine92@example.com",
            password: "password", password_confirmation: "password")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "username should be present" do
    @user.username = " "
    assert_not @user.valid?
  end
  
  test "email should be present" do
    @user.email = " "
    assert_not @user.valid?
  end
  
  test "username should not be so long" do 
    @user.username = "a"*51
    assert_not @user.valid?
  end
  
  test "email should not be so long" do 
    @user.username = "a"*249 + "@example.com"
    assert_not @user.valid?
  end
  
  test "email should be valid format" do 
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
    end
    
    assert @user.valid?
  end
  
  test "invalid email format should be rejected" do 
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address| 
      @user.email = invalid_address
    end
    assert_not @user.valid?
  end
  
  test "email should be unique" do 
  duplicate_user = @user.dup
  duplicate_user.email = @user.email.upcase
  @user.save
  
  assert_not duplicate_user.valid?
  end
  
  test "email should be saved as lower case" do 
  mixed_case_email= "eXaMple@ExAmPlE.cOm"
  @user.email = mixed_case_email
  @user.save
  assert_equal mixed_case_email.downcase, @user.reload.email
  end
  
  test "password should have minimum 8 characters" do 
  password = "a" * 7
  @user.password = @user.password_confirmation = password
  assert_not @user.valid?
  end
  
  test "password should not be blank" do 
  password = "    " 
  @user.password = @user.password_confirmation = password
  assert_not @user.valid?
  end
  
  test "authenticated? should return false when user is nil" do
    assert_not @user.authenticated?('')
  end
  
end
