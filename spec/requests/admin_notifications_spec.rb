# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Admin::NotificationsController, type: :request do
  let!(:client) { User.create(email: 'email@gmail.com', password: '123456') }
  let!(:admin) { User.create(email: 'admin@yahoo.com', password: '123456', admin: true) }
  let!(:notification1) { Notification.create(user_id: client.id, title: 'Title1', description: 'Description1') }
  let!(:notification2) { Notification.create(user_id: client.id, title: 'Title2', description: 'Description2') }
  let!(:notification3) { Notification.create(user_id: client.id, title: 'Title3', description: 'Description3', read: true, read_at: 1.day.ago) }
  let!(:notification4) { Notification.create(user_id: client.id, title: 'Title4', description: 'Description4', read: true, read_at: 2.days.ago) }
  let(:notification_params) do 
    { notification: {
      title: 'Notification Title', 
      description: 'Description'
      },
      emails: client.email
    }
  end

  describe 'POST api/v1/admin/notifications' do
    subject do 
      post '/api/v1/admin/notifications', params: notification_params
    end

    it 'creates a new notification' do 
      stub_current_user(admin)
      subject

      expect(json['message']).to eq('Notifications were generated successfully!')
      expect(Notification.last.title).to eq('Notification Title')
      expect(Notification.last.description).to eq('Description')
      expect(Notification.last.user_id).to eq(client.id)
      expect(Notification.last.read).to eq(false)
    end

    it "doesn't create a notification of the user is not admin" do
      stub_current_user(client)
      subject

      expect(json['error']).to eq('Permission denied.')
    end
  end

  describe 'GET api/v1/admin/notifications/read_notifications' do
    subject do
      stub_current_user(admin)
      get '/api/v1/admin/notifications/read_notifications'
    end
    
    it 'returns all the read notifications' do 
      subject
      expect(json.count).to eq(2)
    end
  end

  describe 'GET api/v1/admin/notifications/unread_notifications' do
    subject do
      stub_current_user(admin)
      get '/api/v1/admin/notifications/unread_notifications'
    end
    
    it 'returns all the unread notifications' do 
      subject
      expect(json.count).to eq(2)
    end
  end
end
