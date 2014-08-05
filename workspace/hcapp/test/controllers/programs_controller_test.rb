require 'test_helper'

class ProgramsControllerTest < ActionController::TestCase
  setup do
    @program = programs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:programs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create program" do
    assert_difference('Program.count') do
      post :create, program: { administrator: @program.administrator, conditions: @program.conditions, costs: @program.costs, examples: @program.examples, next_time_from: @program.next_time_from, next_time_to: @program.next_time_to, price: @program.price, requirements: @program.requirements, support: @program.support, title: @program.title }
    end

    assert_redirected_to program_path(assigns(:program))
  end

  test "should show program" do
    get :show, id: @program
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @program
    assert_response :success
  end

  test "should update program" do
    patch :update, id: @program, program: { administrator: @program.administrator, conditions: @program.conditions, costs: @program.costs, examples: @program.examples, next_time_from: @program.next_time_from, next_time_to: @program.next_time_to, price: @program.price, requirements: @program.requirements, support: @program.support, title: @program.title }
    assert_redirected_to program_path(assigns(:program))
  end

  test "should destroy program" do
    assert_difference('Program.count', -1) do
      delete :destroy, id: @program
    end

    assert_redirected_to programs_path
  end
end
