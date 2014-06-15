Fcc::Application.routes.draw do
  root 'home#index'

  namespace :api do
    resources :comments
    get :csrf, to: 'csrf#index'
  end

  get '*fcc', to: 'home#index'
end
