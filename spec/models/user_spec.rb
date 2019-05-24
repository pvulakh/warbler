require 'rails_helper'

# testing a User, and it will be a model. 
# so we're testing the User model.
RSpec.describe User, type: :model do
  it { should validate_presence_of(:name) }
  it { should have_many(:warbles) }
  it { should validate_presence_of(:session_token) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_length_of(:password).is_at_least(6) }

  describe 'uniqueness' do
    before(:each) do
      # before each test in this describe block, we will create
      # a user from factory bot
      # persist it into the testing db.
      create(:user)
    end

    it { should validate_uniqueness_of(:session_token) }
  end

  describe '#is_password?' do
    let!(:user) { create(:user) }
    # let! will instantly create the user, before running the test.
    # let will create the user only when the test uses the user.
    context 'with valid password' do
      it 'should return true' do
        expect(user.is_password?('starwars')).to be(true)
      end
    end

    context 'with invalid password' do
      it 'should return false' do
        # to be will check the object id.
        expect(user.is_password?('startrek')).to be(false) 
      end
    end

  end
end