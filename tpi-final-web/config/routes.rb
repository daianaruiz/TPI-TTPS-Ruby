Rails.application.routes.draw do
  devise_for :users
  root to: "books#index"
  resources :users, :path => '' do
    collection do
      resources :books do
        resources :notes
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
