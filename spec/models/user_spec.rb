require 'rails_helper'

describe User do
  let(:nickname) { 'テスト太郎' }
  let(:password) { '12345678' }

  describe '.first' do
    before do
      @user = create(:user, nickname: nickname, password: password, password_confirmation: password)
    end

    subject { described_class.first }

    it '事前に作成した通りのUserを返す' do
      expect(subject.nickname).to eq('テスト太郎')
      expect(subject.email).to eq(@user.email)
    end
  end

  describe 'validation' do
    describe 'nickname属性' do
      describe '文字数制限の検証' do
        context 'nicknameが20文字以下の場合' do
          let(:nickname) { 'あいうえおかきくけこさしすせそたちつてと' } # 20文字

          it 'User オブジェクトは有効である' do
            user = build(:user, nickname: nickname, password: password, password_confirmation: password)
            expect(user.valid?).to be(true)
          end
        end

        context 'nicknameが20文字を超える場合' do
          let(:nickname) { 'あいうえおかきくけこさしすせそたちつてとな' } # 21文字

          it 'User オブジェクトは無効である' do
            user = build(:user, nickname: nickname, password: password, password_confirmation: password)
            expect(user.valid?).to be(false)
            expect(user.errors[:nickname]).to include('is too long (maximum is 20 characters)')
          end
        end
      end
    end
  end
end
