FactoryBot.define do
  factory :user do
    nickname { 'テスト太郎' }
    sequence(:email) { |n| "test#{n}@example.com" } 
    password { '111111' }
    password_confirmation { '111111' }
  end
end
