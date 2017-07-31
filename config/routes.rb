Rails.application.routes.draw do
  root "referentials#index"
  devise_for :users

  resources :referentials, param: :slug do
    resources :partners, param: :id
  end
end
