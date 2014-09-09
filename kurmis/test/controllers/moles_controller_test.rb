require 'test_helper'

class MolesControllerTest < ActionController::TestCase
  setup do
    @mole = moles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:moles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mole" do
    assert_difference('Mole.count') do
      post :create, mole: { avatar: @mole.avatar, name: @mole.name, score: @mole.score }
    end

    assert_redirected_to mole_path(assigns(:mole))
  end

  test "should show mole" do
    get :show, id: @mole
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mole
    assert_response :success
  end

  test "should update mole" do
    patch :update, id: @mole, mole: { avatar: @mole.avatar, name: @mole.name, score: @mole.score }
    assert_redirected_to mole_path(assigns(:mole))
  end

  test "should destroy mole" do
    assert_difference('Mole.count', -1) do
      delete :destroy, id: @mole
    end

    assert_redirected_to moles_path
  end
end
