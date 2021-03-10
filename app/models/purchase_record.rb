class PurchaseRecord < ApplicationRecord
  has_one :shipping_information
  belongs_to :item
  belongs_to :user
end
