require 'rails_helper'

RSpec.describe 'Home', type: :system do
  before do # ここから追記
    driven_by :selenium_chrome_headless
  end # ここまで追記

  describe 'トップページの検証' do
    it 'Home#top という文字列が表示される' do
      visit '/'

      expect(page).to have_content('Home#top')
    end
  end
end