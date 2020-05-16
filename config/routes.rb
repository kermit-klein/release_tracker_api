Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'api/v1/auth', controllers: {
    registrations: :facebook_login
  }
  namespace :api do
    namespace :v1 do
      resources :movie_person, only: :show
      resources :user_selection, only: [:index, :create, :update, :delete]
    end
  end
end
