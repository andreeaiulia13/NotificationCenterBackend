require 'rails_helper'

RSpec.describe User, :type => :model do
  context 'with a missing or invalid parameter' do 
		it 'is not valid without an email' do 
      user = User.new(email: nil)
      expect(user).to_not be_valid
		end

		it 'is not valid without a valid email' do 
      user = User.new(email: 'abcd', password: '123456')
      expect(user).to_not be_valid
		end

		it 'is not valid without a password' do 
      user = User.new(email: 'email@gmail')
      expect(user).to_not be_valid
		end

		it 'is not valid with a password shorter than 6 characters' do 
      user = User.new(email: 'email@gmail', password: '12345')
      expect(user).to_not be_valid
		end

		it 'is not valid with a taken email' do 
			User.create(email: 'email@gmail', password: '123456')
      user = User.new(email: 'email@gmail', password: '123456')

      expect(user).to_not be_valid
		end
  end

	context 'with all the required parameters' do
    it 'puts admin false by default' do 
      user = User.create(email: 'email@gmail.com', password: '123456')
			expect(user.admin).to eq(false)
		end

		it 'puts admin true if that is specified' do 
      user = User.create(email: 'email@gmail.com', password: '123456', admin: true)
			expect(user.admin).to eq(true)
		end
	end
end
