Rails.application.routes.draw do
  devise_for :users
  resources :users
  # get "users/:id" => "users#show"
  resources :books do
  	resource :favorites, only: [:create, :destroy]
  	resources :book_comments, only: [:create, :destroy, :edit, :update]
  end

  root 'home#top'
  get 'home/about' => 'home#about'

end