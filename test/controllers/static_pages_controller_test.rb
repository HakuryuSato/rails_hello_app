require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @base_title = "Ruby on Rails Tutorial Sample App"
  end

  # root ルーティングテスト
  test "should get root" do
    get send("static_pages_home_url")
    assert_response :success
  end


  # 各種ルーティングテスト
  {
    home: "Home",
    help: "Help",
    about: "About",
    contact: "Contact"
  }.each do |action, title|
    define_method("test_should_get_#{action}") do
      get send("static_pages_#{action}_url")
      assert_response :success
      assert_select "title", "#{title} | #{@base_title}"
    end
  end
end
