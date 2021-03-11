class PurchaseRecordShippingInformation
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :municipality, :address, :building_name, :phone_number, :purchase_record, :user_id, :item_id

  with_options presence: true do
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :municipality
    validates :address
    validates :phone_number, numericality: { only_integer: true }, length: { maximum: 11 }
    validates :user_id
  end
  validates :prefecture_id, numericality: { other_than: 0 }
    
  def save
    purchase_record = PurchaseRecord.create(user_id: user_id, item_id: item_id)
    ShippingInformation.create(postal_code: postal_code, prefecture_id: prefecture_id, municipality: municipality, address: address, building_name: building_name, phone_number: phone_number, purchase_record: purchase_record, purchase_record_id: purchase_record.id)
  end
end