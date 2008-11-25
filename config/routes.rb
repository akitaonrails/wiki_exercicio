ActionController::Routing::Routes.draw do |map|
  map.resources :articles, 
    :member => { :versions => :get, :revert => :post }
  map.root :controller => 'articles'
end