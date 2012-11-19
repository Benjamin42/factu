require 'test_helper'

class CartographieControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
