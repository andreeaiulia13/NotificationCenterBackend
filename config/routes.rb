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
      resources :sessions, only: %i[create index] do
        delete '/', action: :destroy, on: :collection
      end

      resources :notifications, only: %i[index show destroy]

      namespace :admin do
        resources :notifications, only: :create do 
          get :read_notifications, on: :collection
          get :unread_notifications, on: :collection
        end
      end
    end
  end
      
end
