Rails.application.routes.draw do
  use_doorkeeper

  namespace :api do
    namespace :v1 do
      resources :products
      resources :news
      resources :users, only: [:index, :show, :create, :update]
    end
  end
end
