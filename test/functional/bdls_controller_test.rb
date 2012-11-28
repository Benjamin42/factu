require 'test_helper'

class BdlsControllerTest < ActionController::TestCase
  setup do
    @bdl = bdls(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bdls)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bdl" do
    assert_difference('Bdl.count') do
      post :create, bdl: @bdl.attributes
    end

    assert_redirected_to bdl_path(assigns(:bdl))
  end

  test "should show bdl" do
    get :show, id: @bdl
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bdl
    assert_response :success
  end

  test "should update bdl" do
    put :update, id: @bdl, bdl: @bdl.attributes
    assert_redirected_to bdl_path(assigns(:bdl))
  end

  test "should destroy bdl" do
    assert_difference('Bdl.count', -1) do
      delete :destroy, id: @bdl
    end

    assert_redirected_to bdls_path
  end
end
