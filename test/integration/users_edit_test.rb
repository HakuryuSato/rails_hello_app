# frozen_string_literal: true

require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  def patch_user(params)
    patch user_path(@user), params: { user: params }
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template "users/edit"
    patch_user(name: "", email: "foo@invalid", password: "foo", password_confirmation: "bar")
    assert_template "users/edit"
    assert_select "div.alert", "The form contains 4 errors."
  end

  test "successful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template "users/edit"
    name  = "Foo Bar"
    email = "foo@bar.com"
    patch_user(name: name, email: email, password: "", password_confirmation: "")
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email
  end

  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    assert_redirected_to login_url
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)
    name  = "Foo Bar"
    email = "foo@bar.com"
    patch_user(name: name, email: email, password: "", password_confirmation: "")
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email
  end
end
