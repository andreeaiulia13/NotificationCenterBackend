# frozen_string_literal: true

module SessionHelper
  def stub_current_user(user)
    allow_any_instance_of(Api::V1::BaseController).to receive(:authorize_request!).and_return(user)
    allow_any_instance_of(Api::V1::BaseController).to receive(:current_user).and_return(user)
    allow_any_instance_of(ApplicationController).to receive(:authenticate_user!).and_return(user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end
end
