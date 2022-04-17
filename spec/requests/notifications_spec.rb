# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::NotificationsController, type: :request do
  let!(:client1) { User.create(email: 'email@gmail.com', password: '123456') }
  let!(:client2) { User.create(email: 'email@yahoo.com', password: '123456') }
  let!(:notification1) { Notification.create(user_id: client1.id, title: 'Title1', description: 'Description1') }
  let!(:notification2) { Notification.create(user_id: client1.id, title: 'Title2', description: 'Description2') }
  let!(:notification3) { Notification.create(user_id: client1.id, title: 'Title3', description: 'Description3') }
  let!(:notification4) { Notification.create(user_id: client2.id, title: 'Title4', description: 'Description4') }
  let!(:notification5) { Notification.create(user_id: client2.id, title: 'Title5', description: 'Description5') }
  
  describe 'GET api/v1/notifications' do 
    subject do 
      stub_current_user(client1)
      get '/api/v1/notifications' 
    end

    it 'returns all notifications' do
      subject

      expect(response).to have_http_status(:success)
      expect(json.count).to eq(3)
    end
  end

  describe 'GET api/v1/notifications/:id' do
    subject do 
      get "/api/v1/notifications/#{notification1.id}"
    end

    it 'marks as read the notification' do 
      stub_current_user(client1)
      expect(notification1.read).to eq(false)
			
      subject
      expect(json['description']).to eq('Description1')
      
      notification1.reload
      expect(notification1.read).to eq(true)
      expect(notification1.read_at.utc.to_s).to eq(DateTime.now.utc.to_s)
    end

    it "can't access another's notifications" do
      stub_current_user(client2)
      subject

      expect(json['error']).to eq('Permission denied.')
    end
  end
 
  describe 'GET api/v1/notifications/:id' do
    subject do 
      delete "/api/v1/notifications/#{notification1.id}"
    end

    it 'deletes the notification' do
      stub_current_user(client1)
      subject

      expect(json['message']).to eq('Notification was successfully deleted!')
      expect(Notification.where(id: notification1.id)).to_not exist		
    end

    it "can't delete another's notifications" do
      stub_current_user(client2)
      subject

      expect(json['error']).to eq('Permission denied.')
    end
  end
end
