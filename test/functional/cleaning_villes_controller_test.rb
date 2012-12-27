require 'test_helper'

class CleaningVillesControllerTest < ActionController::TestCase
  setup do
    @cleaning_ville = cleaning_villes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cleaning_villes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cleaning_ville" do
    assert_difference('CleaningVille.count') do
      post :create, cleaning_ville: @cleaning_ville.attributes
    end

    assert_redirected_to cleaning_ville_path(assigns(:cleaning_ville))
  end

  test "should show cleaning_ville" do
    get :show, id: @cleaning_ville
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cleaning_ville
    assert_response :success
  end

  test "should update cleaning_ville" do
    put :update, id: @cleaning_ville, cleaning_ville: @cleaning_ville.attributes
    assert_redirected_to cleaning_ville_path(assigns(:cleaning_ville))
  end

  test "should destroy cleaning_ville" do
    assert_difference('CleaningVille.count', -1) do
      delete :destroy, id: @cleaning_ville
    end

    assert_redirected_to cleaning_villes_path
  end
end
