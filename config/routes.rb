Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :searches, only: [:create]
    end
  end 
end
