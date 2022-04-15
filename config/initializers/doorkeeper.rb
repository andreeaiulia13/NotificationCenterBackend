Doorkeeper.configure do
  orm :active_record

  resource_owner_from_credentials do |_routes|
    User.authenticate(params[:email], params[:password])
  end

  use_refresh_token
  access_token_expires_in 30.minutes
end
