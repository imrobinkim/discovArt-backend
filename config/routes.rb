Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :create]
      resources :artworks, only: [:index]
      post '/login', to: 'auth#create'
      get '/profile', to: 'users#profile'

      get '/artworks/:id', to: 'artworks#artwork_detail'

      # TODO: Figure out if there's way to only allow favoriting by specific user
      # when logged in as that user.
      post '/favorite_artwork', to: 'artworks#favorite'
    end
  end
end
