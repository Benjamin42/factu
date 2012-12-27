require 'test_helper'

class CleaningPaysControllerTest < ActionController::TestCase
  setup do
    @cleaning_pay = cleaning_pays(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cleaning_pays)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cleaning_pay" do
    assert_difference('CleaningPay.count') do
      post :create, cleaning_pay: @cleaning_pay.attributes
    end

    assert_redirected_to cleaning_pay_path(assigns(:cleaning_pay))
  end

  test "should show cleaning_pay" do
    get :show, id: @cleaning_pay
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cleaning_pay
    assert_response :success
  end

  test "should update cleaning_pay" do
    put :update, id: @cleaning_pay, cleaning_pay: @cleaning_pay.attributes
    assert_redirected_to cleaning_pay_path(assigns(:cleaning_pay))
  end

  test "should destroy cleaning_pay" do
    assert_difference('CleaningPay.count', -1) do
      delete :destroy, id: @cleaning_pay
    end

    assert_redirected_to cleaning_pays_path
  end
end
