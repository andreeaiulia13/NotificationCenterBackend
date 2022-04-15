# frozen_string_literal: true

class Api::V1::SessionsController < Api::V1::BaseController
  include Api::V1::SessionsControllerDoc
  skip_before_action :authorize_request!, only: %i[index create]

  def index
    if current_user.present?
      render json: current_user
    else
      render json: { error: 'User is not logged in' }
    end
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.valid_password?(params[:password])
      access_token = user.tokens
      
      render(json: {
        user: {
          id: user.id,
          email: user.email,
          admin: user.admin
        }, 
        tokens: {
          access_token: access_token.token,
          token_type: 'bearer',
          expires_in: access_token.expires_in,
          refresh_token: access_token.refresh_token,
          created_at: access_token.created_at.to_time.to_i
        }
      })
    else
      render_error_message(:invalid_credentials)
    end
  end

  def destroy
    doorkeeper_token.revoke

    head :ok
  end
end
