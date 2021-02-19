Rails.application.routes.draw do
  devise_for :users
  root to: "books#index"
  resources :users, :path => '' do
    collection do
      resources :books, except:[:show] do
        resources :notes do
          member do
            get 'convert'
          end
        end
        member do
          get 'convert_book_notes'
        end
        collection do
          get 'convert_user_notes'
        end
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
