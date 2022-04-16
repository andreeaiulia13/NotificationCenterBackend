Rails.application.routes.draw do
  apipie
  use_doorkeeper

  devise_for :users
  
  use_doorkeeper scope: 'api/v1/sessions' do
    skip_controllers :applications, :authorizations, :authorized_applications, :token_info
  end

  resources :users, only: :index
  root 'users#index'

  namespace :api do
    namespace :v1 do
      resources :sessions, only: [:create, :index] do
        delete '/', action: :destroy, on: :collection
      end

      resources :notifications
    end
  end
      
end
