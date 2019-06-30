Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create]
      resources :artworks, only: [:show]
      post '/login', to: 'auth#create'
      get '/profile', to: 'users#profile'

      get '/artworks/initial', to: 'artworks#initial'
      # get '/artworks/:id', to: 'artworks#artworks_detail'
    end
  end
end
