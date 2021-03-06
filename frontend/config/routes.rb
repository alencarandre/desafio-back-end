Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :cnab_files, only: [:index, :new, :create] do
    patch :completed
  end

  resources :stores, only: [:index] do
    resources :movements, only: [:index]
  end

  root 'home#index'
end
