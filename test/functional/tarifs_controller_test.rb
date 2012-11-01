require 'test_helper'

class TarifsControllerTest < ActionController::TestCase
  setup do
    @tarif = tarifs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tarifs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tarif" do
    assert_difference('Tarif.count') do
      post :create, tarif: @tarif.attributes
    end

    assert_redirected_to tarif_path(assigns(:tarif))
  end

  test "should show tarif" do
    get :show, id: @tarif
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tarif
    assert_response :success
  end

  test "should update tarif" do
    put :update, id: @tarif, tarif: @tarif.attributes
    assert_redirected_to tarif_path(assigns(:tarif))
  end

  test "should destroy tarif" do
    assert_difference('Tarif.count', -1) do
      delete :destroy, id: @tarif
    end

    assert_redirected_to tarifs_path
  end
end
