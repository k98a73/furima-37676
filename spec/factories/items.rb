FactoryBot.define do
  factory :item do
    item_name { Faker::Name.initials(number: 2) }
    description { 'description' }
    category_id     { 2 }
    condition_id    { 2 }
    postage_id      { 2 }
    prefecture_id   { 2 }
    days_to_ship_id { 2 }
    price           { 300 }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
