FactoryBot.define do
  factory :purchase_record_shipping_information do
    postal_code { '111-1111' }
    prefecture_id { 2 }
    municipality { '横浜市緑区' }
    address { '青山1−1−1'}
    building_name { '柳ビル' }
    phone_number { '08000008888' }
    token {"tok_abcdefghijk00000000000000000"}
  end
end
