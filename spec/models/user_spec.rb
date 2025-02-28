require 'rails_helper'

RSpec.describe User, type: :model do
  let(:nickname) { 'テスト太郎' }
  let(:email) { 'test@example.com' }
  let(:password) { '12345678' }
  let(:user) { User.new(nickname: nickname, email: email, password: password, password_confirmation: password) }

  describe 'ユーザー登録' do
    it '有効なユーザーは登録可能' do
      expect(user).to be_valid
    end

    it 'nicknameが空の場合、エラーが発生する' do
      user.nickname = ''
      expect(user).not_to be_valid
      expect(user.errors[:nickname]).to include('ニックネームを入力してください')
    end

    it 'nicknameが20文字を超える場合、エラーが発生する' do
      user.nickname = 'あ' * 21
      expect(user).not_to be_valid
      expect(user.errors[:nickname]).to include('ニックネームは20文字以内で入力してください')
    end

    it 'emailが空の場合、エラーが発生する' do
      user.email = ''
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include('メールアドレスを入力してください')
    end

    it 'passwordが空の場合、エラーが発生する' do
      user.password = ''
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include('パスワードを入力してください')
    end

    it 'passwordが6文字未満の場合、エラーが発生する' do
      user.password = 'a' * 5
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include('パスワードは6文字以上で入力してください')
    end
  end
end
