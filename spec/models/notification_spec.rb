require 'rails_helper'

RSpec.describe Notification, :type => :model do
  let!(:user) { User.create(email: 'email@gmail', password: '123456') }

	context 'with a missing or invalid parameter' do
    it 'is not valid without a title' do 
			notification = Notification.new(description: 'description', user_id: user.id)
      expect(user).to_not be_valid
		end

		it 'is not valid without a description' do 
			notification = Notification.new(title: 'title', user_id: user.id)
      expect(user).to_not be_valid
		end

		it 'is not valid without an user' do 
			notification = Notification.new(title: 'title', description: 'description')
      expect(user).to_not be_valid
		end
	end

	context 'with valid parameters' do
		it 'puts read false by default' do 
      notification = Notification.create(title: 'title', description: 'description', user_id: user.id)
			
			expect(notification.read).to eq(false)
			expect(notification.read_at).to eq(nil)
		end
	end
end