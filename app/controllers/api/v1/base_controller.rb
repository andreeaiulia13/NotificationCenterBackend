class Api::V1::BaseController < ActionController::API
  include  ActionController::MimeResponds
	
  before_action :authorize_request!

  protected

    def doorkeeper_unauthorized_render_options(error: nil)
      {
        json: {
          code: error.state,
          message: 'Not authorized',
          expired: error.reason == :expired
        }
      }
    end

    def render_error_message(code)
      render json: {
        message: I18n.t("errors.#{code}"),
        code: code
      }, status: :unprocessable_entity
    end

    def authorize_request!
      if doorkeeper_token.present?
        doorkeeper_authorize!
      else
        authenticate_user!
      end
    end

    def current_user
      @current_user = User.find(doorkeeper_token[:resource_owner_id])
    end
end
