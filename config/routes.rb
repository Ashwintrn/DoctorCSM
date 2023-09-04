Rails.application.routes.draw do
  root 'patients#dashboard'
  resources :patients, only: [:create]
  get 'next_token', to: 'patients#next_token'
  get 'current_token', to: 'patients#current_token'
  mount ActionCable.server => '/cable'
end
