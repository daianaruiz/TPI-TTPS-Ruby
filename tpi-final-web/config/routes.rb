Rails.application.routes.draw do
  devise_for :users
  root to: "books#index"
  resources :books do
    resources :notes do
      member do
        get 'convert'
      end
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
