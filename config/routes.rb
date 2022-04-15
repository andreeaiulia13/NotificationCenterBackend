Rails.application.routes.draw do
  devise_for :users
  use_doorkeeper

  use_doorkeeper scope: 'api/v1/sessions' do
    skip_controllers :applications, :authorizations, :authorized_applications, :token_info
  end

  #API
  namespace :api do
    namespace :v1 do
      resources :sessions, only: [:create, :index] do
        delete '/', action: :destroy, on: :collection
      end
    end
  end
      
end
