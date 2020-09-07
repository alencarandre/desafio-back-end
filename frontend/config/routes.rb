Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :cnab_files, only: [:index, :new, :create]

  root 'home#index'
end
