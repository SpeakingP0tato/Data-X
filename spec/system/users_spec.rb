require 'rails_helper'

Capybara.default_driver = :selenium_chrome

describe 'ユーザー登録', type: :system do
  before do
    driven_by(:selenium_chrome_headless)
  end

  let(:nickname) { 'テスト太郎' }
  let(:email) { 'test@example.com' }
  let(:password) { 'password' }
  let(:password_confirmation) { password }

  subject do
    visit new_user_registration_path
    fill_in 'user_nickname', with: nickname
    fill_in 'user_email', with: email
    fill_in 'user_password', with: password
    fill_in 'user_password_confirmation', with: password_confirmation
    click_button 'ユーザー登録'
  end

  context '異常系' do
    context 'nicknameが空の場合' do
      let(:nickname) { '' }
      it 'ユーザーを作成せず、エラーメッセージを表示する' do
        expect { subject }.not_to change(User, :count)
        expect(page).to have_content('ニックネームを入力してください')
      end
    end

    context 'nicknameが20文字を超える場合' do
      let(:nickname) { 'あ' * 21 }
      it 'ユーザーを作成せず、エラーメッセージを表示する' do
        expect { subject }.not_to change(User, :count)
        expect(page).to have_content(/ニックネーム(を入力してください|は20文字以内で入力してください)/)
      end
    end

    context 'emailが空の場合' do
      let(:email) { '' }
      it 'ユーザーを作成せず、エラーメッセージを表示する' do
        expect { subject }.not_to change(User, :count)
        expect(page).to have_content('メールアドレスを入力してください')
      end
    end

    context 'passwordが空の場合' do
      let(:password) { '' }
      it 'ユーザーを作成せず、エラーメッセージを表示する' do
        expect { subject }.not_to change(User, :count)
        expect(page).to have_content('パスワードを入力してください')
      end
    end

    context 'passwordが6文字未満の場合' do
      let(:password) { 'a' * 5 }
      it 'ユーザーを作成せず、エラーメッセージを表示する' do
        expect { subject }.not_to change(User, :count)
        expect(page).to have_content('パスワードは6文字以上で入力してください')
      end
    end

    context 'passwordが128文字を超える場合' do
      let(:password) { 'a' * 129 }
      it 'ユーザーを作成せず、エラーメッセージを表示する' do
        expect { subject }.not_to change(User, :count)
        expect(page).to have_content('パスワードは128文字以内で入力してください')
      end
    end

    context 'passwordとpassword_confirmationが一致しない場合' do
      let(:password_confirmation) { "#{password}hoge" }
      it 'ユーザーを作成せず、エラーメッセージを表示する' do
        expect { subject }.not_to change(User, :count)
        expect(page).to have_content('確認用パスワードが一致しません')
      end
    end
  end
end

describe 'ログイン機能の検証', type: :system do
  let(:nickname) { 'テスト太郎' }
  let(:email) { 'test@example.com' }
  let(:password) { 'password' }

  before do
    driven_by(:selenium_chrome_headless)
  end

  before do
    User.create!(nickname: nickname, email: email, password: password, password_confirmation: password)
  end

  context '正常系' do
    it 'ログインに成功し、トップページにリダイレクトする' do
      visit '/users/sign_in'
      fill_in 'user_email', with: email
      fill_in 'user_password', with: password
      click_button 'ログイン'

      expect(page).to have_current_path(root_path, ignore_query: true)
    end

    it 'ログイン成功時にフラッシュメッセージが表示される' do
      visit '/users/sign_in'
      fill_in 'user_email', with: email
      fill_in 'user_password', with: password
      click_button 'ログイン'
    
      puts "ログイン後の現在のページHTML: #{page.html}"  
    
      expect(page).to have_xpath("//div[contains(@class, 'alert')]", text: 'ログインに成功しました', wait: 15)
    end    
  end

  context '異常系' do
    it 'ログインに失敗し、ページ遷移しない' do
      visit '/users/sign_in'
      fill_in 'user_email', with: email
      fill_in 'user_password', with: 'wrongpassword'
      click_button 'ログイン'

      sleep 2  
      puts "Page HTML: #{page.html}"

      expect(page).to have_css('.alert', text: 'ログインに成功しました', wait: 15)
      expect(flash_message).to be_present
    end

    it 'ログイン成功時のフラッシュメッセージを表示する' do
      visit '/users/sign_in'

      fill_in 'user_email', with: email
      fill_in 'user_password', with: password
      click_button 'ログイン'

      sleep 2  
      puts "Page HTML: #{page.html}"

      expect(page).to have_xpath("//div[contains(@class, 'alert')]", text: 'メールアドレスまたはパスワードが違います。', wait: 15)
      expect(page).to have_css('.alert', text: 'ログインに成功しました', wait: 5)
    end

    it 'ログイン成功後にフラッシュメッセージが表示されるか確認' do
      visit '/'
      flash_messages = begin
        find('#flash-messages', visible: :all).text
      rescue StandardError
        'No flash'
      end
      puts "Current Page HTML after login: #{page.html}"
    end
  end
end
