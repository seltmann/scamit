require 'test_helper'

class MorphbanksControllerTest < ActionController::TestCase
  
  test 'create' do
    Morphbank.any_instance.expects(:save).returns(true)
    @morphbank = morphbanks(:basic)
    post :create, :morphbank => @morphbank.attributes
    assert_response :redirect
  end
  
  test 'create with failure' do
    Morphbank.any_instance.expects(:save).returns(false)
    @morphbank = morphbanks(:basic)
    post :create, :morphbank => @morphbank.attributes
    assert_template 'new'
  end
  
  test 'update' do
    Morphbank.any_instance.expects(:save).returns(true)
    @morphbank = morphbanks(:basic)
    put :update, :id => morphbanks(:basic).to_param, :morphbank => @morphbank.attributes
    assert_response :redirect
  end
  
  test 'update with failure' do
    Morphbank.any_instance.expects(:save).returns(false)
    @morphbank = morphbanks(:basic)
    put :update, :id => morphbanks(:basic).to_param, :morphbank => @morphbank.attributes
    assert_template 'edit'
  end
  
  test 'destroy' do
    Morphbank.any_instance.expects(:destroy).returns(true)
    @morphbank = morphbanks(:basic)
    delete :destroy, :id => @morphbank.to_param
    assert_not_nil flash[:notice] 
    assert_response :redirect
  end
  
  # Not possible: destroy with failure
  
  test 'new' do
    get :new
    assert_response :success
  end
  
  test 'edit' do
    @morphbank = morphbanks(:basic)
    get :edit, :id => @morphbank.to_param
    assert_response :success
  end
  
  test 'show' do
    @morphbank = morphbanks(:basic)
    get :show, :id => @morphbank.to_param
    assert_response :success
  end
  
  test 'index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:morphbanks)
  end
  
end