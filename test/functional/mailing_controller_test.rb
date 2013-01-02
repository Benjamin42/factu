require 'test_helper'

class MailingControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
