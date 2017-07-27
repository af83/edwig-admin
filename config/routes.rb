Rails.application.routes.draw do
    root "referentials#index"
    devise_for :users

    resources :referentials do
        resources :partners, only: :index
    end
end
