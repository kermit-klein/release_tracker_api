Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: '/api/v1/auth', controllers: {
    registrations: :facebook_login
  }
  namespace :api do
    namespace :v1 do
      resources :searches, only: :index
      resources :movie_person, only: [:index, :show]
      resources :user_selection, only: [:index, :create, :delete]
    end
  end
end
