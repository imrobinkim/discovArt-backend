Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create]
      resources :artworks, only: [:index]
      post '/login', to: 'auth#create'
      get '/profile', to: 'users#profile'

      # get '/artworks/bykeyword', to: 'artworks#search_by_keyword'
      get '/artworks/:id', to: 'artworks#artwork_detail'
    end
  end
end
