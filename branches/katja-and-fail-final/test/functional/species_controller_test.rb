require 'test_helper'

class SpeciesControllerTest < ActionController::TestCase
  
  test 'create' do
    Species.any_instance.expects(:save).returns(true)
    @species = species(:basic)
    post :create, :species => @species.attributes
    assert_response :redirect
  end
  
  test 'create with failure' do
    Species.any_instance.expects(:save).returns(false)
    @species = species(:basic)
    post :create, :species => @species.attributes
    assert_template 'new'
  end
  
  test 'update' do
    Species.any_instance.expects(:save).returns(true)
    @species = species(:basic)
    put :update, :id => species(:basic).to_param, :species => @species.attributes
    assert_response :redirect
  end
  
  test 'update with failure' do
    Species.any_instance.expects(:save).returns(false)
    @species = species(:basic)
    put :update, :id => species(:basic).to_param, :species => @species.attributes
    assert_template 'edit'
  end
  
  test 'destroy' do
    Species.any_instance.expects(:destroy).returns(true)
    @species = species(:basic)
    delete :destroy, :id => @species.to_param
    assert_not_nil flash[:notice] 
    assert_response :redirect
  end
  
  # Not possible: destroy with failure
  
  test 'new' do
    get :new
    assert_response :success
  end
  
  test 'edit' do
    @species = species(:basic)
    get :edit, :id => @species.to_param
    assert_response :success
  end
  
  test 'show' do
    @species = species(:basic)
    get :show, :id => @species.to_param
    assert_response :success
  end
  
  test 'index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:species)
  end
  
end