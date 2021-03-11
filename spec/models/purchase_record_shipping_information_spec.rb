require 'rails_helper'

RSpec.describe PurchaseRecordShippingInformation, type: :model do
  describe '購入情報の保存' do
    before do
      user = FactoryBot.create(:user)
      @purchase_record_shipping_information = FactoryBot.build(:purchase_record_shipping_information, user_id: user.id)
    end

    context '購入ができない時' do
      it '配送先の情報として、郵便番号が必須であること' do
        @purchase_record_shipping_information.postal_code = ' '
        @purchase_record_shipping_information.valid?
        expect(@purchase_record_shipping_information.errors.full_messages).to include("Postal code can't be blank")
      end

      it '配送先の情報として、都道府県が必須であること' do
        @purchase_record_shipping_information.prefecture_id = 0
        @purchase_record_shipping_information.valid?
        expect(@purchase_record_shipping_information.errors.full_messages).to include('Prefecture must be other than 0')
      end

      it '配送先の情報として、市区町村が必須であること' do
        @purchase_record_shipping_information.municipality = ' '
        @purchase_record_shipping_information.valid?
        expect(@purchase_record_shipping_information.errors.full_messages).to include("Municipality can't be blank")
      end

      it '配送先の情報として、番地が必須であること' do
        @purchase_record_shipping_information.address = ' '
        @purchase_record_shipping_information.valid?
        expect(@purchase_record_shipping_information.errors.full_messages).to include("Address can't be blank")
      end

      it '配送先の情報として、電話番号が必須であること' do
        @purchase_record_shipping_information.phone_number = ' '
        @purchase_record_shipping_information.valid?
        expect(@purchase_record_shipping_information.errors.full_messages).to include("Phone number can't be blank")
      end

      it '郵便番号の保存にはハイフンが必要であること（123-4567となる）' do
        @purchase_record_shipping_information.postal_code = '1111111'
        @purchase_record_shipping_information.valid?
        expect(@purchase_record_shipping_information.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end

      it '電話番号は英数混合では登録できないこと' do
        @purchase_record_shipping_information.phone_number = '111aaaa1111'
        @purchase_record_shipping_information.valid?
        expect(@purchase_record_shipping_information.errors.full_messages).to include('Phone number is not a number')
      end

      it '電話番号は空では登録できないこと' do
        @purchase_record_shipping_information.phone_number = ' '
        @purchase_record_shipping_information.valid?
        expect(@purchase_record_shipping_information.errors.full_messages).to include("Phone number can't be blank")
      end

      it 'tokenが空では登録できないこと' do
        @purchase_record_shipping_information.token = nil
        @purchase_record_shipping_information.valid?
        expect(@purchase_record_shipping_information.errors.full_messages).to include("Token can't be blank")
      end

      it 'tokenが空では登録できないこと' do
        @purchase_record_shipping_information.user_id = " "
        @purchase_record_shipping_information.valid?
        expect(@purchase_record_shipping_information.errors.full_messages).to include("User can't be blank")
      end

      it 'tokenが空では登録できないこと' do
        @purchase_record_shipping_information.item_id = " "
        @purchase_record_shipping_information.valid?
        expect(@purchase_record_shipping_information.errors.full_messages).to include("Item can't be blank")
      end
    end

    context '購入ができる時' do
      it '配送先の情報として、ビル名がなくても保存可能なこと' do
        @purchase_record_shipping_information.building_name = ' '
        expect(@purchase_record_shipping_information).to be_valid
      end
      
      it '全ての情報が揃っている場合は保存可能なこと' do
        expect(@purchase_record_shipping_information).to be_valid
      end
    end
  end
end
