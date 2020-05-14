Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :movie_person, only: :show
    end
  end
end
