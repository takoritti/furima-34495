FactoryBot.define do
  factory :item do
    association :user

    name { 'aaaa' }
    information { 'aaaa' }
    category_id { 1 }
    status_id { 1 }
    shipping_fee_id { 1 }
    prefecture_id { 1 }
    shipping_day_id { 1 }
    price { 10_000 }

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
