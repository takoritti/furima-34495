class Item < ApplicationRecord

  with_options presence: true do
    validates :name
    validates :information
    validates :category_id
    validates :status_id
    validates :shipping_fee_id
    validates :prefecture_id
    validates :shipping_day_id
    validates :price
    validates :shipping_day_id
    validates :shipping_day_id
    validates :shipping_day_id
  end
  
end
