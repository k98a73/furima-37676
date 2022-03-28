FactoryBot.define do
  factory :user do
    nickname { Faker::Internet.username }
    email { Faker::Internet.free_email }
    password { 'test12345' }
    password_confirmation { password }
    last_name { '山田' }
    first_name { '隆太郎' }
    last_name_kana { 'ヤマダ' }
    first_name_kana { 'リクタロウ' }
    birth_date { Faker::Date.birthday(min_age: 18, max_age: 65) }
  end
end
