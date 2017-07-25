Rails.application.routes.draw do

	default_url_options = { :host => "localhost:3000" }
	
  	devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  	get 'index' => 'edwig_admin#index', as: 'EdwigAdmin'

  	root "edwig_admin#index"
end
