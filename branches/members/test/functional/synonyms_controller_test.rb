require 'test_helper'

class SynonymsControllerTest < ActionController::TestCase
  
  test 'create' do
    Synonym.any_instance.expects(:save).returns(true)
    @synonym = synonyms(:basic)
    post :create, :synonym => @synonym.attributes
    assert_response :redirect
  end
  
  test 'create with failure' do
    Synonym.any_instance.expects(:save).returns(false)
    @synonym = synonyms(:basic)
    post :create, :synonym => @synonym.attributes
    assert_template 'new'
  end
  
  test 'update' do
    Synonym.any_instance.expects(:save).returns(true)
    @synonym = synonyms(:basic)
    put :update, :id => synonyms(:basic).to_param, :synonym => @synonym.attributes
    assert_response :redirect
  end
  
  test 'update with failure' do
    Synonym.any_instance.expects(:save).returns(false)
    @synonym = synonyms(:basic)
    put :update, :id => synonyms(:basic).to_param, :synonym => @synonym.attributes
    assert_template 'edit'
  end
  
  test 'destroy' do
    Synonym.any_instance.expects(:destroy).returns(true)
    @synonym = synonyms(:basic)
    delete :destroy, :id => @synonym.to_param
    assert_not_nil flash[:notice] 
    assert_response :redirect
  end
  
  # Not possible: destroy with failure
  
  test 'new' do
    get :new
    assert_response :success
  end
  
  test 'edit' do
    @synonym = synonyms(:basic)
    get :edit, :id => @synonym.to_param
    assert_response :success
  end
  
  test 'show' do
    @synonym = synonyms(:basic)
    get :show, :id => @synonym.to_param
    assert_response :success
  end
  
  test 'index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:synonyms)
  end
  
end