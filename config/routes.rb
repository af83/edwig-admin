Rails.application.routes.draw do
  root "referentials#index"
  devise_for :users

  resources :referentials do
    post :db_save, on: :collection
    resources :partners do
      post :db_save, on: :collection
    end
  end

  resources :users
end
