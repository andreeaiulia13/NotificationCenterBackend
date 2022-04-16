# frozen_string_literal: true
module RequestSpecHelper
  def json
    JSON.parse(response.body)
  end

  def authorized_headers_for(user)
    { 'Authorization': "Bearer #{user.credentials['access_token']}", 'Content-Type': 'application/json' }
  end

  def default_headers
    { 'Content-Type': 'application/json' }
  end
end
