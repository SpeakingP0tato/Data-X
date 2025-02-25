require 'rails_helper'

RSpec.describe 'Home', type: :system do
  before do
    driven_by :rack_test # 기본 Rack Test 드라이버 사용
  end

  describe 'トップページの検証' do
    it 'Home#top という文字列が表示される' do
      visit '/'

      expect(page).to have_content('Home#top')
    end
  end
end

RSpec.describe 'Home', type: :system do
  before do
    driven_by :selenium_chrome_headless # Selenium + Chrome 헤드리스 사용
  end

  describe 'トップページの検証（ヘッドレス）' do
    it 'Home#top という文字列が表示される' do
      visit '/'

      expect(page).to have_content('Home#top')
    end
  end
end
