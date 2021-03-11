require 'rails_helper'

RSpec.describe PurchaseRecordShippingInformation, type: :model do
  describe '購入情報の保存' do
    before do
      user = FactoryBot.create(:user)
      @purchase_record_shipping_information = FactoryBot.build(:purchase_record_shipping_information, user_id: user.id)
    end

    context '新規登録ができない時' do
    
    it '配送先の情報として、郵便番号が必須であること' do
      @purchase_record_shipping_information.postal_code = ' '
      @purchase_record_shipping_information.valid?
      expect(@purchase_record_shipping_information.errors.full_messages).to include("Postal code can't be blank")
    end

      it '配送先の情報として、都道府県が必須であること' do
        @purchase_record_shipping_information.prefecture_id = 0
        @purchase_record_shipping_information.valid?
        expect(@purchase_record_shipping_information.errors.full_messages).to include("Prefecture must be other than 0")
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
        expect(@purchase_record_shipping_information.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end

      it '電話番号は11桁以内の数値のみ保存可能なこと（09012345678となる）' do
        @purchase_record_shipping_information.phone_number = '111111111111'
        @purchase_record_shipping_information.valid?
        expect(@purchase_record_shipping_information.errors.full_messages).to include("Phone number is too long (maximum is 11 characters)")
      end

      it '電話番号は11桁以内の数値のみ保存可能なこと（09012345678となる）' do
        @purchase_record_shipping_information.phone_number = '111111111111'
        @purchase_record_shipping_information.valid?
        expect(@purchase_record_shipping_information.errors.full_messages).to include("Phone number is too long (maximum is 11 characters)")
      end
    end

    context '新規登録ができる時' do

      it '配送先の情報として、ビル名がなくても保存可能なこと' do
        @purchase_record_shipping_information.building_name = ' '
        expect(@purchase_record_shipping_information).to be_valid
      end
    end
  end
end
