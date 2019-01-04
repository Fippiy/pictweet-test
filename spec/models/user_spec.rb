require 'rails_helper'
describe User do
  describe '#create' do
    it "is invalid without a nickname" do
      # user = User.new(nickname: "", email: "", password:"00000000", password_confirmation: "00000000")
      # user = FactoryGirl.build(:user)
      user = build(:user, nickname: "")
      user.valid?
      expect(user.errors[:nickname]).to include("can't be blank")
    end
  end
end
