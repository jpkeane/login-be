Rails.application.routes.draw do
  use_doorkeeper

  namespace :api do
    namespace :v1 do
      resources :products
      resources :news, only: [:index, :show]
    end
  end
end
