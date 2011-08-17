require 'test_helper'

class UploadsControllerTest < ActionController::TestCase
  
  test 'create' do
    Upload.any_instance.expects(:save).returns(true)
    @upload = uploads(:basic)
    post :create, :upload => @upload.attributes
    assert_response :redirect
  end
  
  test 'create with failure' do
    Upload.any_instance.expects(:save).returns(false)
    @upload = uploads(:basic)
    post :create, :upload => @upload.attributes
    assert_template 'new'
  end
  
  test 'update' do
    Upload.any_instance.expects(:save).returns(true)
    @upload = uploads(:basic)
    put :update, :id => uploads(:basic).to_param, :upload => @upload.attributes
    assert_response :redirect
  end
  
  test 'update with failure' do
    Upload.any_instance.expects(:save).returns(false)
    @upload = uploads(:basic)
    put :update, :id => uploads(:basic).to_param, :upload => @upload.attributes
    assert_template 'edit'
  end
  
  test 'destroy' do
    Upload.any_instance.expects(:destroy).returns(true)
    @upload = uploads(:basic)
    delete :destroy, :id => @upload.to_param
    assert_not_nil flash[:notice] 
    assert_response :redirect
  end
  
  # Not possible: destroy with failure
  
  test 'new' do
    get :new
    assert_response :success
  end
  
  test 'edit' do
    @upload = uploads(:basic)
    get :edit, :id => @upload.to_param
    assert_response :success
  end
  
  test 'show' do
    @upload = uploads(:basic)
    get :show, :id => @upload.to_param
    assert_response :success
  end
  
  test 'index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:uploads)
  end
  
end