  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
  get 'about', to: 'about#index'
 
  get 'sing_up', to: 'registrations#new'
  post 'sing_up', to: 'registrations#create'

  root 'main#index'
end
