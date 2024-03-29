# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  name            :string(45)
#  email           :string(45)
#  password_digest :string(72)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  secret          :string(60)
#  role_id         :bigint(8)
#

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:create_user) {
    create :role
    @user = create :user, password: 'secret'
  }

  describe 'validasi' do
    describe 'name' do
      it { should validate_presence_of :name }
      it { should validate_length_of(:name).is_at_least(6).is_at_most(45) }
    end

    describe "email" do
      it { should validate_presence_of :email }
      it { should validate_length_of(:email).is_at_least(6).is_at_most(45) }
      it { should validate_uniqueness_of :email }
    end

    describe "password" do
      it { should validate_presence_of :password }
      it { should validate_length_of(:password).is_at_least(6).is_at_most(72) }
    end
  end

  describe 'relasi' do
    it { should belong_to :role }
  end

  describe 'method test' do
    it 'generate token' do
      create_user
      token = @user.generate_token 'secret'
      expect {
        JWT.decode(token, Figaro.env.jwt_secret, Figaro.env.jwt_algorithm)
      }.not_to raise_error

      expect {
        JWT.decode(token, 'whateversecret', Figaro.env.jwt_algorithm)
      }.to raise_error JWT::VerificationError
    end

    it 'valid token?' do
      create_user
      token = @user.generate_token 'secret'
      false_token = token.dup + "whatever"
      expect(User.valid_token?(token)).to be true
      expect(User.valid_token?(false_token)).to be false
    end

    it 'active_token' do
      create_user
      token  = @user.generate_token 'secret'
      secret = JWT.decode(token, Figaro.env.jwt_secret, Figaro.env.jwt_algorithm)
      expect(User.first.secret).to eq secret[0]['user']['secret']
    end

    it 'update_secret' do
      create_user
      last_secret = @user.secret
      @user.update password: 'secret'
      expect(last_secret).not_to eq User.first.secret
    end

    it 'find_by_token' do
      create_user
      token = @user.generate_token 'secret'
      expect(User.find_by_token token).to eq @user
    end
  end
end
