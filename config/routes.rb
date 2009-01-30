ActionController::Routing::Routes.draw do |map|
  map.resources :artigos,
    :member => { :versoes => :get, :reverter => :post }
  map.root :controller => 'artigos'
end
