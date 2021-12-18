Rails.application.routes.draw do
  devise_for :users # the order of statements MATTERS
  root to: "events#index"
  post '/events/:id', to: 'events#attend', as: 'attend' # custom route
  resources :events, only: [:index, :show, :new, :create, :attend]
  resources :users, only: [:show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
