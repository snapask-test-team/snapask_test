Rails.application.routes.draw do
  devise_for :managers
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :courses

  mount ApiRoot => ApiRoot::PREFIX

  root "home#index"
end
