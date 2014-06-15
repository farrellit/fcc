Fcc::Application.routes.draw do
  namespace :api do
    resources :comments
    get :csrf, to: 'csrf#index'
  end
end
