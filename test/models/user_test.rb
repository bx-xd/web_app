require "test_helper"

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(name: "user1", email: "user1@example.com", password: "foobar", password_confirmation: "foobar")
  end

  test "user should be valid" do
    assert @user.valid?
  end

  test "users' name should be present" do
    @user.name = " "
    assert_not @user.valid?
  end

  test "users' email should be present" do
    @user.email = " "
    assert_not @user.valid?
  end

  test "name shouldn't be too long" do
    @user.name = "1" * 51 
    assert_not @user.valid?
  end

  test "email shouldn't be too long" do
    @user.email = "1" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation shoud accept valid adresses" do
    valid_adresses = %W[lolilou@example.com LOL@EXAMPLE.COM lol123@lol.fr]
    valid_adresses.each do |valid_adress|
      @user.email = valid_adress
      assert @user.valid?, "#{valid_adress.inspect} shoud be valid"
    end
  end

  test "email validation should reject invalid adresses" do
    invalid_adresses = %W[lolilou_at_lol.com lolilou.com user@example. lol@123+lol.fr lol@lol_lol.com]
    invalid_adresses.each do |invalid_adress|
      @user.email = invalid_adress
      assert_not @user.valid?, "#{invalid_adress.inspect} shouldn't be valid"
    end
  end

  test "email adress should be unique" do 
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

end
