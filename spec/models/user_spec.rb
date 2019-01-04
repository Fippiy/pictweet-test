require 'rails_helper'
describe User do
  describe '#create' do

    # 全入力で登録できること
    it "is valid with a nickname,email, password, password_confirmation" do
      user = build(:user)
      # user.valid?
      expect(user).to be_valid
    end

    # nicknameが空でNG
    it "is invalid without a nickname" do
      # user = build(:user, nickname: "")
      user = build(:user, nickname: nil)
      user.valid?
      expect(user.errors[:nickname]).to include("can't be blank")
    end

    # emailが空でNG
    it "is invalid without a email" do
      # user = build(:user, email: "")
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    # passwordが空でNG
    it "is invalid without a password" do
      # user = build(:user, password: "")
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    # passwordありでconfirmationが空でNG
    it "is invalid without a password_confirmation although with a password" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    # nicknameが7文字以上でNG
    it "is invalid over 7 byte nickname" do
      user = build(:user, nickname: "abcdefg")
      user.valid?
      # expect(user.errors[:nickname]).to include("is too long (maximum is 6 characters)")
      expect(user.errors[:nickname][0]).to include("is too long")
    end

    # nicknameが6文字以下でOK
    it "is invalid under 6 byte nickname" do
      user = build(:user, nickname: "abcde")
      expect(user).to be_valid
    end

    # 重複emailでNG
    it "is invalid multiple email" do
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("has already been taken")
    end

    # passwordが6文字以上でOK
    it "is invalid over 6 byte password" do
      user = build(:user, password: "123456", password_confirmation: "123456")
      expect(user).to be_valid
    end

    # passwordが5文字以下でNG
    it "is invalid under 5 byte password" do
      user = build(:user, password: "12345", password_confirmation: "12345")
      user.valid?
      # expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
      expect(user.errors[:password][0]).to include("is too short")
    end

  end
end
