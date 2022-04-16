# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::NotificationsController, type: :request do
	let!(:user) { User.create(email: 'email@gmail.com', password: '123456') }
  let!(:notification1) { Notification.create(user_id: user.id, title: 'Title1', description: 'Description1') }
	let!(:notification2) { Notification.create(user_id: user.id, title: 'Title2', description: 'Description2') }
	let!(:notification3) { Notification.create(user_id: user.id, title: 'Title3', description: 'Description3') }

	describe 'GET api/v1/notifications' do 
		subject { get '/api/v1/notifications' }
    before { post '/api/v1/sessions', params: { email: 'email@gmail.com', password: '123456' } }

		it 'returns all notifications' do
			subject
			byebug
      expect(response).to have_http_status(:success)
		end
	end
end