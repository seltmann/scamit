require 'test_helper'

class LocalitiesControllerTest < ActionController::TestCase
  
  test 'create' do
    Locality.any_instance.expects(:save).returns(true)
    @locality = localities(:basic)
    post :create, :locality => @locality.attributes
    assert_response :redirect
  end
  
  test 'create with failure' do
    Locality.any_instance.expects(:save).returns(false)
    @locality = localities(:basic)
    post :create, :locality => @locality.attributes
    assert_template 'new'
  end
  
  test 'update' do
    Locality.any_instance.expects(:save).returns(true)
    @locality = localities(:basic)
    put :update, :id => localities(:basic).to_param, :locality => @locality.attributes
    assert_response :redirect
  end
  
  test 'update with failure' do
    Locality.any_instance.expects(:save).returns(false)
    @locality = localities(:basic)
    put :update, :id => localities(:basic).to_param, :locality => @locality.attributes
    assert_template 'edit'
  end
  
  test 'destroy' do
    Locality.any_instance.expects(:destroy).returns(true)
    @locality = localities(:basic)
    delete :destroy, :id => @locality.to_param
    assert_not_nil flash[:notice] 
    assert_response :redirect
  end
  
  # Not possible: destroy with failure
  
  test 'new' do
    get :new
    assert_response :success
  end
  
  test 'edit' do
    @locality = localities(:basic)
    get :edit, :id => @locality.to_param
    assert_response :success
  end
  
  test 'show' do
    @locality = localities(:basic)
    get :show, :id => @locality.to_param
    assert_response :success
  end
  
  test 'index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:localities)
  end
  
end