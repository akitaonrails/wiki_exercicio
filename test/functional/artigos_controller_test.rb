require 'test_helper'

class ArtigosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:artigos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create artigo" do
    assert_difference('Artigo.count') do
      post :create, :artigo => { :titulo => 'teste', :conteudo => 'teste' }
    end

    assert_redirected_to artigo_path(assigns(:artigo).titulo)
  end

  test "should show artigo" do
    get :show, :id => artigos(:one).titulo
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => artigos(:one).titulo
    assert_response :success
  end

  test "should update artigo" do
    put :update, :id => artigos(:one).titulo, :artigo => { :titulo => 'teste', :conteudo => 'teste' }
    assert_redirected_to artigo_path(assigns(:artigo))
  end

  test "should destroy artigo" do
    assert_difference('Artigo.count', -1) do
      delete :destroy, :id => artigos(:one).titulo
    end

    assert_redirected_to artigos_path
  end
end
